//
//  PKViewController.h
//  Park
//
//  Created by Caesar on 15/7/9.
//  Copyright (c) 2015年 EXMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKViewController : UIViewController
-(void)BackPopController:(UIButton *)btn;
-(id)initWithBackImage:(UIImage *)backImage;
@property(nonatomic,strong)UIButton *leftView;
@property(nonatomic,strong)UINavigationController *nav;
@property(nonatomic,assign)BOOL loadSuccess;
@property(nonatomic,assign)BOOL contentSuccess;
-(void)loadAgain;
@end
