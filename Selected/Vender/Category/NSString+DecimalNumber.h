//
//  NSString+DecimalNumber.h
//  yicai
//
//  Created by oops on 2019/1/11.
//  Copyright © 2019 defuya. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString(NSString_DecimalNumber)

+(NSString *)A:(NSString *)a jiaB:(NSString *)b;
+(NSString *)A:(NSString *)a jianB:(NSString *)b;
+(NSString *)A:(NSString *)a chengyiB:(NSString *)b;
+(NSString *)A:(NSString *)a chuyiB:(NSString *)b;
+(BOOL)A:(NSString *)a dayuB:(NSString *)b;
+(BOOL)A:(NSString *)a dengyuB:(NSString *)b;
+(BOOL)A:(NSString *)a xiaoyuB:(NSString *)b;

- (NSString *)chineseToUTF8;
- (NSString *)utf8StrToChinese;
- (NSString *)utf8ToUnicode;

@end

NS_ASSUME_NONNULL_END
