//
//  MapInclude.h
//  MapChooseAddress
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#ifndef MapInclude_h
#define MapInclude_h

#define YMColor(R,G,B) [UIColor colorWithRed:(R/255.00) green:(G/255.00) blue:(B/255.00) alpha:1.0]
//16精制颜色
#define UIColorFromRGBWithOX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define color2EBDA0 UIColorFromRGBWithOX(0x2EBDA0)//导航栏颜色
#define colorf7f7f7 UIColorFromRGBWithOX(0xf7f7f7)//页面背景颜色
#define color333333 UIColorFromRGBWithOX(0x333333)
#define color666666 UIColorFromRGBWithOX(0x666666)
#define color999999 UIColorFromRGBWithOX(0x999999)

#define iPhoneX CGSizeEqualToSize(CGSizeMake(375, 812), [[UIScreen mainScreen] bounds].size)

// 系统控件默认高度
#define HeightNavBar     (iPhoneX? (88.f):(64.f))
#define HeightSafeAreaofTabBar (iPhoneX?  34 : 0)
#define HeightofiPhoneXNavDifferent (iPhoneX?  24 : 0)

#define HeightStatusBar   (iPhoneX?(44.f):(20.f))
#define HeightTabBar      (iPhoneX? (83.f):(49.f))
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

#import "PKNavigationController.h"
#import "PKViewController.h"
#import "PFAPP.h"

#import "SVProgressHUD.h"

#import "NSString+PKExtension.h"
#import "UIScrollView+PFExtension.h"
#import "UITableView+PFExtension.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

//高德地图
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#endif /* MapInclude_h */


