//
//  AppDelegate.m
//  MapChooseAddress
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"

@interface AppDelegate ()<MAMapViewDelegate,AMapSearchDelegate>
@property (strong, nonatomic) MAMapView *mapView;
@property (strong,nonatomic)AMapSearchAPI *search;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //高德
    [AMapServices sharedServices].apiKey = @"4f1678ac8f51e626d98dcbc52db83a48";
    self.mapView = [[MAMapView alloc] init];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    //搜索对象，逆地理编码
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    HomeVC *homeVC = [[HomeVC alloc] init];
    PKNavigationController *naviControll = [[PKNavigationController alloc] initWithRootViewController:homeVC];
    
    [self.window makeKeyAndVisible];
    self.window.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController = naviControll;
    
    
    return YES;
}

//高德地图
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (updatingLocation) {
        //取出当前位置坐标
        //  NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
        double longitude = userLocation.coordinate.longitude;
        double latitude = userLocation.coordinate.latitude;
        
        //WGS坐标转GCJ02
        //        NSMutableArray *arr=[LocationUtls WgsConvertToGcj:latitude andWgs_lng:longitude];
        //        CLLocation *mycurLocaton=[[CLLocation alloc]initWithLatitude:[arr[0] doubleValue] longitude:[arr[1] doubleValue]];
        
        //        [PFAPP sharedInstance].lat = mycurLocaton.coordinate.latitude;
        //        [PFAPP sharedInstance].lng = mycurLocaton.coordinate.longitude;
        [PFAPP sharedInstance].lat = latitude;
        [PFAPP sharedInstance].lng = longitude;
        
        self.mapView.showsUserLocation = NO;
        
        
        //请求逆地理编码
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        
        regeo.location                    = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        regeo.requireExtension            = YES;
        
        [self.search AMapReGoecodeSearch:regeo];
        
        
    }
    
}
/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        //解析response获取地址描述，具体解析见 Demo
        NSString *strAddress = [NSString stringWithFormat:@"%@ %@",response.regeocode.addressComponent.province,response.regeocode.addressComponent.city];
        NSLog(@"%@",strAddress);
        
        [PFAPP sharedInstance].Province = response.regeocode.addressComponent.province;
        if ([response.regeocode.addressComponent.city isEqualToString:@""]||response.regeocode.addressComponent.city==nil) {
            //区
            [PFAPP sharedInstance].City = response.regeocode.addressComponent.district;
        }
        else
        {
            //市
            [PFAPP sharedInstance].City = response.regeocode.addressComponent.city;
        }
        
        
        [PFAPP sharedInstance].address = strAddress;
        
    }
}

//定位将要启动时调用该接口
-(void)mapViewWillStartLocatingUser:(MAMapView *)mapView
{
    if (![CLLocationManager locationServicesEnabled]) {
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"定位失败" message:@"请再手机设置中开启定位功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //        [alertView show];
        
        UIAlertController *alret=[UIAlertController alertControllerWithTitle:@"定位失败" message:@"请再手机设置中开启定位功能" preferredStyle:UIAlertControllerStyleAlert];
        [alret addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
        self.mapView = nil;
        self.mapView.delegate = nil;
        return;
    }
    else
    {
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
            
            UIAlertController *alret=[UIAlertController alertControllerWithTitle:@"定位失败" message:@"请再手机设置中开启定位功能" preferredStyle:UIAlertControllerStyleAlert];
            
            [alret addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }]];
            self.mapView = nil;
            self.mapView.delegate = nil;
            return;
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
