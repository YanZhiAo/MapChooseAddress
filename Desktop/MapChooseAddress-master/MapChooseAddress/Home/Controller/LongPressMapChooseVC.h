//
//  LongPressMapChooseVC.h
//  MapChooseAddress
//
//  Created by mac on 2018/9/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "PKViewController.h"

@protocol LongPressMapChooseVCDelegate <NSObject>

@optional
//AMapGeoPoint *location
//AMapReGeocode *regeocode;
-(void)LongPressMapDidClickGeoPoint:(AMapGeoPoint *)location regeocode:(NSString *)address Province:(NSString *)province City:(NSString *)city;

@end

@interface LongPressMapChooseVC : PKViewController
@property(nonatomic,weak)id<LongPressMapChooseVCDelegate>delegate;
@end
