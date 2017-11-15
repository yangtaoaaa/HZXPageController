//
//  RXGeneSign.m
//  RenXing
//
//  Created by ycmedia_imac on 16/7/12.
//  Copyright © 2016年 ycmedia_imac. All rights reserved.
//

#import "RXGeneSign.h"

@implementation RXGeneSign

// 拼接字符串
+ (NSString *)geneSignWithDictionary:(NSDictionary *)dict{
    NSString *signStr = [[NSString alloc]init];
    for(NSString *key in dict){
        signStr = [NSString stringWithFormat:@"%@%@=%@&",signStr, key, [dict objectForKey:key]];
    }
    // 时间戳 TimeStamp  2017-07-31 18:24:06
    signStr = [NSString stringWithFormat:@"%@&TimeStamp=2017-07-31 18:24:06&ApiSecret=RENMIANBUZHIHECHUQUTAOHUAYIJIUXIAOCHUNFENG", signStr];
    //signStr = [NSString stringWithFormat:@"%@&ApiSecret=RENMIANBUZHIHECHUQUTAOHUAYIJIUXIAOCHUNFENG", signStr];
    return [self geneCapStr:signStr];
}

+ (NSString *)geneSignWithStr:(NSString *)str{
    NSString *signStr = [NSString stringWithFormat:@"%@RENMIANBUZHIHECHUQUTAOHUAYIJIUXIAOCHUNFENG", str];
    HZXLog(@"拼接后的字符串%@", signStr);
    return [self geneMd5Str:signStr];
}

// 对字符串----MD5加密
+ (NSString *)geneMd5Str:(NSString *)str{
    //HZXLog(@"对字符串url编码:%@", encodeSignStr);
    NSString *capitalEncodeStr = [str uppercaseString];  //转换成大写
    // 进行MD5加密
    NSString *md5Str = [RXMD5 md5:capitalEncodeStr];
    //HZXLog(@"对字符串进行MD5加密：%@", md5Str);
    NSString *capMD5SignStr = [md5Str uppercaseString]; //转换成大写
    //HZXLog(@"对字符串转成大写:%@", capMD5SignStr);
    return capMD5SignStr;
}

// 对字符串----url编码---MD5加密---大写
+ (NSString *)geneCapStr:(NSString *)str{
    // 对字符串进行url编码
    NSString *encodeSignStr = [RXMD5 encodeToPercentEscapeString:str];
    //HZXLog(@"对字符串url编码:%@", encodeSignStr);
    NSString *capitalEncodeStr = [encodeSignStr uppercaseString];  //转换成大写
    // 进行MD5加密
    NSString *md5Str = [RXMD5 md5:capitalEncodeStr];
    //HZXLog(@"对字符串进行MD5加密：%@", md5Str);
    NSString *capMD5SignStr = [md5Str uppercaseString]; //转换成大写
//    HZXLog(@"对字符串转成大写:%@", capMD5SignStr);
    return capMD5SignStr;
}




@end




