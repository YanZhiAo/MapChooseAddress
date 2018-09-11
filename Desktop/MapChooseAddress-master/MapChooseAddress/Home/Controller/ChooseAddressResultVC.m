//
//  ChooseAddressResultVC.m
//  MapChooseAddress
//
//  Created by mac on 2018/9/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ChooseAddressResultVC.h"
#import "MapChooseAddressVC.h"
#import "LongPressMapChooseVC.h"

@interface ChooseAddressResultVC ()<MapChooseAddressVCDelegate,LongPressMapChooseVCDelegate>
@property (nonatomic,strong) UIView *AddressResultView;
@property (nonatomic,strong) UIView *AddressResultView2;
@property (nonatomic,strong) UIButton *btnChooseAddress;
@property (nonatomic,strong) UIButton *btnLongPressChoose;

@end

@implementation ChooseAddressResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorf7f7f7;
    self.title = @"选择地址结果";
    
    [self addInitSubViews];
}
//添加控件
-(void)addInitSubViews
{
    _AddressResultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 200)];
    _AddressResultView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_AddressResultView];
    _AddressResultView.center = CGPointMake(Screen_Width/2, Screen_Height/2-10-100);
    
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, Screen_Width-40, 20)];
    labTitle.text = @"拖动地图选择地址";
    labTitle.textAlignment = NSTextAlignmentCenter;
    labTitle.textColor = color333333;
    labTitle.font = [UIFont systemFontOfSize:17];
    [_AddressResultView addSubview:labTitle];
    
    
    UIButton *btnChooseAddress = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 200)];
    [btnChooseAddress setTitle:@"请选择地址" forState:UIControlStateNormal];
    [btnChooseAddress setTitleColor:color2EBDA0 forState:UIControlStateNormal];
    btnChooseAddress.titleLabel.font = [UIFont systemFontOfSize:17];
    btnChooseAddress.titleLabel.numberOfLines = 0;
    btnChooseAddress.backgroundColor = [UIColor clearColor];
    [btnChooseAddress addTarget:self action:@selector(btnChooseAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    [_AddressResultView addSubview:btnChooseAddress];
    
    _btnChooseAddress = btnChooseAddress;
    
    
    _AddressResultView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 200)];
    _AddressResultView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_AddressResultView2];
    _AddressResultView2.center = CGPointMake(Screen_Width/2, Screen_Height/2+5+100);
    
    UILabel *labTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, Screen_Width-40, 20)];
    labTitle2.text = @"长按地图选择地址";
    labTitle2.textAlignment = NSTextAlignmentCenter;
    labTitle2.textColor = color333333;
    labTitle2.font = [UIFont systemFontOfSize:17];
    [_AddressResultView2 addSubview:labTitle2];
    
    
    UIButton *btnLongPressChoose = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 200)];
    [btnLongPressChoose setTitle:@"请选择地址" forState:UIControlStateNormal];
    [btnLongPressChoose setTitleColor:color2EBDA0 forState:UIControlStateNormal];
    btnLongPressChoose.titleLabel.font = [UIFont systemFontOfSize:17];
    btnLongPressChoose.titleLabel.numberOfLines = 0;
    btnLongPressChoose.backgroundColor = [UIColor clearColor];
    [btnLongPressChoose addTarget:self action:@selector(btnChooseAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    [_AddressResultView2 addSubview:btnLongPressChoose];
    
    _btnLongPressChoose = btnLongPressChoose;
    
    
    
    
    
}

-(void)btnChooseAddressClick:(UIButton *)sender
{
    if (sender == _btnChooseAddress) {
        //拖动地图选择地址
        MapChooseAddressVC *addressVC = [[MapChooseAddressVC alloc] initWithBackImage:[UIImage imageNamed:@"back"]];
        addressVC.delegate = self;
        [self.navigationController pushViewController:addressVC animated:YES];
    }
    else
    {
        //长按地图选择地址
        LongPressMapChooseVC *addressVC = [[LongPressMapChooseVC alloc] initWithBackImage:[UIImage imageNamed:@"back"]];
        addressVC.delegate = self;
        [self.navigationController pushViewController:addressVC animated:YES];
    }
    
}
#pragma mark - MapChooseAddressVCDelegate
-(void)addressDidClickGeoPoint:(AMapGeoPoint *)location regeocode:(NSString *)address Province:(NSString *)province City:(NSString *)city
{
    [_btnChooseAddress setTitle:address forState:UIControlStateNormal];
    
    
}
#pragma mark - LongPressMapChooseVCDelegate
-(void)LongPressMapDidClickGeoPoint:(AMapGeoPoint *)location regeocode:(NSString *)address Province:(NSString *)province City:(NSString *)city
{
    [_btnLongPressChoose setTitle:address forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
