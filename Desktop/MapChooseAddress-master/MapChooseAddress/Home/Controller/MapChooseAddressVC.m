//
//  MapChooseAddressVC.m
//  MapChooseAddress
//
//  Created by mac on 2018/9/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MapChooseAddressVC.h"
#import "MLKMenuPopover.h"

@interface MapChooseAddressVC ()<MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate,UITextFieldDelegate,MLKMenuPopoverDelegate,UIGestureRecognizerDelegate>
@property(strong,nonatomic)AMapSearchAPI *ASearch;
@property (strong, nonatomic) MAMapView *mapView;
//大头针
@property(nonatomic,strong)MAPointAnnotation *pointAnnotation;
@property(nonatomic,strong)AMapGeoPoint *location;
@property(nonatomic,strong)NSString *regeocode;
@property(nonatomic,strong)NSString *Province;
@property(nonatomic,strong)NSString *City;
//关键字搜索
@property(nonatomic,strong)UITextField *textKeys;
//下拉列表
@property(nonatomic,strong)MLKMenuPopover *menuPopover;
//存放搜索到的关键字
@property(nonatomic,strong)NSMutableArray *arrKeyList;
//底部视图
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UILabel *labAddress;//当前大头针对应的地址
@property(nonatomic,strong)AMapLocationManager *locationManager;//定位
@end

@implementation MapChooseAddressVC
-(NSMutableArray *)arrKeyList
{
    if (!_arrKeyList) {
        _arrKeyList = [NSMutableArray array];
    }
    return _arrKeyList;
}
//大头针
-(MAPointAnnotation *)pointAnnotation
{
    if (!_pointAnnotation) {
        _pointAnnotation = [[MAPointAnnotation alloc] init];
        
    }
    return _pointAnnotation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择地点";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:_textKeys];
    
    //高德
    [AMapServices sharedServices].apiKey = @"4f1678ac8f51e626d98dcbc52db83a48";
    
    //高德地图
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, HeightNavBar, Screen_Width, Screen_Height-HeightNavBar-HeightSafeAreaofTabBar)];
    self.mapView.delegate = self;
    //标准地图
    self.mapView.mapType = MAMapTypeStandard;
    //是否显示罗盘
    self.mapView.showsCompass = NO;
    //比例尺是否显示
    [self.mapView setShowsScale:NO];
    //缩放级别[3 - 20]
    self.mapView.zoomLevel = 15;
    [self.mapView setUserTrackingMode: MAUserTrackingModeNone animated:YES]; //地图不跟着位置移动
    [self.view addSubview:self.mapView];
    
    //中心点大头针图标
    UIImageView *imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imgArrow.center = CGPointMake(Screen_Width/2, (Screen_Height-HeightSafeAreaofTabBar-HeightNavBar)/2+HeightNavBar-HeightSafeAreaofTabBar-18);
    imgArrow.image = [UIImage imageNamed:@"home_store_address30"];
    imgArrow.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgArrow];
    
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
    
    //搜索框
    [self addTextKeyView];
    
    [self addViewBottom];
    
    //初始化搜索类
    self.ASearch = [[AMapSearchAPI alloc] init];
    self.ASearch.delegate = self;
    
    CLLocationCoordinate2D coor;
    coor.latitude = [PFAPP sharedInstance].lat;
    coor.longitude = [PFAPP sharedInstance].lng;
    if (coor.latitude == 0.0&&coor.longitude == 0.0) {
        [SVProgressHUD showErrorWithStatus:@"没有找到该位置"];
        return;
    }
    
    //逆地理编码
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coor.latitude longitude:coor.longitude];
    regeo.requireExtension            = YES;
    
    [self.ASearch AMapReGoecodeSearch:regeo];
    
    //地图中心点设置定位到的点
    [self.mapView setCenterCoordinate:coor animated:YES];
    
    self.pointAnnotation.coordinate = coor;
    
}
//输入框
-(void)addTextKeyView
{
    UITextField *field=[[UITextField alloc]initWithFrame:CGRectMake(5, HeightNavBar+15, Screen_Width-10, 40)];
    field.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    NSAttributedString*attribute=[[NSAttributedString alloc]initWithString:@"输入附近地址关键字" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor grayColor]}];
    field.attributedPlaceholder=attribute;
    field.font = [UIFont systemFontOfSize:13];
    field.returnKeyType=UIReturnKeySearch;
    UIButton *magnifier=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [magnifier setImage:[UIImage imageNamed:@"fabu_02"] forState:UIControlStateNormal];
    //field.borderStyle=UITextBorderStyleRoundedRect;
    field.layer.masksToBounds = YES;
    field.layer.cornerRadius = 3.0;
    field.layer.borderWidth = 1.0;
    field.layer.borderColor = [UIColor colorWithRed:0.863 green:0.859 blue:0.847 alpha:1.000].CGColor;
    magnifier.imageView.contentMode=UIViewContentModeScaleAspectFit;
    field.leftViewMode=UITextFieldViewModeAlways;
    field.leftView=magnifier;
    [magnifier addTarget:self action:@selector(Search) forControlEvents:UIControlEventTouchUpInside];
    field.delegate=self;
    
    [self.view addSubview:field];
    self.textKeys=field;
}
//底部视图
-(void)addViewBottom
{
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height-(HeightSafeAreaofTabBar)-80, Screen_Width, 80)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.bottomView];
    
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, Screen_Width-30, 20)];
    labTitle.text = @"当前地址：";
    labTitle.font = [UIFont systemFontOfSize:14];
    labTitle.textColor = color2EBDA0;
    [self.bottomView addSubview:labTitle];
    
    self.labAddress = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(labTitle.frame)+5, Screen_Width-30, 40)];
    self.labAddress.numberOfLines = 0;
    self.labAddress.font = [UIFont systemFontOfSize:16];
    self.labAddress.textColor = color333333;
    [self.bottomView addSubview:self.labAddress];
    
    //定位按钮
    UIButton *btnAddress = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMinY(self.bottomView.frame)-10-30, 30, 30)];
    [btnAddress setBackgroundImage:[UIImage imageNamed:@"home_store_location30"] forState:UIControlStateNormal];
    btnAddress.contentMode = UIViewContentModeScaleAspectFit;
    [btnAddress addTarget:self action:@selector(btnLocationClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAddress];
    
}
//定位按钮
-(void)btnLocationClick:(UIButton *)btn
{
    //开始定位
    [self.locationManager startUpdatingLocation];
    
}
//定位成功的回调
-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    //定位结果
    //NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
    //逆地理编码
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    regeo.requireExtension            = YES;
    
    [self.ASearch AMapReGoecodeSearch:regeo];
    
    self.pointAnnotation.coordinate = location.coordinate;
    
    //[self.mapView addAnnotation:self.pointAnnotation];
    
    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
    
    //停止定位
    [self.locationManager stopUpdatingLocation];
    
    
}
//定位错误的回调
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    //定位错误
    [SVProgressHUD showErrorWithStatus:@"本次定位失败"];
}
//搜索按钮事件
-(void)Search
{
    if (!self.textKeys.text.length) {
        //[SVProgressHUD showErrorWithStatus:@"请输入地址关键字"];
        return;
    }
    
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.city = [PFAPP sharedInstance].Province;
    request.keywords                    = self.textKeys.text;
    request.sortrule                    = 0;
    request.requireExtension            = YES;
    request.cityLimit = NO; //是否限制城市
    //request.radius                      = 2000;//2公里的半径范围
    request.page                        = 1;
    request.offset                      = 50;
    request.types                       = @"050000|060000|070000|080000|090000|100000|110000|120000|130000|140000|150000|160000|170000|180000|190000|200000|220000|970000|990000";
    //发送
    //    [self.ASearch AMapPOIAroundSearch:request];
    [self.ASearch AMapPOIKeywordsSearch:request];
}
//键盘搜索按钮事件
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if ([textField isFirstResponder]) {
        [self Search];
        [textField resignFirstResponder];
        
    }
    return YES;
}
//键盘内容的实时监听
- (void)textFieldChanged:(id)sender
{
    [self Search];
}
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    
    if (response.pois.count != 0){
        
        self.arrKeyList.array = response.pois;
        NSMutableArray *keyListArr = [NSMutableArray array];
        
        for (AMapPOI *poiResult in self.arrKeyList) {
            [keyListArr addObject:poiResult.name];
        }
        
        
        [self.menuPopover dismissMenuPopover];
        
        self.menuPopover = [[MLKMenuPopover alloc] initWithFrame:CGRectMake(5, HeightNavBar+15+40, Screen_Width-10,150) menuItems:keyListArr menuImages:nil];
        self.menuPopover.menuPopoverDelegate = self;
        [self.menuPopover showInView:self.view];
        
        
    }
    
}
//搜索到的关键字列表的监控（选择点击）事件
#pragma mark MLKMenuPopoverDelegate
-(void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex
{
    [self.menuPopover dismissMenuPopover];
    [self.textKeys resignFirstResponder];
    
    AMapPOI *poiResult = self.arrKeyList[selectedIndex];
    
    CLLocationCoordinate2D coor;
    coor.latitude = poiResult.location.latitude;
    coor.longitude = poiResult.location.longitude;
    if (coor.latitude == 0.0&&coor.longitude == 0.0) {
        [SVProgressHUD showErrorWithStatus:@"没有找到该位置"];
        return;
    }
    
    self.textKeys.text = poiResult.name;
    self.pointAnnotation.coordinate = coor;
    self.pointAnnotation.title = poiResult.name;
    self.pointAnnotation.subtitle = poiResult.address;
    
    self.location = poiResult.location;
    self.regeocode = poiResult.name;
    
    //加载搜索位置大头针到地图
    //[self.mapView addAnnotation:self.pointAnnotation];
    //地图中心点设置为搜索的点
    [self.mapView setCenterCoordinate:coor animated:YES];
}
-(void)BackPopController:(UIButton *)btn
{
    
    if ([self.delegate respondsToSelector:@selector(addressDidClickGeoPoint:regeocode:Province:City:)]) {
        [self.delegate addressDidClickGeoPoint:self.location regeocode:self.regeocode Province:self.Province City:self.City];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

//拖动地图后回调
-(void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //mapView.region.center
    
    
    //逆地理编码
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:mapView.region.center.latitude longitude:mapView.region.center.longitude];
    regeo.requireExtension            = YES;
    
    [self.ASearch AMapReGoecodeSearch:regeo];
    
    
}
#pragma maek - MAMapViewDelegate 大头针

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAAnnotationView*annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= NO;//设置气泡可以弹出，默认为NO
        annotationView.image = [UIImage imageNamed:@"home_store_address30"];
        //annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        //annotationView.pinColor = MAPinAnnotationColorPurple;
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        self.pointAnnotation.title = response.regeocode.formattedAddress;
        self.pointAnnotation.subtitle = nil;
        //self.textKeys.text = response.regeocode.formattedAddress;
        self.labAddress.text = response.regeocode.formattedAddress;
        
        
        
        //此处可以获取逆地理编码前的坐标位置和地址名返回到上一页
        //response.regeocode.formattedAddress
        //request.location.latitude,request.location.longitude
        self.location = request.location;
        self.regeocode = response.regeocode.formattedAddress;
        self.Province = response.regeocode.addressComponent.province;
        if ([response.regeocode.addressComponent.city isEqualToString:@""]||response.regeocode.addressComponent.city==nil) {
            //区
            self.City = response.regeocode.addressComponent.district;
        }
        else
        {
            self.City = response.regeocode.addressComponent.city;
        }
        
        NSLog(@"%.6f %.6f",request.location.latitude,request.location.longitude);
        //    self.pointAnnotation.subtitle = tip.address;
        
        
    }
    else
    {
        //        [self.annotation setAMapReGeocode:response.regeocode];
        //        [self.mapView selectAnnotation:self.annotation animated:YES];
        self.pointAnnotation.title = @"未知地址";
        //self.fabuParam.Address = @"未知";
    }
}
//逆编码失败回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
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
