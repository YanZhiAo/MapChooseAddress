//
//  PKNavigationController.m
//  Park
//
//  Created by Caesar on 15/7/9.
//  Copyright (c) 2015年 EXMobile. All rights reserved.
//

#import "PKNavigationController.h"

#import "AppDelegate.h"
@interface PKNavigationController ()
@end

@implementation PKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor colorWithRed:0.200 green:0.486 blue:0.776 alpha:1.000];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews
{
    
//    YATabBarVC *vc=(YATabBarVC *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    
//    for (UIView *view in  vc.tabBar.subviews) {
//        if([view isKindOfClass:[UIControl class]])
//            [view removeFromSuperview];
//    }
    
}
+(void)initialize
{
    //设置导航栏的主题
    //获取能够控制所有NavigationBar的实例
    UINavigationBar *navBar = [UINavigationBar appearance];
     //navBar.backgroundColor=[UIColor blueColor];
    // 设置文本
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = YMColor(255, 255, 255);
    
//    CGFloat R  = (CGFloat) 46/255.0;
//    CGFloat G = (CGFloat) 189/255.0;
//    CGFloat B = (CGFloat) 160/255.0;
//    CGFloat alpha = (CGFloat) 1.0;
//
//    UIColor *myColorRGB = [ UIColor colorWithRed: R  green: G  blue: B  alpha: alpha  ];
    navBar.barTintColor = color2EBDA0;
    //navBar.backgroundColor = [UIColor colorWithRed:0.196 green:0.459 blue:0.792 alpha:1.000];
    
    
//    YAColorModel *model = [YANavColorTool Color];
//    if (!model.ColorName) {
//        [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar"] forBarMetrics:UIBarMetricsDefault];
//    }
//    else
//    {
//        [navBar setBackgroundImage:[YANavColorTool NaviBarColor:model.ColorName] forBarMetrics:UIBarMetricsDefault];
//    }
    
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [navBar setTitleTextAttributes:attr];
    
    
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] =YMColor(255, 255, 255);
    
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
       
    [super pushViewController:viewController animated:animated];
   
//    if(self.flag)
//    {
//        if(self.viewControllers.count==1)
//        {
//            //self.deck.leftSize=60;
//            self.navigationBarHidden=YES;
//        }
//        else
//        {
//            //self.deck.leftSize=0;
//            self.navigationBarHidden=NO;
//        }
//    }
   
        
//    if(self.viewControllers.count>1)
//    {
//        self.deck.leftSize=0;
//        self.navigationBarHidden=NO;
//    }
//    else
//    {
//        self.deck.leftSize=60;
//     self.navigationBarHidden=YES;
//    }
//    NSLog(@"%@",self.deck);
    //IIViewDeckController *vc=((AppDelegate *)[UIApplication sharedApplication].delegate).deckVC;
    //IIViewDeckController *deck=[self.navigationController.childViewControllers  firstObject];
    //vc.leftSize=0;
   
}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *control=[super popViewControllerAnimated:animated];
//    if(self.flag)
//    {
//        if(self.viewControllers.count==1)
//        {
//           // self.deck.leftSize=60;
//            self.navigationBarHidden=YES;
//        }
//        else
//        {
//           // self.deck.leftSize=0;
//            self.navigationBarHidden=NO;
//        }
//    }
    return control;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
