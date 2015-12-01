//
//  MakePaymentController.h
//  KeenanHonda
//
//  Created by Vikram on 4/28/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakePaymentController : UIViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (strong, nonatomic) IBOutlet UITableView *paymentTable;

@end
