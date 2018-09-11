//
//  PKViewController.m
//  Park
//
//  Created by Caesar on 15/7/9.
//  Copyright (c) 2015年 EXMobile. All rights reserved.
//

#import "PKViewController.h"
#import "AppDelegate.h"
//#import "KMLoadView.h"
//#import "KMInContentView.h"
@interface PKViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UIImage *backimage;
//@property(nonatomic,strong)KMLoadView *loadSuccessView;
//@property(nonatomic,strong)KMInContentView *contentView;
@end

@implementation PKViewController
//-(KMLoadView *)loadSuccessView
//{
//    if(!_loadSuccessView)
//    {
//        _loadSuccessView=[[KMLoadView alloc]init];
//        _loadSuccessView.hidden=YES;
//        _loadSuccess=YES;
//        [_loadSuccessView addTarget:self actionForLoadAgain:@selector(loadAgain)];
//    }
//    return _loadSuccessView;
//}
//-(KMInContentView *)contentView
//{
//    if(!_contentView)
//    {
//        _contentView=[[KMInContentView alloc]init];
//        _contentView.hidden=YES;
//        _contentSuccess=YES;
//
//    }
//    return _contentView;
//}

-(id)initWithBackImage:(UIImage *)backImage
{
    self=[super init];
    if(self)
    {
        self.backimage=backImage;
    }
    return self;
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
//    self.loadSuccessView.frame=self.view.bounds;
//    self.contentView.frame=self.view.bounds;
}
-(void)setLoadSuccess:(BOOL)loadSuccess
{
    _loadSuccess=loadSuccess;
//    [self.view addSubview:self.loadSuccessView];
//
//    self.loadSuccessView.hidden=loadSuccess;
    
}
-(void)setContentSuccess:(BOOL)contentSuccess
{
    _contentSuccess=contentSuccess;
//    [self.view addSubview:self.contentView];
//     self.contentView.hidden=contentSuccess;
}
-(void)loadAgain
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor=YMColor(230, 230, 230);
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.view.backgroundColor = ViewBackColor;
    if(self.backimage)
    {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        btn.imageView.contentMode=UIViewContentModeScaleAspectFit;
            [btn addTarget:self action:@selector(BackPopController:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:self.backimage forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 15);
   // btn.backgroundColor=YMRandomColor;
    
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
        self.leftView=btn;
       
    }
    // Do any additional setup after loading the view.
}
-(void)BackPopController:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(UINavigationController*)nav
{
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    return delegate.nav;
}
@end
