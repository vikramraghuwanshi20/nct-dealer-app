//
//  LeftViewController.h
//  KeenanHonda
//
//  Created by Vikram on 4/16/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "WebData.h"

@protocol LeftMenuDelegate <NSObject>
@required
-(void)getDataUrls:(NSString *)strUrls;

@end



@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate>
{
    NSMutableDictionary *tableContents;
    NSMutableArray *sectionArry;
    
    
    //OutLets
    IBOutlet UIImageView *headerBg;
    IBOutlet UITableView *leftMenuTbl;
}

@property(strong,nonatomic)MFMailComposeViewController *mailer;
@property(weak,nonatomic) id<LeftMenuDelegate> delegate;

@end
