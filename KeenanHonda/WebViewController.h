//
//  WebControllerViewController.h
//  KeenanHonda
//
//  Created by Vikram on 4/18/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface WebControllerViewController : UIViewController<UIWebViewDelegate>
{

    IBOutlet UIWebView *webView;
   
}

@property(nonatomic,retain)NSString *webUrl;
@property(nonatomic,retain)NSString *webTitle;
@property(nonatomic)BOOL isPresentView;
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (strong, nonatomic) IBOutlet UIButton *btnBackward;
@property (strong, nonatomic) IBOutlet UIButton *btnForward;
@property (strong, nonatomic) IBOutlet UIButton *btnRefresh;
@property (strong, nonatomic) IBOutlet UIButton *btnHome;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnNavCancel;
@property (strong, nonatomic) IBOutlet UINavigationBar *webNavBar;

-(IBAction)nxtBtn:(id)sender;
-(IBAction)preBtn:(id)sender;
-(IBAction)refreshBtn:(id)sender;
-(IBAction)homeBtn:(id)sender;
- (IBAction)tapNavCancel:(id)sender;


@end
