//
//  PhotoSave.m
//  Dealership
//
//  Created by supermandt on 10/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoSave.h"

#define FILE_INSURANCE @"InsurancePhoto.jpg"
#define FILE_DRIVERSLICENSE @"DriversLicPhoto.jpg"
#define FILE_LICENSEPLATE @"LicensePlate.jpg"
#define FILE_PARKINGSPOT @"ParkingSpot.jpg"

@implementation PhotoSave
@synthesize sv;
@synthesize SaveLicensePlate;
@synthesize imgInsurance;
@synthesize imgDrivers;
@synthesize imgLicensePlate;
@synthesize imgParkingSpot;
@synthesize imgPhotoFullView;
@synthesize viewFullPhoto;
@synthesize imgPhoto,strPhotoName,mview,PhotoDetail;



#pragma mark
#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        ifImageView =  NO;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    //viewFullPhoto.center = CGPointMake(160, 830);
    [self.view bringSubviewToFront:viewFullPhoto];
    [self LoadImages];
    self.viewFullPhoto.hidden=YES;
}

- (void)viewDidUnload{
    
    [self setImgPhoto:nil];
    strPhotoName = nil;
    [self setImgPhotoFullView:nil];
    [self setViewFullPhoto:nil];
    [self setImgInsurance:nil];
    [self setImgDrivers:nil];
    [self setImgLicensePlate:nil];
    [self setImgParkingSpot:nil];
    [self setSaveLicensePlate:nil];
    [self setSv:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    sv.maximumZoomScale = 4.0;
    sv.minimumZoomScale = 0.75;
    sv.clipsToBounds = YES;
    sv.zoomScale = 0.5;
}


-(void)LoadImages{
    imgInsurance.image = [globals LoadPhotoFromDisk:FILE_INSURANCE];
    
    imgDrivers.image = [globals LoadPhotoFromDisk:FILE_DRIVERSLICENSE];
    
    imgLicensePlate.image = [globals LoadPhotoFromDisk:FILE_LICENSEPLATE];
    
    imgParkingSpot.image = [globals LoadPhotoFromDisk:FILE_PARKINGSPOT];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Button Action

- (IBAction)ViewDriversLicense:(id)sender
{
    
    viewFullPhoto.hidden=NO;
    PhotoDetail.hidden=YES;
    strPhotoName = FILE_DRIVERSLICENSE;
    self.navigationController.navigationBarHidden=YES;
    imgPhotoFullView.image = [globals LoadPhotoFromDisk:strPhotoName];
    imgDrivers.image = imgPhotoFullView.image;
    
    [self FixScrollView];
    [self ShowFullView];
    
}

- (IBAction)ViewInsuranceCardClick:(id)sender {
    
    viewFullPhoto.hidden=NO;
    PhotoDetail.hidden=YES;
    strPhotoName = FILE_INSURANCE;
    self.navigationController.navigationBarHidden=YES;
    imgPhotoFullView.image = [globals LoadPhotoFromDisk:strPhotoName];
    imgInsurance.image = imgPhotoFullView.image;
    
    [self FixScrollView];
    [self ShowFullView];
}

- (IBAction)ViewLicensePlate:(id)sender 
{
   
    viewFullPhoto.hidden=NO;
    PhotoDetail.hidden=YES;
    
    strPhotoName = FILE_LICENSEPLATE;
    self.navigationController.navigationBarHidden=YES;
    imgPhotoFullView.image = [globals LoadPhotoFromDisk:strPhotoName];
    imgLicensePlate.image = imgPhotoFullView.image;
    [sv setContentSize:CGSizeMake(1000,1000)];

    [self FixScrollView];
    [self ShowFullView];

}

- (IBAction)ViewParkingSpot:(id)sender{
    
    self.navigationController.navigationBarHidden=YES;
    viewFullPhoto.hidden=NO;
    PhotoDetail.hidden=YES;
    strPhotoName = FILE_PARKINGSPOT;
    imgPhotoFullView.image = [globals LoadPhotoFromDisk:strPhotoName];
    imgParkingSpot.image = imgPhotoFullView.image;
    
    [self FixScrollView];
    [self ShowFullView];

}
- (IBAction)SaveInsuraceCardClick:(id)sender
{
    GlobalStuff *g=[GlobalStuff sharedManager];
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [g ShowMessageBox:@"The camera option is not available on this device!" title:@"Sorry"];
        return;
    }
    
    strPhotoName = FILE_INSURANCE;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
    
}


- (IBAction)SaveLicensePlate:(id)sender
{
    GlobalStuff *g=[GlobalStuff sharedManager];
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [g ShowMessageBox:@"The camera option is not available on this device!" title:@"Sorry"];

        return;
    }
    
    strPhotoName = FILE_LICENSEPLATE;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];


}

- (IBAction)SaveParkingSpot:(id)sender 
{
    GlobalStuff *g=[GlobalStuff sharedManager];
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [g ShowMessageBox:@"The camera option is not available on this device!" title:@"Sorry"];
        return;
    }
    
    strPhotoName = FILE_PARKINGSPOT;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	[self presentViewController:picker animated:YES completion:nil];


}

- (IBAction)SaveDriversLicense:(id)sender {
    
    GlobalStuff *g=[GlobalStuff sharedManager];
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [g ShowMessageBox:@"The camera option is not available on this device!" title:@"Sorry"];
        return;
    }
    
    strPhotoName = FILE_DRIVERSLICENSE;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)Backbuttonclicked:(UIBarButtonItem *)sender {
    
    if (ifImageView){
        viewFullPhoto.hidden = YES;
        PhotoDetail.hidden=NO;
        ifImageView = NO;
    }
    else{
        //CreateDelegate();
        [mview viewDidAppear:TRUE];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)CloseFullViewClick:(id)sender {
    //CreateDelegate();
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    viewFullPhoto.center = CGPointMake(160, 830);
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark Common Methods

-(void)ShowFullView{
    
    ifImageView = YES;
    //CreateDelegate();
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    //viewFullPhoto.center = CGPointMake(160, 260);
    //viewFullPhoto.center = CGPointMake(160,230);
   // viewFullPhoto.frame=CGRectMake(50, 100,300, 500);
   // viewFullPhoto.frame=CGRectMake(0, 50, 414, 730);
    //viewFullPhoto.backgroundColor=[UIColor blackColor];
    //sv.frame = CGRectMake(0, 0, 414, 730);
    
    //imgPhotoFullView.frame = CGRectMake(0, 0, 414, 730);
    //imgPhotoFullView.center = viewFullPhoto.superview.center;
   // [imgPhotoFullView setContentMode:UIViewContentModeCenter];
    //imgPhotoFullView.frame=CGRectMake(20, 0,300, 500);
   // imgPhotoFullView.backgroundColor=[UIColor whiteColor];
    
    
    
    
    //[imgPhotoFullView setFrame:CGRectMake(100, 100, 200, 200)];
    
  //  UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
   // [imgView setImage:[UIImage imageNamed:"image.png"]];
    [UIView commitAnimations];
}


-(void)FixScrollView{
    [sv setContentSize:CGSizeMake(imgPhotoFullView.frame.size.width,imgPhotoFullView.frame.size.height)];
	sv.maximumZoomScale = 4.0;
	sv.minimumZoomScale = 0.75;
	sv.clipsToBounds = YES;
	sv.zoomScale = 0.5;    
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)inScroll{
    return [self.sv.subviews objectAtIndex:0];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    [globals SavePhotoToDisk:image filename:strPhotoName];
    [self LoadImages];
    [picker dismissModalViewControllerAnimated:YES];
}

@end
