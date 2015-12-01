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

#import "MBProgressHUD.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface FirstViewController ()
{
    MBProgressHUD *hud;
    
    NSDictionary *dataDict;
    UINavigationBar *navigationBar;
    
}
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIImageView *launchImg;
@property (nonatomic, strong) UIActivityIndicatorView *aiVIew;
@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDataForApp];
    [self setupLeftMenuButton];
    //[self setupRightMenuButton];
    hud=[[MBProgressHUD alloc]init];
    [self.mainView bringSubviewToFront:hud];
    // Set Navigationbar color
    [hud show:YES];
_iconsArray = [@[@"007.png",@"Schdule-Service.png",@"003.png",@"CameraIcon.png",@"005.png",@"006.png",@"Rodside.png",@"008.png", @"TrafficIcon.png"] mutableCopy];
_titleArray=[@[@"Show Floor",@"Schedule Service",@"Dealer News",@"Photo Cabinate",@"Rewards",@"Specials",@"Roadside Assistance",@"Local Gas Price",@"Traffic Report"]mutableCopy];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewSetUp) name:@"update" object:nil];
    [self setLoadingView];
    [self launchView];
    
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

-(void)loadDataForApp{
    
    webResponse=[[WebData alloc]init];
    webResponse.delegate=self;
    [webResponse postData:DATA_URL];
    
}
-(void)viewSetUp{
    
    dataDict=[webResponse getAppData];
    if ([webResponse showBgImage]) {
        
        bgImage.image=[webResponse showBgImage];
        
        [self.mainView removeFromSuperview];
        [self.launchImg removeFromSuperview];
        [self.navigationController setNavigationBarHidden:   NO animated:YES];
    }
    // [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:@"bgImage.png"];
}


-(void)viewWillAppear:(BOOL)animated{
    UIImage *barImage=[[UIImage imageNamed:@"navBarFade.png"]
                       resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:barImage                                                forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //self.navigationController.navigationBar.translucent = YES;
    //    self.navigationController.view.backgroundColor = Rgb2UIColor(0.0f/255.0f, 0.0f/255.0f, 0.0f/255.0f, 0.0f);
    
    //[[UINavigationBar appearance] setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLeftMenuButton {
    
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    leftDrawerButton.tintColor=[UIColor whiteColor];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton];
}
- (void)setupRightMenuButton {
    UIImage *phoneImage=[[UIImage imageNamed:@"mphone.png"]
                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(0.0, 0.0, 25.0, 25.0)];
    [button1 addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setImage:phoneImage forState:UIControlStateNormal];
    
    MMDrawerBarButtonItem * rightDrawerButton = [[MMDrawerBarButtonItem alloc] initWithCustomView:button1];
    
    //    MMDrawerBarButtonItem * rightDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightDrawerButtonPress:)];
    //    rightDrawerButton.tintColor=[UIColor whiteColor];
    
    [self.navigationItem setRightBarButtonItem:rightDrawerButton];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
}

#pragma mark -
#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return _iconsArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainViewCell *myCell = [collectionView
                            dequeueReusableCellWithReuseIdentifier:@"mainCell"
                            forIndexPath:indexPath];
    
    UIImage *image;
    NSInteger row = [indexPath row];
    
    image = [UIImage imageNamed:_iconsArray[row]];
    
    myCell.imgIcon.image= image;
    myCell.lblIconTitle.text=_titleArray[row];
    return myCell;
}
#pragma mark -
#pragma mark UICollectionViewDataSource

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableString *strUrl;
    NSString *title;
    NSDictionary *dealerinfoDict = [dataDict objectForKey:@"dealerInfo"];
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (indexPath.row == 0 ){
        strUrl=[dealerinfoDict objectForKey:@"dealerNewSalesInventoryURL"];
        title = Show_Floor;
        //return;
    }
    else if (indexPath.row ==2){
        
        UINavigationController *leftItem=[storyBoard instantiateViewControllerWithIdentifier:@"leftmenuitems"];
        NSArray *controllers=[leftItem viewControllers];
        LeftItemsController *rssFeed = [controllers objectAtIndex:0];
        [rssFeed setDataUrls:[[dataDict objectForKey:@"dealerRSS"] objectForKey:@"dealerNewsRSS"]];
        [rssFeed setMainMenu:@"Main"];
        [rssFeed setNewsTitle:@"Dealer News"];
        [self presentViewController:leftItem animated:YES completion:nil];
        return;
    }
    else if (indexPath.row==4){
        ODOClubViewController *odoClub=[storyBoard instantiateViewControllerWithIdentifier:@"odoclub"];
        [self.navigationController pushViewController:odoClub animated:YES];
        return;
    }
    else if (indexPath.row == 8){
        strUrl=[Traffic_Report mutableCopy];
        title=@"Traffic Report";
 
    }
    else if (indexPath.row==1){
        strUrl=[dealerinfoDict objectForKey:@"dealerServiceURL"];
        title=@"Schedule Service";
    }
    else if (indexPath.row==3)

    {   PhotoSave *photoSave=[storyBoard instantiateViewControllerWithIdentifier:@"PhotoSave"];
        [self presentViewController:photoSave animated:YES completion:nil];
       //[self.navigationController pushViewController:photoSave animated:YES];

        return;
    }
    else if(indexPath.row==5){
        strUrl=[dealerinfoDict objectForKey:@"dealerNewSalesSpecialsURL"];
        title=@"Specials";
    }
    else if (indexPath.row==6){
        TableController *tableView=[storyBoard instantiateViewControllerWithIdentifier:@"tableController"];
        [tableView setFinance:NO];
        [self presentViewController:tableView animated:YES completion:nil];
        return;
    }
    else if (indexPath.row==7){
        strUrl=[LOCAL_GAS_LINK mutableCopy];
        title=@"Local Gas";
    }
    WebControllerViewController *webController=[storyBoard instantiateViewControllerWithIdentifier:@"webContent"];
    [webController setWebUrl:strUrl];
    [webController setWebTitle:title];
    [self.navigationController pushViewController:webController animated:YES];
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height ==568){
        
        return CGSizeMake(95, 113.f);
    }else if (screenBounds.size.height <=480){
        return CGSizeMake(80, 98.f);
    }
    return CGSizeMake(110.f, 128.f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height ==568){
        
        return UIEdgeInsetsMake(50, 10, 0, 10);
    }else if (screenBounds.size.height <=480){
        return UIEdgeInsetsMake(100, 10, 0, 10);
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}



@end
