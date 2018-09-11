//
//  MapChooseAddressVC.h
//  MapChooseAddress
//
//  Created by mac on 2018/9/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "PKViewController.h"

@protocol MapChooseAddressVCDelegate <NSObject>

@optional
//AMapGeoPoint *location
//AMapReGeocode *regeocode;
-(void)addressDidClickGeoPoint:(AMapGeoPoint *)location regeocode:(NSString *)address Province:(NSString *)province City:(NSString *)city;

@end

@interface MapChooseAddressVC : PKViewController
@property(nonatomic,weak)id<MapChooseAddressVCDelegate>delegate;
@end
