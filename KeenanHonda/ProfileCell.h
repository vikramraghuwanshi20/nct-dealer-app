//
//  ProfileCell.h
//  KeenanHonda
//
//  Created by Vikram on 4/24/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *txtFname;
@property (strong, nonatomic) IBOutlet UITextField *txtLname;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;
@property (strong, nonatomic) IBOutlet UITextField *txtRewardNumber;
@property (strong, nonatomic) IBOutlet UIButton *btnScan;
@property (strong, nonatomic) IBOutlet UILabel *lblContacPref;
@property (strong, nonatomic) IBOutlet UILabel *lblLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

@end
