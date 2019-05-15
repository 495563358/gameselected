//
//  NSString+DecimalNumber.m
//  yicai
//
//  Created by oops on 2019/1/11.
//  Copyright © 2019 defuya. All rights reserved.
//

#import "NSString+DecimalNumber.h"

@implementation NSString(NSString_DecimalNumber)
+(NSString *)A:(NSString *)a jiaB:(NSString *)b;{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *resultNum = [num1 decimalNumberByAdding:num2];
    return [resultNum stringValue];
}
+(NSString *)A:(NSString *)a jianB:(NSString *)b;{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *resultNum = [num1 decimalNumberBySubtracting:num2];
    return [resultNum stringValue];
}
+(NSString *)A:(NSString *)a chengyiB:(NSString *)b;{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *resultNum = [num1 decimalNumberByMultiplyingBy:num2];
    return [resultNum stringValue];
}
+(NSString *)A:(NSString *)a chuyiB:(NSString *)b;{
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:b];
    NSDecimalNumber *resultNum = [num1 decimalNumberByDividingBy:num2];
    return [resultNum stringValue];
}
+(BOOL)A:(NSString *)a dayuB:(NSString *)b;{
    NSDecimalNumber *discount1 = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *discount2 = [NSDecimalNumber decimalNumberWithString:b];
    NSComparisonResult result = [discount1 compare:discount2];
    if (result == NSOrderedAscending) {
        return NO;
    } else if (result == NSOrderedSame) {
        return NO;
    } else if (result == NSOrderedDescending) {
        return YES;
    }
    return NO;
    
}
+(BOOL)A:(NSString *)a dengyuB:(NSString *)b;{
    NSDecimalNumber *discount1 = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *discount2 = [NSDecimalNumber decimalNumberWithString:b];
    NSComparisonResult result = [discount1 compare:discount2];
    if (result == NSOrderedAscending) {
        return NO;
    } else if (result == NSOrderedSame) {
        return YES;
    } else if (result == NSOrderedDescending) {
        return NO;
    }
    return NO;
    
}
+(BOOL)A:(NSString *)a xiaoyuB:(NSString *)b;{
    NSDecimalNumber *discount1 = [NSDecimalNumber decimalNumberWithString:a];
    NSDecimalNumber *discount2 = [NSDecimalNumber decimalNumberWithString:b];
    NSComparisonResult result = [discount1 compare:discount2];
    if (result == NSOrderedAscending) {
        return YES;
    } else if (result == NSOrderedSame) {
        return NO;
    } else if (result == NSOrderedDescending) {
        return NO;
    }
    return NO;
    
}


- (NSString *)chineseToUTF8{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

-(NSString *)utf8StrToChinese{
    return [self stringByRemovingPercentEncoding];
}

- (NSString *)utf8ToUnicode{
    NSUInteger length = [self length];
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++){
        NSMutableString *s = [NSMutableString stringWithCapacity:0];
        unichar _char = [self characterAtIndex:i];
        // 判断是否为英文和数字
        if (_char <= '9' && _char >='0'){
            [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i,1)]];
        }else if(_char >='a' && _char <= 'z'){
            [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i,1)]];
        }else if(_char >='A' && _char <= 'Z')
        {
            [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i,1)]];
        }else{
            // 中文和字符
            [s appendFormat:@"\\u%x",[self characterAtIndex:i]];
            // 不足位数补0 否则解码不成功
            if(s.length == 4) {
                [s insertString:@"00" atIndex:2];
            } else if (s.length == 5) {
                [s insertString:@"0" atIndex:2];
            }
        }
        [str appendFormat:@"%@", s];
    }
    return str;
    
    
}

@end
