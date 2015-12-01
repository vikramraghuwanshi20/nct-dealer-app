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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        ifImageView =  NO;
        // Custom initialization
    }
    return self;
}
//-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
//{
//    return UIBarPositionTopAttached;
//}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    viewFullPhoto.center = CGPointMake(160, 830);
    [self.view bringSubviewToFront:viewFullPhoto];
    [self LoadImages];
    self.viewFullPhoto.hidden=YES;
}


-(void)LoadImages
{
    imgInsurance.image = [globals LoadPhotoFromDisk:FILE_INSURANCE];
    
    imgDrivers.image = [globals LoadPhotoFromDisk:FILE_DRIVERSLICENSE];
    
    imgLicensePlate.image = [globals LoadPhotoFromDisk:FILE_LICENSEPLATE];
    
    imgParkingSpot.image = [globals LoadPhotoFromDisk:FILE_PARKINGSPOT];
}

- (void)viewDidUnload
{
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


//- (IBAction)BackClick:(id)sender 
//{
//   
//    CreateDelegate();
//    
//    [mview viewDidAppear:TRUE];
//   
//    [self dismissViewControllerAnimated:YES completion:nil];
////    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//
//    
//}

- (IBAction)CloseFullViewClick:(id)sender 
{
    CreateDelegate();
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    viewFullPhoto.center = CGPointMake(160, 830);    
   
    [UIView commitAnimations];

    
}

- (IBAction)Backbuttonclicked:(UIBarButtonItem *)sender {
    
    if (ifImageView) {
        viewFullPhoto.hidden = YES;
        ifImageView = NO;
    }else{
    CreateDelegate();
    
    [mview viewDidAppear:TRUE];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(void)ShowFullView
{
    ifImageView = YES;
    CreateDelegate();
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    viewFullPhoto.center = CGPointMake(190, 270);
    
    [UIView commitAnimations];
   
}







- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

- (IBAction)ViewInsuranceCardClick:(id)sender 
{
    self.navigationController.navigationBarHidden=YES;
    viewFullPhoto.hidden=NO;
    PhotoDetail.hidden=YES;
    strPhotoName = FILE_INSURANCE;
    imgPhotoFullView.image = [globals LoadPhotoFromDisk:strPhotoName];
    imgInsurance.image = imgPhotoFullView.image;

    [self FixScrollView];
    [self ShowFullView];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	
    [globals SavePhotoToDisk:image filename:strPhotoName];
	[self LoadImages];
    [picker dismissModalViewControllerAnimated:YES];
    	
	
}

//- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
//{
//	UIGraphicsBeginImageContext( newSize );
//	[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//	UIGraphicsEndImageContext();
//	
//	return newImage;
//}



- (IBAction)SaveDriversLicense:(id)sender 
{
    
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

- (IBAction)ViewDriversLicense:(id)sender 
{
    self.navigationController.navigationBarHidden=YES;
    viewFullPhoto.hidden=NO;
    PhotoDetail.hidden=YES;
    strPhotoName = FILE_DRIVERSLICENSE;
    imgPhotoFullView.image = [globals LoadPhotoFromDisk:strPhotoName];
    imgDrivers.image = imgPhotoFullView.image;

    [self FixScrollView];
    [self ShowFullView];

}


- (IBAction)ViewLicensePlate:(id)sender 
{
    self.navigationController.navigationBarHidden=YES;
    viewFullPhoto.hidden=NO;
    PhotoDetail.hidden=YES;
    
    strPhotoName = FILE_LICENSEPLATE;
    imgPhotoFullView.image = [globals LoadPhotoFromDisk:strPhotoName];
    imgLicensePlate.image = imgPhotoFullView.image;
    
	[sv setContentSize:CGSizeMake(1000,1000)];

    [self FixScrollView];
    [self ShowFullView];

}

- (IBAction)ViewParkingSpot:(id)sender 
{   self.navigationController.navigationBarHidden=YES;
    viewFullPhoto.hidden=NO;
    PhotoDetail.hidden=YES;
    strPhotoName = FILE_PARKINGSPOT;
    imgPhotoFullView.image = [globals LoadPhotoFromDisk:strPhotoName];
    imgParkingSpot.image = imgPhotoFullView.image;
    

    [self FixScrollView];
    
    [self ShowFullView];

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

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)inScroll 
{
    return [self.sv.subviews objectAtIndex:0];

}


-(void)FixScrollView
{
    [sv setContentSize:CGSizeMake(imgPhotoFullView.frame.size.width,imgPhotoFullView.frame.size.height)];
	sv.maximumZoomScale = 4.0;
	sv.minimumZoomScale = 0.75;
	sv.clipsToBounds = YES;
	sv.zoomScale = 0.5;    

}

@end
