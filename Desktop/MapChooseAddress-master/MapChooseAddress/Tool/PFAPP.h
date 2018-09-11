//
//  PFAPP.h
//  宠物寻找
//
//  Created by mahuajian on 16/7/11.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFAPP : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic,assign)float lat;
@property (nonatomic,assign)float lng;
@property (nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *Province;//省
@property(nonatomic,strong)NSString *City;//市
@end
