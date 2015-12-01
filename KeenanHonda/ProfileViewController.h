//
//  ProfileViewController.h
//  KeenanHonda
//
//  Created by Vikram on 5/5/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray * pickerData;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet UINavigationBar *profileNavBar;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *vSpace;
- (IBAction)tapDone:(id)sender;
- (IBAction)tapCancel:(id)sender;

- (IBAction)tapNavCancel:(id)sender;
- (IBAction)tapNavDone:(id)sender;

@end
