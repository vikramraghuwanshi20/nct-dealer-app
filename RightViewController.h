//
//  RightViewController.h
//  KeenanHonda
//
//  Created by Vikram on 4/16/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WebData.h"
#import <MessageUI/MessageUI.h>
#import <MapKit/MapKit.h>
typedef enum {
Main,NewSales,PreOwendSales,Service,Parts,CollisionCenter,Finance
} Departments;

@interface RightViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,WebDataDelegate,MFMailComposeViewControllerDelegate>
{
    CLLocationDegrees *location;
    WebData *webResponse;
    AppDelegate *app;
    NSMutableDictionary *tableContents;
    NSMutableArray *sectionArry;
    Departments deparments;
//Outlets
    
    IBOutlet UIImageView *headerImg;
    IBOutlet UITableView *rightMenuTbl;
}
@property(strong,nonatomic)MFMailComposeViewController *mailer;
@property(nonatomic,strong)NSString *deslat;
@property(nonatomic,strong)NSString *deslong;
@end
