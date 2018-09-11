//
//  HomeVC.m
//  MapChooseAddress
//
//  Created by mac on 2018/9/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HomeVC.h"
#import "ChooseAddressResultVC.h"

#define cellHomeCell @"homeTableCell"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;
@end

@implementation HomeVC
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HeightNavBar, Screen_Width, Screen_Height-HeightNavBar-HeightSafeAreaofTabBar) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView tableHeaderHeight];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellHomeCell];
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorf7f7f7;
    self.title = @"地图位置选择";
    
    self.dataSource = @[@"高德SDK"];
    [self.view addSubview:self.tableView];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellHomeCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellHomeCell];
        
    }
    
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    
    cell.textLabel.textColor = color2EBDA0;
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        ChooseAddressResultVC *chooseResultVC = [[ChooseAddressResultVC alloc] initWithBackImage:[UIImage imageNamed:@"back"]];
        [self.navigationController pushViewController:chooseResultVC animated:YES];
        
    }
    
    
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
