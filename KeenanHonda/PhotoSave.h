//
//  PhotoSave.h
//  Dealership
//
//  Created by supermandt on 10/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "FirstViewController.h"
#import "GlobalStuff.h"
#import "MBProgressHUD.h"

@class MainMenuView;

@interface PhotoSave : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UIBarPositioningDelegate>
{
    NSString *strPhotoName;
    FirstViewController *mview;
    MBProgressHUD *hud;
    BOOL ifImageView;
}
@property (retain, nonatomic) IBOutlet UIImageView *imgPhotoFullView;
@property (retain, nonatomic) IBOutlet UIView *viewFullPhoto;
@property (retain, nonatomic) FirstViewController *mview;
@property (retain, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (retain, nonatomic) NSString *strPhotoName;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic,retain)  IBOutlet UILabel*PhotoDetail;
@property (retain, nonatomic) IBOutlet UIImageView *imgInsurance;
@property (retain, nonatomic) IBOutlet UIImageView *imgDrivers;
@property (retain, nonatomic) IBOutlet UIImageView *imgLicensePlate;
@property (retain, nonatomic) IBOutlet UIImageView *imgParkingSpot;
@property (retain, nonatomic) IBOutlet UIButton *SaveLicensePlate;
@property (retain, nonatomic) IBOutlet UIButton *SaveInsurance;
@property (retain, nonatomic) IBOutlet UIButton *SaveDrivers;
@property (retain, nonatomic) IBOutlet UIButton *SaveParkingSpot;
@property (retain, nonatomic) IBOutlet UIScrollView *sv;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *Backbutton;

- (IBAction)ViewInsuranceCardClick:(id)sender;
- (IBAction)ViewDriversLicense:(id)sender;
- (IBAction)ViewLicensePlate:(id)sender;
- (IBAction)ViewParkingSpot:(id)sender;
- (IBAction)SaveParkingSpot:(id)sender;
- (IBAction)SaveLicensePlate:(id)sender;
- (IBAction)SaveDriversLicense:(id)sender;
- (IBAction)SaveInsuraceCardClick:(id)sender;

- (IBAction)BackClick:(id)sender ;
- (IBAction)CloseFullViewClick:(id)sender;
- (IBAction)Backbuttonclicked:(UIBarButtonItem *)sender;

-(void)ShowFullView;
-(void)LoadImages;
-(void)FixScrollView;


@end
