//
//  TableController.h
//  KeenanHonda
//
//  Created by Vikram on 4/27/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewCell.h"

@interface TableController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property(strong,nonatomic)NSMutableArray *callArray;
@property(nonatomic)BOOL finance;
//Outlets
@property (strong, nonatomic) IBOutlet UINavigationBar *roadSideNavBar;
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//Actions
- (IBAction)tapCancel:(id)sender;

@end
