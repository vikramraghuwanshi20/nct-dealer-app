//
//  ODOClubViewController.h
//  KeenanHonda
//
//  Created by Vikram on 4/28/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "oRewards.h"

@class oRewards;

@interface ODOClubViewController : UIViewController<UIAlertViewDelegate>
{
    oRewards *o;
}
//OutLets
@property(nonatomic,retain) oRewards *o;
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (strong, nonatomic) IBOutlet UIView *rewardView;
@property (strong, nonatomic) IBOutlet UITextField *txtAccountNumber;
@property (strong, nonatomic) IBOutlet UITextField *txtZipCode;
@property (strong, nonatomic) IBOutlet UILabel *lblPointBalance;
@property (strong, nonatomic) IBOutlet UILabel *lblCardNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblClientName;
@property (strong, nonatomic) IBOutlet UIImageView *imgBarCode;
@property (strong, nonatomic) IBOutlet UITextView *txtViewSpecials;
@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
@property (strong, nonatomic) IBOutlet UIButton *btnSpecial;
@property (strong, nonatomic) IBOutlet UIImageView *viewBg;


//Actions
- (IBAction)tapSubmit:(id)sender;
- (IBAction)tapReset:(id)sender;
- (IBAction)tapResetCard:(id)sender;
- (IBAction)tapSpecial:(id)sender;




@end
