//
//  FeedBackViewController.h
//  KeenanHonda
//
//  Created by Vikram on 4/28/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedBackViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UINavigationBar *feedNavBar;
- (IBAction)tapNavCancel:(id)sender;
- (IBAction)tapNavSend:(id)sender;
@end
