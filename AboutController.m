//
//  AboutController.m
//  KeenanHonda
//
//  Created by Vikram on 4/24/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "AboutController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "WebData.h"


@interface AboutController ()
{
    WebData *webResponse;
    NSDictionary *dataDict;
}
@end

@implementation AboutController

@synthesize aboutNavBar;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupLeftMenuButton];
    //[self setupRightMenuButton];
    [self viewSetUp];
  
}
-(void)viewWillAppear:(BOOL)animated{
    UIImage *barImage=[[UIImage imageNamed:@"navBarFade.png"]
                       resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:barImage                                                forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor=[UIColor clearColor];
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

-(void)viewSetUp{
    webResponse=[[WebData alloc]init];
    dataDict=[webResponse getAppData];
   
    [self.imgHeader setImage:[webResponse showHeaderImage]];
    self.txtViewAbout.text=[[dataDict objectForKey:@"dealerInfo"] objectForKey:@"dealerAboutText"];
}

- (void)setupLeftMenuButton {
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton];
}
- (void)setupRightMenuButton {
    UIImage *phoneImage=[[UIImage imageNamed:@"mphone.png"]
                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(0.0, 0.0, 25.0, 25.0)];
    [button1 addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setImage:phoneImage forState:UIControlStateNormal];
    
    MMDrawerBarButtonItem * rightDrawerButton = [[MMDrawerBarButtonItem alloc] initWithCustomView:button1];

    [self.navigationItem setRightBarButtonItem:rightDrawerButton];
}

- (void)leftDrawerButtonPress:(id)leftDrawerButtonPress {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (void)rightDrawerButtonPress:(id)rightDrawerButtonPress {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}


@end
