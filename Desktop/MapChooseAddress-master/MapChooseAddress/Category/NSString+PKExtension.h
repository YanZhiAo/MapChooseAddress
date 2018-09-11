//
//  NSString+PKExtension.h
//  Park
//
//  Created by Caesar on 15/7/13.
//  Copyright (c) 2015年 EXMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (PKExtension)
//+(NSAttributedString *)attributedTextWithText:(NSString *)text;
/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
/**
 *  是否是电话号码
 *
 *  @return <#return value description#>
 */
-(BOOL)isPhoneNumber;
/**
 *  是否是邮箱
 *
 *  @return <#return value description#>
 */
-(BOOL)isEmail;
/**
 *  是否是微信号
 *
 *  @return <#return value description#>
 */
-(BOOL)isWeiXin;
/**
 *  是否是车牌号
 *
 *  @return <#return value description#>
 */
-(BOOL)isPlateNumber;
/**
 *  是否是身份证
 *
 *  @return <#return value description#>
 */
-(BOOL)isIdCard;
+(instancetype)randomWithCount:(NSInteger)count;

@end
