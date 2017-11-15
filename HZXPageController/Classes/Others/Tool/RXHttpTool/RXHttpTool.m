//
//  RXHttpTool.m
//  RenXing
//
//  Created by ycmedia_imac on 16/7/12.
//  Copyright © 2016年 ycmedia_imac. All rights reserved.
//

#import "RXHttpTool.h"
#import "AFNetworking.h"
#import "Encryption.h"

@implementation RXHttpTool

+ (RXHttpTool *)shareInstance{
    static RXHttpTool *shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[[self class]alloc]init];
    });
    return shareInstance;
}
// AFN3.0  body以Json格式传递
//- (void)testPostWithUrl:(NSString *)url body:(NSData *)body success:(void ()
/**
 *  异步POST请求:以body方式,支持数组
 *
 *  @param url     请求的url
 *  @param dict    body数据
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)postWithUrl:(NSString *)url body:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(id))failure
{
    //timestamp
    NSDate *now = [NSDate date];
    // 1.创建一个时间格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 2.设置时间格式化对象的样式
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 3.利用时间格式化对象对时间进行格式化
    NSString *timestamp = [formatter stringFromDate:now];
    NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [newDict setValue:timestamp forKey:@"TimeStamp"];
    
    NSString *jsonStr = [NSString dictionaryToJson:newDict];
    NSString *beforSignStr = [NSString stringWithFormat:@"%@%@",jsonStr,@"RENMIANBUZHIHECHUQUTAOHUAYIJIUXIAOCHUNFENG"];
    NSString *signStr = [Encryption md5:beforSignStr];
    
    NSString *newUrl;
    //判断之前URL是否已经含有参数
    if ([url containsString:@"?"]) {
        newUrl = [NSString stringWithFormat:@"%@&Sign=%@",url,signStr];
    }else{
        newUrl = [NSString stringWithFormat:@"%@?Sign=%@",url,signStr];
    }
    
    NSData *body= [NSJSONSerialization dataWithJSONObject:newDict options:NSJSONWritingPrettyPrinted error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:newUrl parameters:nil error:nil];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 设置body
    [request setHTTPBody:body];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
//    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
    manager.responseSerializer = responseSerializer;
    
    // 设置返回格式
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
            success(json);
        } else {
            failure(error);
        }
    }] resume];
}

// 测试一个下载
- (void)testPostWithUrl:(NSString *)url body:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(id))failure
{
    NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [newDict setValue:@"00" forKey:@"TimeStamp"];
    NSString *newUrl;
    //判断之前URL是否已经含有参数
    if ([url containsString:@"?"]) {
        newUrl = [NSString stringWithFormat:@"%@",url];
    }else{
        newUrl = [NSString stringWithFormat:@"%@",url];
    }
    
    NSData *body= [NSJSONSerialization dataWithJSONObject:newDict options:NSJSONWritingPrettyPrinted error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:newUrl parameters:nil error:nil];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 设置body
    //[request setHTTPBody:body];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    //    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
    manager.responseSerializer = responseSerializer;
    
    // 设置返回格式
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
            success(json);
        } else {
            failure(error);
        }
    }] resume];
}

/*// 测试用
- (void)postWithParams:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil]; //设置相应内容类型
    
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 发送请求
    NSDictionary *dict = @{
                           @"id":@"idididid",
                           @"channel":@"channelstrstr",
                           @"childChannel":@"childChannel",
                           @"version":[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"],
                           };
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [tempDict addEntriesFromDictionary:params];
    [manager POST:preAddress parameters:tempDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure){
            failure(error);
            
            HZXLog(@"网络不好 - YZHttpTool：%@",[NSString stringWithFormat:@"cmd=%@,error=%@",params[@"cmd"],error]);
            
            NSNumber *cmd = tempDict[@"cmd"];
            NSNumber *cmd1 = @(8026);
            NSNumber *cmd2 = @(8027);
            NSNumber *cmd3 = @(8028);
            
            if( !([cmd isEqualToNumber:cmd1] || [cmd isEqualToNumber:cmd2] || [cmd isEqualToNumber:cmd3]))//这俩个接口，获取不到数据会每秒提醒一次，故不提醒
            {
                [MBProgressHUD showError:@"亲！网络不给力"];
                HZXLog(@"cmd = %@",tempDict[@"cmd"]);
            }
        }
    }];
}

- (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
//    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 测试  {"LoginName":"13880051741","LoginPwd":"123456","TimeStamp":"2017-08-09 15:50:00"}
    NSDictionary *json = [NSDictionary dictionary];
    NSString *str = [NSString stringWithFormat:@"{\"LoginName\":\"%@\",\"LoginPwd\":\"%@\",\"TimeStamp\":\"%@\"}",  @"13880051741", @"123456", @"2017-08-09 15:50:00"];
    json = @{
             @"json":str,
             
             };
    NSLog(@"post调试%@",json);
    NSLog(@"字典转Json====%@", [NSString dictionaryToJson:params]);
    str = @"{\"LoginName\":\"13880051741\",\"LoginPwd\":\"123456\",\"TimeStamp\":\"2017-08-09 15:50:00\"}";
    // 发送请求
    [manager POST:url parameters:str success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure) {
            failure(error);
            HZXLog(@"请求失败----------%@", error);
        }
    }];
    
    
}

- (void)postWithURLAndStr:(NSString *)url params:(NSString *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 发送请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure){
            failure(error);
        }
    }];
}

- (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    // 发送请求
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure){
            failure(error);
        }
    }];
}*/





@end




