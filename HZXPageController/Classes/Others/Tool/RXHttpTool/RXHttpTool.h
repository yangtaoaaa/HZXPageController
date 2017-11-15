//
//  RXHttpTool.h
//  RenXing
//
//  Created by ycmedia_imac on 16/7/12.
//  Copyright © 2016年 ycmedia_imac. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MJExtension.h"


@interface RXHttpTool : NSObject

@property (nonatomic, copy) NSString *currUserUUIDStr;

+ (RXHttpTool *)shareInstance;
/**
 * 发送一个POST请求
 *
 *  @param url     请求路径
 *  @param dict    请求参数
 *  @Param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
- (void)postWithUrl:(NSString *)url body:(NSDictionary *)dict  success:(void (^)(id))success failure:(void (^)(id))failure;

- (void)testPostWithUrl:(NSString *)url body:(NSDictionary *)dict  success:(void (^)(id))success failure:(void (^)(id))failure;
//- (void)postWithParams:(NSDictionary *)params success:(void (^)(id json)) success failure:(void (^)(NSError *error))failure;
//
//- (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
//
//- (void)postWithURLAndStr:(NSString *)url params:(NSString *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//
//- (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;



@end
