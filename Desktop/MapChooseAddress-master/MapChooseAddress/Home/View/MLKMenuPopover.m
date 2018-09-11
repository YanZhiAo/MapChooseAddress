//
//  MLKMenuPopover.m
//  MLKMenuPopover
//
//  Created by NagaMalleswar on 20/11/14.
//  Copyright (c) 2014 NagaMalleswar. All rights reserved.
//

#import "MLKMenuPopover.h"
#import <QuartzCore/QuartzCore.h>

#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]

#define MENU_ITEM_HEIGHT        38
#define FONT_SIZE               14
#define CELL_IDENTIGIER         @"MenuPopoverCell"
#define MENU_TABLE_VIEW_FRAME   CGRectMake(0, 0, frame.size.width, frame.size.height)
#define SEPERATOR_LINE_RECT     CGRectMake(0, MENU_ITEM_HEIGHT - 1, self.frame.size.width, 1)
#define MENU_POINTER_RECT       CGRectMake(frame.origin.x+100, frame.origin.y, 23, 11)

#define CONTAINER_BG_COLOR      RGBA(0, 0, 0, 0.1f)

#define ZERO                    0.0f
#define ONE                     1.0f
#define ANIMATION_DURATION      0.5f

#define MENU_POINTER_TAG        1011
#define MENU_TABLE_VIEW_TAG     1012

#define LANDSCAPE_WIDTH_PADDING 50

@interface MLKMenuPopover ()

@property(nonatomic,retain) NSArray *menuItems;
@property(nonatomic,strong) NSArray *menuImages;
@property(nonatomic,retain) UIButton *containerButton;

- (void)hide;
- (void)addSeparatorImageToCell:(UITableViewCell *)cell;

@end

@implementation MLKMenuPopover

@synthesize menuPopoverDelegate;
@synthesize menuItems;
@synthesize containerButton;
@synthesize menuImages;

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)aMenuItems menuImages:(NSArray *)aMenuImages
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.menuItems = aMenuItems;
        
        self.menuImages = aMenuImages;
        // Adding Container Button which will take care of hiding menu when user taps outside of menu area
        self.containerButton = [[UIButton alloc] init];
        [self.containerButton setBackgroundColor:CONTAINER_BG_COLOR];
        [self.containerButton addTarget:self action:@selector(hideMenuPopover) forControlEvents:UIControlEventTouchUpInside];
        [self.containerButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
        
        // Adding Menu Options Pointer
//        UIImageView *menuPointerView = [[UIImageView alloc] initWithFrame:MENU_POINTER_RECT];
//        menuPointerView.image = [UIImage imageNamed:@"options_pointer"];
//        menuPointerView.tag = MENU_POINTER_TAG;
//        [self.containerButton addSubview:menuPointerView];
        
        // Adding menu Items table
        UITableView *menuItemsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //menuItemsTableView.backgroundColor=[UIColor blackColor];
        //menuItemsTableView.alpha=0.5;
        menuItemsTableView.dataSource = self;
        menuItemsTableView.delegate = self;
        menuItemsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [menuItemsTableView setSeparatorInset:UIEdgeInsetsZero];
        menuItemsTableView.scrollEnabled = YES;
        menuItemsTableView.backgroundColor = [UIColor clearColor];
        menuItemsTableView.tag = MENU_TABLE_VIEW_TAG;
        
        //UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Menu_PopOver_BG"]];
        //menuItemsTableView.backgroundView = bgView;
        [menuItemsTableView setBackgroundColor:[UIColor whiteColor]];
        
        [self addSubview:menuItemsTableView];
        
        [self.containerButton addSubview:self];
    }
    
    return self;
}

#pragma mark -
#pragma mark UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return self.frame.size.height/self.menuItems.count;
    return 38;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = CELL_IDENTIGIER;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
//        [cell.textLabel setTextColor:[UIColor grayColor]];
//        //[cell setSelectionStyle:UITableViewCellSelectionStyleGray];
//        [cell setBackgroundColor:[UIColor clearColor]];
//    }
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//
//    NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
//    if( [tableView numberOfRowsInSection:indexPath.section] > ONE && !(indexPath.row == numberOfRows - 1) )
//    {
//        [self addSeparatorImageToCell:cell];
//    }
    
     UILabel *lab=[[UILabel alloc]init];
    
    if (self.menuImages!=nil) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 15, 18)];
        //img.image = [UIImage imageNamed:[self.menuImages objectAtIndex:indexPath.row]];
        if (indexPath.row == 0) {
            img.image = [UIImage imageNamed:[self.menuImages objectAtIndex:indexPath.row]];
        }
        else
        {
            
//            [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/images/Category/%@",serverURL,self.menuImages[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"drugtype_1"]];
        }
        
        [cell addSubview:img];
        lab.frame = CGRectMake(CGRectGetMaxX(img.frame)+5, 9, self.frame.size.width-CGRectGetMaxX(img.frame)-10, 20);
    }
    else
    {
        lab.frame =CGRectMake(10, 9, self.frame.size.width-15, 20);
    }
    
    [cell addSubview:lab];
    lab.text = [self.menuItems objectAtIndex:indexPath.row];
    [lab setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [lab setTextColor:[UIColor grayColor]];
    lab.textAlignment=NSTextAlignmentLeft;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 38-1, self.frame.size.width, 1)];
    [cell addSubview:view];
    view.backgroundColor=[UIColor grayColor];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];
    [self.menuPopoverDelegate menuPopover:self didSelectMenuItemAtIndex:indexPath.row];
}

#pragma mark -
#pragma mark Actions

- (void)dismissMenuPopover
{
    [self hide];
    
}
- (void)hideMenuPopover
{
    [self hide];
    if ([self.menuPopoverDelegate respondsToSelector:@selector(menuPopoverHide:)]) {
        [self.menuPopoverDelegate menuPopoverHide:self];
    }
    
}
- (void)showInView:(UIView *)view
{
    self.containerButton.alpha = ZERO;
    self.containerButton.frame = view.bounds;
    [view addSubview:self.containerButton];
        
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         self.containerButton.alpha = ONE;
                     }
                     completion:^(BOOL finished) {}];
}

- (void)hide
{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         self.containerButton.alpha = ZERO;
                     }
                     completion:^(BOOL finished) {
                         [self.containerButton removeFromSuperview];
                     }];
}

#pragma mark -
#pragma mark Separator Methods

- (void)addSeparatorImageToCell:(UITableViewCell *)cell
{
    UIImageView *separatorImageView = [[UIImageView alloc] initWithFrame:SEPERATOR_LINE_RECT];
    [separatorImageView setImage:[UIImage imageNamed:@"DefaultLine"]];
    separatorImageView.opaque = YES;
    [cell.contentView addSubview:separatorImageView];
}

#pragma mark -
#pragma mark Orientation Methods

- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    BOOL landscape = (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    
    UIImageView *menuPointerView = (UIImageView *)[self.containerButton viewWithTag:MENU_POINTER_TAG];
    UITableView *menuItemsTableView = (UITableView *)[self.containerButton viewWithTag:MENU_TABLE_VIEW_TAG];
    
    if( landscape )
    {
        menuPointerView.frame = CGRectMake(menuPointerView.frame.origin.x + LANDSCAPE_WIDTH_PADDING, menuPointerView.frame.origin.y, menuPointerView.frame.size.width, menuPointerView.frame.size.height);
        
        menuItemsTableView.frame = CGRectMake(menuItemsTableView.frame.origin.x + LANDSCAPE_WIDTH_PADDING, menuItemsTableView.frame.origin.y, menuItemsTableView.frame.size.width, menuItemsTableView.frame.size.height);
    }
    else
    {
        menuPointerView.frame = CGRectMake(menuPointerView.frame.origin.x - LANDSCAPE_WIDTH_PADDING, menuPointerView.frame.origin.y, menuPointerView.frame.size.width, menuPointerView.frame.size.height);
        
        menuItemsTableView.frame = CGRectMake(menuItemsTableView.frame.origin.x - LANDSCAPE_WIDTH_PADDING, menuItemsTableView.frame.origin.y, menuItemsTableView.frame.size.width, menuItemsTableView.frame.size.height);
    }
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
