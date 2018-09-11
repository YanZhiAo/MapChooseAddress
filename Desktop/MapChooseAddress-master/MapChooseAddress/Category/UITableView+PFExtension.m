//
//  UITableView+PFExtension.m
//  宠物寻找
//
//  Created by huajian ma on 2017/10/30.
//  Copyright © 2017年 lulu. All rights reserved.
//

#import "UITableView+PFExtension.h"

@implementation UITableView (PFExtension)
+(void)load
{

#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)){
        
        [[self appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        [[self appearance] setEstimatedRowHeight:0];
        [[self appearance] setEstimatedSectionHeaderHeight:0];
        [[self appearance] setEstimatedSectionFooterHeight:0];
    }
    else
    {
        [[self appearance] setAutomaticallyAdjustsScrollViewInsets:NO];
    }
#endif
}
-(void)tableHeaderHeight
{
    #ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)){
        
        [self setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        [self setEstimatedRowHeight:0];
        [self setEstimatedSectionHeaderHeight:0];
        [self setEstimatedSectionFooterHeight:0];
    }
    #endif
}
@end
