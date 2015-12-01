//
//  SettingController.m
//  KeenanHonda
//
//  Created by Vikram on 4/24/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "SettingController.h"
#import "SettingTableViewCell.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "CreateProfile.h"
#import "ODOClubViewController.h"
#import "RightViewController.h"

@interface SettingController ()

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self setupRightMenuButton];
    [self setupLeftMenuButton];
    UIImage *barImage=[[UIImage imageNamed:@"navBarFade.png"]
                       resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:barImage                                                forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
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


#pragma mark TableView DataSources Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
       //cellid=;
    SettingTableViewCell *cell;
    if (indexPath.section==0) {
         cell=[tableView dequeueReusableCellWithIdentifier:@"settingCellProfile" forIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
         cell.textLabel.text=@"Create Profile";
        }
    if (indexPath.section==1) {
        cell=[tableView dequeueReusableCellWithIdentifier:@"settingCellSound" forIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
        [cell.swtchSound addTarget:self action:@selector(tapSwitch:) forControlEvents:UIControlEventValueChanged];
        
    }
    if (indexPath.section==2) {
        cell=[tableView dequeueReusableCellWithIdentifier:@"settingCellNoti" forIndexPath:[NSIndexPath indexPathForItem:0 inSection:2]];
                cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.text=@"Notification";
    }

    return cell;
}

//TableVIew Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0 && indexPath.section==0) {
    NSLog(@"Call");
     
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        CreateProfile *odoClub=[self.storyboard instantiateViewControllerWithIdentifier:@"createpro"];
//        [self presentViewController:odoClub animated:YES completion:nil];
        UIViewController *creat=[self.storyboard instantiateViewControllerWithIdentifier:@"story"];
        [self presentViewController:creat animated:YES completion:nil];
    
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void) tapSwitch:(id)sender {
    UISwitch* switchControl = sender;
    NSLog( @"The switch is %@", switchControl.on ? @"ON" : @"OFF" );
}
@end
