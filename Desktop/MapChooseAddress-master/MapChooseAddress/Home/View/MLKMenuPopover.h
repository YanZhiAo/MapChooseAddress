//
//  MLKMenuPopover.h
//  MLKMenuPopover
//
//  Created by NagaMalleswar on 20/11/14.
//  Copyright (c) 2014 NagaMalleswar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLKMenuPopover;

@protocol MLKMenuPopoverDelegate <NSObject>

@optional
- (void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex;
- (void)menuPopoverHide:(MLKMenuPopover *)menuPopover;
@end

@interface MLKMenuPopover : UIView <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign) id<MLKMenuPopoverDelegate> menuPopoverDelegate;

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)menuItems menuImages:(NSArray *)menuImages;
- (void)showInView:(UIView *)view;
- (void)dismissMenuPopover;
- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
