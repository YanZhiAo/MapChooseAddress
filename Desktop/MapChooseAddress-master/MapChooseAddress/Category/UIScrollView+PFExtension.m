//
//  UIScrollView+PFExtension.m
//  宠物寻找
//
//  Created by huajian ma on 2017/10/30.
//  Copyright © 2017年 lulu. All rights reserved.
//

#import "UIScrollView+PFExtension.h"

@implementation UIScrollView (PFExtension)
+(void)load
{
    #ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)){
        [[self appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        
    }
   
    else
    {
        [[self appearance] setAutomaticallyAdjustsScrollViewInsets:NO];
    }
#endif
}
-(void)ScrollViewInsetAdjustmentNever
{
    #ifdef __IPHONE_11_0
    
    if (@available(iOS 11.0, *)){
        [self setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        
    }
    
    #endif
}
@end
