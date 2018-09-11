//
//  NSString+PKExtension.m
//  Park
//
//  Created by Caesar on 15/7/13.
//  Copyright (c) 2015年 EXMobile. All rights reserved.
//

#import "NSString+PKExtension.h"
#import <UIKit/UIKit.h>
@implementation NSString (PKExtension)
+(instancetype)randomWithCount:(NSInteger)count

{
    NSMutableString *temp=[NSMutableString string];
    for (int i=0; i<count; i++) {
        int i=arc4random()%10;
        [temp appendFormat:@"%d",i];
        
    }
    return [NSString stringWithString:temp];
}
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


-(BOOL)isWeiXin
{
    
    return [self match:@"^[a-zA-Z\\d_]{5,}$"];
}
-(BOOL)isPlateNumber
{
    
    return [self match:@"^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$"];
}
-(BOOL)isIdCard
{
    return [self match:@"^[1-9]\\d{5[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$"];
}
-(BOOL)isPhoneNumber
{
   

     return [self match:@"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$"];
}
-(BOOL)isEmail
{
        
    return [self match:@"^\\s*\\w+(?:\\.{0,1}[\\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\\.[a-zA-Z]+\\s*$"];
}
- (BOOL)match:(NSString *)pattern
{
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}
@end
