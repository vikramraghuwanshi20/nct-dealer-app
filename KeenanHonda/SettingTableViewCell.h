//
//  SettingTableViewCell.h
//  KeenanHonda
//
//  Created by Vikram on 4/24/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UISwitch *swtchSound;
@property (strong, nonatomic) IBOutlet UISwitch *tapSalesSwtch;
@property (strong, nonatomic) IBOutlet UISwitch *tapServicesSwtch;
@property (strong, nonatomic) IBOutlet UISwitch *tapGeneralSwtch;
@property (strong, nonatomic) IBOutlet UILabel *lblSales;
@property (strong, nonatomic) IBOutlet UILabel *lblServices;
@property (strong, nonatomic) IBOutlet UILabel *lblGeneral;


@end
