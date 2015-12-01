//
//  MapController.h
//  KeenanHonda
//
//  Created by Vikram on 4/20/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    CLLocationManager *locationManager;
    CLLocationCoordinate2D theCoordinate;

}
//OutLets

@property (strong, nonatomic) IBOutlet UINavigationItem *setMapType;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *btnTimer;
@property (strong, nonatomic) IBOutlet UIButton *btnReminder;
@property (strong, nonatomic) IBOutlet UILabel *lblTimerCount;
@property (strong, nonatomic) IBOutlet UILabel *lblRemindertime;
@property (strong, nonatomic) IBOutlet UIView *timerView;
@property (strong, nonatomic) IBOutlet UIView *reminderView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *verticalSpace;

//Actions

- (IBAction)setMapType:(UISegmentedControl *)sender;
- (IBAction)tapTimer:(id)sender;
- (IBAction)tapReminder:(id)sender;
- (IBAction)tapCancel:(id)sender;
- (IBAction)tapDone:(id)sender;



@end
