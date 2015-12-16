//
//  AppDelegate.m
//  KeenanHonda
//
//  Created by Vikram on 4/16/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "FirstViewController.h"
#import "RightViewController.h"
#import "LeftViewController.h"
#import "MMDrawerVisualState.h"
#import "globals.h"

#import <QuartzCore/QuartzCore.h>
#import "GlobalStuff.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface AppDelegate ()
{
  UIAlertView *alert;
}
@property (strong,nonatomic) MMDrawerController *drawerController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // This sets the text color of the navigation links
    
   [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // This sets the title color of the navigation bar
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    
    GlobalStuff *g = [GlobalStuff sharedManager];
//    g.dd.nDealerNumber = 0;
//    [g.dd LoadDealerInfo];
    
    self.currentCustomer = [[oRewards alloc] init];
    [self.currentCustomer LoadInfo];
    
   //self.drawerController = (MMDrawerController *)self.window.rootViewController;
   
    [self.drawerController setMaximumRightDrawerWidth:280.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
    //[drawerController setDrawerVisualStateBlock:[MMDrawerVisualState swingingDoorVisualStateBlock]];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
 self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        
        //   [locationManager requestAlwaysAuthorization];
    }
#endif
    [self.locationManager startUpdatingLocation];
    
    return YES;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
   
    CLLocation *location=[locations lastObject];
     self.latitude=[NSString stringWithFormat:@"%f",location.coordinate.latitude];
    self.longitude=[NSString stringWithFormat:@"%f",location.coordinate.longitude];
   
    
    }


-(void)startTimer{
 //self.totalTime = [hourString intValue]*3600 + [minuteString intValue]*60;
NSLog(@"totaltime %d",self.totalTime);
parkingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                target:self
                                              selector:@selector(runScheduledTask:)
                                              userInfo:nil
                                               repeats:YES];
}
- (void)runScheduledTask: (NSTimer *) runningTimer {
    int hours, minutes, seconds;
    self.totalTime--;
    hours = self.totalTime / 3600;
    minutes = (self.totalTime % 3600) / 60;
    seconds = (self.totalTime %3600) % 60;
    self.strTimeCounter =[NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    NSLog(@"timer %@",self.strTimeCounter);
    if (self.totalTime==0) {
        [parkingTimer invalidate];
       // self.strTimeCounter = @"Time up!!";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateLable" object:self.strTimeCounter];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+(BOOL)isIPHONE
{
    NSString *deviceType = [UIDevice currentDevice].model;
    if( [AppDelegate StringInString:deviceType stringtofind:@"Simulator"] )
    {
        return FALSE;
        
    }
    
    
    return [AppDelegate StringInString:deviceType stringtofind:@"iPhone"];
    
}


//////////////////////////////////////
+(BOOL)StringInString:(NSString *)str stringtofind:(NSString *)strfind
{
    
    NSRange rng = [str rangeOfString:strfind];
    return rng.length > 0;
    
}

+ (AppDelegate *)current
{
    return [[UIApplication sharedApplication] delegate];
}

- (NSString *)UpdateFromWebWithAccountNumber:(NSString *)acctNo andZip:(NSString *)zip
{
    [self RefreshDataStart];
    
    NSString *strAcctNumber = acctNo;
    NSString *zipcode = zip;
    
    NSString *custdataurl = [NSString stringWithFormat:@"%@/Mobile/GetCustomerInfo.aspx?number=%@&zipcode=%@",NCWEBSITE,strAcctNumber,zipcode];
    
    NSString *results = [globals webQueryString:custdataurl];
    if ([globals StringInString:results stringtofind:@"~SUCCESS~"])
    {
        
        
        NSString *fullname = [NSString stringWithFormat:@"%@ %@",[globals GetStringBetween:results string1:@"<fname>" string2:@"</fname>"],[globals GetStringBetween:results string1:@"<lname>" string2:@"</lname>"] ];
        
        self.currentCustomer.acctnumber = strAcctNumber;
        self.currentCustomer.zipcode = zipcode;
        
        //o.barcode = newBarImage;
        
        self.currentCustomer.fullname = fullname;
        
        self.currentCustomer.pointsbalance = [globals GetStringBetween:results string1:@"<pointsbalance>" string2:@"</pointsbalance>"];
        
        self.currentCustomer.bdesc1 = [globals GetStringBetween:results string1:@"<bdesc1>" string2:@"</bdesc1>"];
        self.currentCustomer.bdesc2 = [globals GetStringBetween:results string1:@"<bdesc2>" string2:@"</bdesc2>"];
        self.currentCustomer.bdesc3 = [globals GetStringBetween:results string1:@"<bdesc3>" string2:@"</bdesc3>"];
        self.currentCustomer.bdesc4 = [globals GetStringBetween:results string1:@"<bdesc4>" string2:@"</bdesc4>"];
        
        self.currentCustomer.qty1 = [globals GetStringBetween:results string1:@"<qty1>" string2:@"</qty1>"];
        self.currentCustomer.qty2 = [globals GetStringBetween:results string1:@"<qty2>" string2:@"</qty2>"];
        self.currentCustomer.qty3 = [globals GetStringBetween:results string1:@"<qty3>" string2:@"</qty3>"];
        self.currentCustomer.qty4 = [globals GetStringBetween:results string1:@"<qty4>" string2:@"</qty4>"];
        
        [self.currentCustomer SaveInfo];
        [self RefreshDataEnd];
        
    }
    else
    {
        [self RefreshDataEnd];
    }
    
    return results;
}

-(void)RefreshDataStart
{
    
    alert = [[UIAlertView alloc] initWithTitle:@"Updating Rewards Info\nPlease Wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);
    [indicator startAnimating];
    [alert addSubview:indicator];
    
    
}
-(void)RefreshDataEnd
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}


@end
