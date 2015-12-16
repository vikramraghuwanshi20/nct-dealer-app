//
//  FirstViewController.m
//  KeenanHonda
//
//  Created by Vikram on 4/17/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "Costants.h"
#import "FirstViewController.h"
#import "WebViewController.h"
#import "MainViewCell.h"
#import "TableController.h"
#import "MapController.h"
#import "ODOClubViewController.h"
#import "MakePaymentController.h"
#import "LeftItemsController.h"
#import "PhotoSave.h"
#import "FirstViewCell.h"
#import "MBProgressHUD.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CustomCell.h"

@interface FirstViewController ()
{
    MBProgressHUD *hud;
    NSDictionary *dataDict;
    UINavigationBar *navigationBar;
    UIView *myView;
    NSString *phoneNumber;
    NSDictionary *dealerinfo;
    NSString *departmentMail;

    
}
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIImageView *launchImg;
@property (nonatomic, strong) UIActivityIndicatorView *aiVIew;
@end

@implementation FirstViewController
@synthesize tableView,iconsArray,titleArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   
   [self loadDataForApp];
    [self setupLeftMenuButton];
    
    hud=[[MBProgressHUD alloc]init];
    [self.mainView bringSubviewToFront:hud];
    // Set Navigationbar color
    [hud show:YES];
    iconsArray = [@[@"roadsyde.png",@"service.png",@"newws.png",@"hondaOwner.png",@"rewards.png",@"specials.png",@"showrum.png",@"gas.png",@"financial.png",@"photo.png",@"traffic.png"] mutableCopy];
    titleArray=[@[@"ROADSIDE ASSISTANCE",@"SCHEDULE SERVICE",@"DEALER NEWS",@"HONDA OWNERSS LINK",@"REWARDS",@"SPECIALS",@"SHOWROOM",@"LOCAL GAS PRICES",@"FINANCIAL LINKS",@"JOURNAL",@"TRAFFIC"]mutableCopy];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewSetUp) name:@"update" object:nil];
    //[self setLoadingView];
    //[self launchView];
    [self setInitialValues];
    
}
- (void)setLoadingView
{
    [self.navigationController setNavigationBarHidden: YES animated:YES];
    self.mainView = [UIView new];
    self.mainView.translatesAutoresizingMaskIntoConstraints = NO;
    self.mainView.backgroundColor = [UIColor lightGrayColor];
    
    self.launchImg = [UIImageView new];
    if ([webResponse showLoadingImage])
        self.launchImg.image=[webResponse showLoadingImage];
    else
        self.launchImg.image=[UIImage imageNamed:@"transparent honda.gif"];
    
    self.launchImg.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.aiVIew=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.aiVIew.translatesAutoresizingMaskIntoConstraints=NO;
    
    //    self.aiVIew.center=self.mainView.center;
    [self.aiVIew startAnimating];
    [self.mainView addSubview:self.aiVIew];
    
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.launchImg];
    
}
- (void)launchView
{
    NSDictionary *viewsDictionary = @{@"mainView": self.mainView, @"launchImg": self.launchImg, @"activityIndicator":self.aiVIew};
    NSDictionary *metrics = @{@"vSpacing":@0, @"hSpacing":@0};
    
    
    NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-vSpacing-[mainView]-vSpacing-|"
                                                                        options:0
                                                                        metrics:metrics
                                                                          views:viewsDictionary];
    
    NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-hSpacing-[mainView]-hSpacing-|"
                                                                        options:0
                                                                        metrics:metrics
                                                                          views:viewsDictionary];
    
    [self.view addConstraints:constraint_POS_V];
    [self.view addConstraints:constraint_POS_H];
    
    //For Image View
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.launchImg
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.mainView
                              attribute:NSLayoutAttributeWidth
                              multiplier:1.0
                              constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.launchImg
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.mainView
                              attribute:NSLayoutAttributeHeight
                              multiplier:0.5
                              constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.launchImg
                              attribute:NSLayoutAttributeCenterX
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.mainView
                              attribute:NSLayoutAttributeCenterX
                              multiplier:1.0
                              constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.launchImg
                              attribute:NSLayoutAttributeCenterY
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.mainView
                              attribute:NSLayoutAttributeCenterY
                              multiplier:1.0
                              constant:-25]];
    
    //For Activity Indicator
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.aiVIew
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.mainView
                              attribute:NSLayoutAttributeWidth
                              multiplier:1.0
                              constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.aiVIew
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.mainView
                              attribute:NSLayoutAttributeHeight
                              multiplier:1.0
                              constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.aiVIew
                              attribute:NSLayoutAttributeCenterX
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.mainView
                              attribute:NSLayoutAttributeCenterX
                              multiplier:1.0
                              constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.aiVIew
                              attribute:NSLayoutAttributeCenterY
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.launchImg
                              attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                              constant:25]];
    
    
}

-(void)loadDataForApp
{
    
    webResponse=[[WebData alloc]init];
    webResponse.delegate=self;
    [webResponse postData:DATA_URL];
    
}
-(void)viewSetUp
{
    
    dataDict=[webResponse getAppData];
     dealerinfo=[dataDict objectForKey:@"dealerInfo"];
    dealerinfo=[dataDict valueForKey:@"dealerInfo"];
    phoneNumber = [dealerinfo objectForKey:MAIN_PHONE];
    departmentMail =[dealerinfo objectForKey:MAIN_EMAIL];
    
    
//    if ([webResponse showBgImage])
//    {
//        
//       // bgImage.image=[webResponse showBgImage];
//         bgImage.image=[webResponse showHeaderImage];
//        [self.mainView removeFromSuperview];
//        [self.launchImg removeFromSuperview];
//        [self.navigationController setNavigationBarHidden:   NO animated:YES];
//    }
    // [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:@"bgImage.png"];
}


-(void)viewWillAppear:(BOOL)animated
{
    UIImage *barImage=[UIImage imageNamed:@"navBarFade.png"];
//                       resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:barImage                                                forBarMetrics:UIBarMetricsDefault];
    //self.navigationController.navigationBar.shadowImage = [UIImage new];
    //self.navigationController.navigationBar.translucent = YES;
      //  self.navigationController.view.backgroundColor = Rgb2UIColor(0.0f/255.0f, 0.0f/255.0f, 0.0f/255.0f, 0.0f);
    
    //[[UINavigationBar appearance] setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
}
-(void)setInitialValues
{
   // phoneNumber = [dealerinfo objectForKey:@"dealerMainPhone"];
    //webUrl = [dealerinfo objectForKey:MAIN_URL];
    //webTitle = OUR_WEBSITE;
    //headerHeight = hHeight;
   // isMain = YES;
    //[leftMenuTbl reloadData];
}



- (void)setupLeftMenuButton {
    
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    leftDrawerButton.tintColor=[UIColor whiteColor];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton];
}

- (void)leftDrawerButtonPress:(id)leftDrawerButtonPress {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (void)rightDrawerButtonPress:(id)rightDrawerButtonPress {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

//WebData Delegate

-(void)dataDidFinishLoading:(NSDictionary *)response{
    [webResponse saveDataToUserDefault:response];
    
    
}
-(void)failToGetData:(NSError *)error{
    [self.aiVIew stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Unable To Fetch AppData Try Again Later!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [iconsArray count];
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    
        return 50.0;
}
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    
    return 18.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    myView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 20.0)];
    
    
    UIButton *callimg = [[UIButton alloc]init];
    UIButton *callButton = [[UIButton alloc]init];
    [self buttonWithTitle:nil target:self selector:@selector(CallEmailDirectionMethod:) button:callimg color:nil atag:11 image:[UIImage imageNamed:@"call.png"]frame:CGRectMake(10,15, 20, 20)];
    [self buttonWithTitle:@"CALL" target:self selector:@selector(CallEmailDirectionMethod:) button:callButton color:[UIColor whiteColor]atag:1 image:nil frame:CGRectMake(30,15, 50, 20)];
    
    
  
    UIButton *EmailButton = [[UIButton alloc]init];
    UIButton *Emailimg = [[UIButton alloc]init];
    [self buttonWithTitle:nil target:self selector:@selector(CallEmailDirectionMethod:) button:Emailimg color:nil atag:22 image:[UIImage imageNamed:@"email.png"]frame:CGRectMake(95,15,18,18)];
    [self buttonWithTitle:@"EMAIL" target:self selector:@selector(CallEmailDirectionMethod:) button:EmailButton color:[UIColor whiteColor]atag:2 image:nil frame:CGRectMake(115,15,60, 20)];
    
    
     UIButton *Directionimg = [[UIButton alloc]init];
     UIButton *DirectionButton = [[UIButton alloc]init];
  
    [self buttonWithTitle:nil target:self selector:@selector(CallEmailDirectionMethod:) button:Directionimg color:nil atag:33 image:[UIImage imageNamed:@"directions.png"]frame:CGRectMake(188,15, 18, 18)];
    [self buttonWithTitle:@"DIRECTIONS" target:self selector:@selector(CallEmailDirectionMethod:) button:DirectionButton color:[UIColor whiteColor]atag:3 image:nil frame:CGRectMake(209,15, 110, 20)];
    
    return myView;
}

-(void)buttonWithTitle:(NSString *)title
                       target:(id)target
              selector:(SEL)selector button:(UIButton*)Button color:(UIColor*)colour atag:(NSInteger)tag image:(UIImage*)img frame:(CGRect)position

{
    [Button addTarget:self action:@selector(CallEmailDirectionMethod:) forControlEvents:UIControlEventTouchUpInside];
    [Button setTitle:title forState:UIControlStateNormal];
    [Button setTintColor:colour];
    [Button setTag:tag];
    [Button setBackgroundImage:img forState:UIControlStateNormal];
    [myView setBackgroundColor:[UIColor darkGrayColor]];
    [myView addSubview:Button];
    [Button setFrame:position];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"firstcell";
    FirstViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[FirstViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.lbl_IconTitle.text=[titleArray objectAtIndex:indexPath.row];
    cell.img_Icon.image=[UIImage imageNamed:[iconsArray objectAtIndex:indexPath.row]];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  

    NSMutableString *strUrl;
    NSString *title;
    NSDictionary *dealerinfoDict = [dataDict objectForKey:@"dealerInfo"];
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //complete
    if (indexPath.row == 0 )
    {
        TableController*tab=[storyBoard instantiateViewControllerWithIdentifier:@"tableController"];
        [tab setFinance:NO];
        //[self.navigationController pushViewController:tab animated:YES];
        [self presentViewController:tab animated:YES completion:nil];
        
    }
    
    //complete
    else if (indexPath.row==1)
    {
        strUrl=[dealerinfoDict objectForKey:@"dealerServiceURL"];
        title=@"Schedule Service";
    }
    
    //complete
    else if (indexPath.row ==2)
    {

        UINavigationController *leftItem=[storyBoard instantiateViewControllerWithIdentifier:@"leftmenuitems"];
        NSArray *controllers=[leftItem viewControllers];
        LeftItemsController *rssFeed = [controllers objectAtIndex:0];
        [rssFeed setDataUrls:[[dataDict objectForKey:@"dealerRSS"] objectForKey:@"dealerNewsRSS"]];
        [rssFeed setMainMenu:@"Main"];
        [rssFeed setNewsTitle:@"Dealer News"];
        [self presentViewController:leftItem animated:YES completion:nil];
        return;
    }
    //complete
    else if (indexPath.row==3)
    {
        strUrl=[OWNER_LINK mutableCopy];
        title=@"Owner’s Link";
        [self webmethod:@"Owner’s Link" weburl:strUrl];
        return;
    }
    
    //complete
    else if (indexPath.row==4)
    {
        ODOClubViewController *odoClub=[storyBoard instantiateViewControllerWithIdentifier:@"odoclub"];
        [self.navigationController pushViewController:odoClub animated:YES];
        return;
    }
    
    
   //complete
    else if(indexPath.row==5){
        strUrl=[dealerinfoDict objectForKey:@"dealerNewSalesSpecialsURL"];
        title=@"Specials";
    }
    
    //complete
    else if (indexPath.row==6)
    {
        strUrl=[dealerinfoDict objectForKey:@"dealerNewSalesInventoryURL"];
        title = Show_Floor;

    }
    
    //complete
    else if (indexPath.row==7)
    {
        strUrl=[LOCAL_GAS_LINK mutableCopy];
        title=@"Local Gas";
    }
    
    //complete
    else if (indexPath.row==8)
    {
        TableController*tab=[storyBoard instantiateViewControllerWithIdentifier:@"tableController"];
        [tab setFinance:YES];
        [self presentViewController:tab animated:YES completion:nil];
    }
    
    
    //complete
    else if (indexPath.row==9)
    {
        
       PhotoSave *photoSave=[storyBoard instantiateViewControllerWithIdentifier:@"PhotoSave"];
       [self.navigationController pushViewController:photoSave animated:YES];
        return;
    }
    
    
    //complete
    
    else if (indexPath.row == 10)
    {
        strUrl=[Traffic_Report mutableCopy];
        title=@"Traffic Report";
        
    }
    
    
    
    WebControllerViewController *webController=[storyBoard instantiateViewControllerWithIdentifier:@"webContent"];
    [webController setWebUrl:strUrl];
    [webController setWebTitle:title];
    [self.navigationController pushViewController:webController animated:YES];
     [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void)webmethod:(NSString*)Title weburl:(NSString*)url

{
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebControllerViewController *webController=[storyBoard instantiateViewControllerWithIdentifier:@"webContent"];
    [webController setWebTitle:Title];
    [webController setIsPresentView:YES];
    [webController setWebUrl:url];
    [self presentViewController:webController animated:YES completion:nil];
}
-(void)CallEmailDirectionMethod:(UIButton*)sender
{
    
    if (sender.tag==1 || sender.tag==11)
    {
        NSString *callStr=[NSString stringWithFormat:@"Would You Like To Call %@",phoneNumber];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Call" message:callStr delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"YES", nil];
        [alert setTag:101];
        [alert show];
    }
    else if (sender.tag==2 || sender.tag==22)
    {
        [self sendMailTo:departmentMail];
    }
    else if (sender.tag==3 || sender.tag==33)
    {
        UIAlertView *mapAlert=[[UIAlertView alloc]initWithTitle:@"Get Directions" message:@"This will open your Map application, are you sure want to exit?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [mapAlert setTag:102];
        [mapAlert show];
    }
  
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (alertView.tag==101 && buttonIndex==1)
    {
       NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phoneNumber]];
        
            if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
            {
                [[UIApplication sharedApplication] openURL:phoneUrl];
            }
            else
            {
                UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [calert show];
            }

    }
    else if (alertView.tag==102 && buttonIndex==1)
    {
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        NSString *dealerAddress = [NSString stringWithFormat:@"%@ %@ %@ %@",[dealerinfo objectForKey:@"dealerStreet"],[dealerinfo objectForKey:@"dealerCity"],[dealerinfo objectForKey:@"dealerState"],[dealerinfo objectForKey:@"dealerZip"]];
        
        NSString *urlString =[NSString stringWithFormat:@"https://maps.apple.com/?daddr=%@&saddr=%@,%@",[dealerAddress stringByReplacingOccurrencesOfString:@" " withString:@"+"],app.latitude,app.longitude];
            
            NSLog(@"urlstr %@",urlString);
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: urlString]])
            {
                
                [[UIApplication sharedApplication] openURL: [NSURL URLWithString: urlString]];
                
            }
    }
    
    
    

}
//SETUP MailComposerController

-(void)sendMailTo:(NSString *)recipient
{
    self.mailer = [[MFMailComposeViewController alloc] init];
    
    if ([MFMailComposeViewController canSendMail]) {
        
        self.mailer.mailComposeDelegate = self;
        [self.mailer setSubject:@"FeedBack"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:recipient, nil];
        [self.mailer setToRecipients:toRecipients];
        
        
         NSString *emailBody = @"";
        [self.mailer setMessageBody:emailBody isHTML:NO];
        
        [self presentViewController:self.mailer animated:YES completion:nil];
    }
    
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
