//
//  PFAPP.m
//  宠物寻找
//
//  Created by mahuajian on 16/7/11.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import "PFAPP.h"

@implementation PFAPP
+ (instancetype)sharedInstance
{
    static PFAPP *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PFAPP alloc] init];
    });
    
    return sharedInstance;
}
@end
