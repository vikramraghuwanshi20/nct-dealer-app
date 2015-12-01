//
//  MapController.m
//  KeenanHonda
//
//  Created by Vikram on 4/20/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "MapController.h"
#import "WebData.h"
#import "AppDelegate.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MapController ()
{
    AppDelegate *app;
    UIView *titleView;
    
    NSMutableArray *hourArray;
    NSMutableArray *minuteArray;
    NSMutableArray *reminderArray;
    NSInteger section;
    NSMutableArray *mainArray;
    NSString *hourString;
    NSString *minuteString;
//    NSTimer *parkingTimer;
//    int totalTime;
//    NSInteger currSeconds;
//    NSInteger currMinutes;
//    NSInteger currHour;
}
@end

@implementation MapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.mapView.delegate = self;
   locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
       [locationManager requestWhenInUseAuthorization];
        NSLog(@"CALL");
     //   [locationManager requestAlwaysAuthorization];
    }
#endif
        [locationManager startUpdatingLocation];
    self.mapView.showsUserLocation = YES;
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    
//SET ARRAY ForTimer
    mainArray=[[NSMutableArray alloc]init];
    minuteArray=[[NSMutableArray alloc]init];
    for (NSInteger i=0; i<60; i++) {
        [minuteArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    hourArray=[[NSMutableArray alloc]init];
    for (NSInteger i=0; i<24; i++) {
        [hourArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    reminderArray=[[NSMutableArray alloc]init];
    for (NSInteger i=0; i<=12; i++) {
        if (i==0)
            [reminderArray addObject:[NSString stringWithFormat:@"No Reminder"]];
            else
            [reminderArray addObject:[NSString stringWithFormat:@"%ld Minutes Before",i*5]];
    }
    NSLog(@"hour %@",hourArray);
//SET Timer & Reminder View
    self.timerView.layer.borderColor=[UIColor blackColor].CGColor;
    self.timerView.layer.borderWidth=5;
    self.timerView.layer.cornerRadius=10;
    
    
    self.reminderView.layer.borderColor=[UIColor blackColor].CGColor;
    self.reminderView.layer.borderWidth=5;
    self.reminderView.layer.cornerRadius=10;
//Hide PickerView
    self.verticalSpace.constant -=70;
    [self.toolBar layoutIfNeeded];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTimerLable:) name:@"updateLable" object:nil];
    
}
-(void)viewWillAppear:(BOOL)animated{
    titleView=[[UIView alloc]initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.origin.x,-20, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height+20)];
    titleView.backgroundColor=[UIColor blackColor];
    titleView.alpha=0.7f;
    [ self.navigationController.navigationBar insertSubview:titleView atIndex:0];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(tapBack)];
    self.navigationItem.leftBarButtonItem = backButton;
   
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    NSLog(@"%@", [self deviceLocation]);
    
    //View Area
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = locationManager.location.coordinate.latitude;
    region.center.longitude = locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 0.005f;
    region.span.longitudeDelta = 0.005f;
    [self.mapView setRegion:region animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)tapBack{
    titleView.backgroundColor=[UIColor clearColor];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}
- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
}
- (NSString *)deviceLat {
    return [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude];
}
- (NSString *)deviceLon {
    return [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude];
}
- (NSString *)deviceAlt {
    return [NSString stringWithFormat:@"%f", locationManager.location.altitude];
}


//PickerView DataSource Delegate

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return section;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [mainArray count];
    }
    else {
        return [minuteArray count];
    }
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [mainArray objectAtIndex:row];
    }
    else if (component == 1) {
        return [minuteArray objectAtIndex:row];
    }
    return nil;
}



-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    
    if (component==0)
        hourString = hourArray[row];
    else
       minuteString = minuteArray[row];
    
//    ProfileCell *cell=(ProfileCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:forPicker inSection:3]];
//    
//    cell.lblContacPref.text=resultString;
    NSLog(@"H & M %@,%@",hourString,minuteString);
    
}



-(IBAction)setMapType:(UISegmentedControl *)sender{

    switch (sender.selectedSegmentIndex) {
            
            case 0:
            self.mapView.mapType=MKMapTypeStandard;
            break;
            
            case 1:
            self.mapView.mapType=MKMapTypeHybrid;
            break;
            
        default:
            break;
    }

}

- (IBAction)tapTimer:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        self.verticalSpace.constant +=250;
        [self.view layoutIfNeeded];
    }];
    section=2;
    mainArray=hourArray;
    [self.pickerView reloadAllComponents];
}

- (IBAction)tapReminder:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        self.verticalSpace.constant +=250;
        [self.view layoutIfNeeded];
    }];
    section=1;
    mainArray=reminderArray;
   
    [self.pickerView reloadAllComponents];
}

- (IBAction)tapCancel:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        self.verticalSpace.constant -=250;
        [self.view layoutIfNeeded];
    }];
}


- (IBAction)tapDone:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        self.verticalSpace.constant -=250;
        [self.view layoutIfNeeded];
    }];
    
    [app setTotalTime:[hourString intValue]*3600 + [minuteString intValue]*60];
    [app startTimer];
  //  self.lblTimerCount.text=[app strTimeCounter];
   // NSLog(@"timer %@",self.lblTimerCount.text);
//    NSLog(@"totaltime %d",totalTime);
//    parkingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
//                                                   target:self
//                                                  selector:@selector(runScheduledTask:)
//                                                 userInfo:nil
//                                                  repeats:YES];
}
-(void)setTimerLable:(NSNotification *)noti{
    NSLog(@"set %@",noti.object);
    self.lblTimerCount.text=[NSString stringWithFormat:@"%@",noti.object];
}
//- (void)runScheduledTask: (NSTimer *) runningTimer {
//    int hours, minutes, seconds;
//    totalTime--;
//    hours = totalTime / 3600;
//    minutes = (totalTime % 3600) / 60;
//    seconds = (totalTime %3600) % 60;
//    self.lblTimerCount.text =[NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
//    if (totalTime==0) {
//        [parkingTimer invalidate];
//        self.lblTimerCount.text = @"Time up!!";
//    }
//}
@end
