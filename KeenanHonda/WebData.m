
//
//  WebData.m
//  KeenanHonda
//
//  Created by Vikram on 4/17/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "WebData.h"
#import "AFHTTPRequestOperationManager.h"
#import "XMLDictionary.h"
#import "Costants.h"
#import "globals.h"
#import "SDWebImageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SDWebImageDownloader.h"
#import "RightViewController.h"

#define APP_DATA @"appdata"
@implementation WebData

-(void)postData:(NSString *)urlString{

    initialLoading = 0;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSLog(@"JSON: %@", json);
        [self.delegate dataDidFinishLoading:json];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        [self.delegate failToGetData:error];
    }];
    
    [manager.operationQueue addOperation:op];
    
//    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        [self.delegate dataDidFinishLoading:responseObject];
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
}

- (NSString *)UpdateFromWebWithAccountNumber:(NSString *)acctNo andZip:(NSString *)zip
{
    [self RefreshDataStart];
    
    NSString *strAcctNumber = acctNo;
    NSString *zipcode = zip;
    
    NSString *custdataurl = [NSString stringWithFormat:@"%@/Mobile/GetCustomerInfo.aspx?number=%@&zipcode=%@",NCWEBSITE,strAcctNumber,zipcode];
    
    NSString *results = [self webQueryString:custdataurl];
   
    if ([globals StringInString:results stringtofind:@"~SUCCESS~"])
    {
        
        
        NSString *fullname = [NSString stringWithFormat:@"%@ %@",[globals GetStringBetween:results string1:@"<fname>" string2:@"</fname>"],[globals GetStringBetween:results string1:@"<lname>" string2:@"</lname>"] ];
        self.currentCustomer=[[oRewards alloc]init];
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
         NSLog(@"Specialssssssssssss %@  %@",self.currentCustomer.qty1,self.currentCustomer.bdesc1);
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
    
   alert= [[UIAlertView alloc] initWithTitle:@"Updating Rewards Info\nPlease Wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
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

-(NSString *)webQueryString:(NSString *)url
{
    
    //	 return [NSString stringWithContentsOfURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    //	NSURL *theURL = [[NSURL alloc] initWithString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *encstring = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *theURL = [NSURL URLWithString:encstring];
    //get the data from the web page
    NSString *results = [NSString stringWithContentsOfURL:theURL encoding:NSUTF8StringEncoding error:nil];
    
    return results;
}

-(NSDictionary *)getAppData{
    NSDictionary *dict=[[NSUserDefaults standardUserDefaults] objectForKey:APP_DATA];
    return [dict objectForKey:@"config"];;
}

-(void)saveDataToUserDefault:(NSDictionary *)dict{
 
    NSDictionary *imageDict=[[dict objectForKey:@"config"] objectForKey:@"dealerImages"];
    imageArray = [imageDict allKeys];
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    
        for (int i = 0; i < [imageArray count]; i++) {
            NSString *urlstr=[imageDict objectForKey:[imageArray objectAtIndex:i]];
            NSURL *imageUrl = [NSURL URLWithString:urlstr];
            NSString *imgName=[imageUrl lastPathComponent];
            NSLog(@"image Url %@",urlstr);
            
            [self saveImageFromUrl:imageUrl withImageName:imgName];
        }
    
    if ([de objectForKey:APP_DATA]==nil) {
    de=[NSUserDefaults standardUserDefaults];
    [de setObject:dict forKey:APP_DATA];
    [de synchronize];
    }
}

-(void)saveImageFromUrl:(NSURL *)imgUrl withImageName:(NSString *)imgName{
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
   NSString *writablePath = [documentsDirectoryPath stringByAppendingPathComponent:imgName];
   NSLog(@"write path %@",writablePath);
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"initialLoad"]) {
         [self updateUI];
    }
    
    [self getImageFromURLAndSaveItToLocalData:imgName fileURL:imgUrl inDirectory:documentsDirectoryPath];

 }

-(void) getImageFromURLAndSaveItToLocalData:(NSString *)imageName fileURL:(NSURL *)fileURL inDirectory:(NSString *)directoryPath {
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:fileURL options:SDWebImageRefreshCached progress:^(NSInteger recivesize,NSInteger expectedsize){
    } completed:^(UIImage *image,NSError *error,SDImageCacheType cachetype,BOOL finished,NSURL *imageurl){
        
        initialLoading++;
        
        if (initialLoading == [imageArray count]) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"initialLoad"];
            [self updateUI];
        }
        if (image )
        {
           NSData * data = UIImagePNGRepresentation(image);;
           NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
           NSString *documentsDir  = [documentPaths objectAtIndex:0];
           NSString  *pngfile = [documentsDir stringByAppendingPathComponent:imageName];
           UIImage* checkImage = [UIImage imageWithContentsOfFile:pngfile];
           NSData *checkImageData = UIImagePNGRepresentation(checkImage);
           
           if (![checkImageData isEqualToData:data]){
                NSError *error = nil;
                [data writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imageName]] options:NSAtomicWrite error:&error];
                
                if (error) {
                    NSLog(@"Error Writing File : %@",error);
                }else{
                    [self updateUI];
                    NSLog(@"Image %@ Saved SuccessFully",imageName);
                }
            }
        }
        
     }];
    
 }

- (void)updateUI{
    
  [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:nil];
}

//-(void) getImageFromURLAndSaveItToLocalData:(NSString *)imageName fileURL:(NSURL *)fileURL inDirectory:(NSString *)directoryPath {
//    
//        NSData * data = [NSData dataWithContentsOfURL:fileURL];
//    
//        NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDir  = [documentPaths objectAtIndex:0];
//        NSString  *pngfile = [documentsDir stringByAppendingPathComponent:imageName];
//        UIImage* checkImage = [UIImage imageWithContentsOfFile:pngfile];
//        NSData *checkImageData = UIImagePNGRepresentation(checkImage);
//          if (![checkImageData isEqualToData:data]){
//              NSError *error = nil;
//              [data writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imageName]] options:NSAtomicWrite error:&error];
//    
//              if (error) {
//                  NSLog(@"Error Writing File : %@",error);
//              }else{
//                  [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:nil];
//                  NSLog(@"Image %@ Saved SuccessFully",imageName);
//              }
//          }
//    
//}


-(void)isUpdatedVresion:(NSString *)imgurl imageName:(NSString *)imgName{
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:imgurl] options:SDWebImageRefreshCached progress:^(NSInteger recivesize,NSInteger expectedsize){
    } completed:^(UIImage *image,NSError *error,SDImageCacheType cachetype,BOOL finished,NSURL *imageurl){
        
        if (image )
        {
            
           NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDir  = [documentPaths objectAtIndex:0];
            NSString  *pngfile = [documentsDir stringByAppendingPathComponent:imgName];
            UIImage* checkImage = [UIImage imageWithContentsOfFile:pngfile];
            NSData *checkImageData = UIImagePNGRepresentation(checkImage);
            NSLog(@"error %@,%@,%@",error,imgName,image);
            //New Image
            if (checkImage) {
                
                NSData *newImageData = UIImagePNGRepresentation(image);
                
                if (![checkImageData isEqualToData:newImageData]){
                    [self removeImage:imgName];
                    //   [self saveImages:imgurl imageName:imgName];
                }
            }
        }
        
    }];
}

- (void)removeImage:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (success) {
        NSLog(@"remove sucessfully");
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}

-(UIImage *)showBgImage{
    
NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
NSString *documentsDir  = [documentPaths objectAtIndex:0];
NSString  *pngfile = [documentsDir stringByAppendingPathComponent:@"bgImage.png"];
    return [UIImage imageWithContentsOfFile:pngfile];
}


-(UIImage *)showHeaderImage{
    NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir  = [documentPaths objectAtIndex:0];
    NSString  *pngfile = [documentsDir stringByAppendingPathComponent:@"headerImage.png"];
    return [UIImage imageWithContentsOfFile:pngfile];
}

-(UIImage *)showLoadingImage{
    NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir  = [documentPaths objectAtIndex:0];
    NSString  *pngfile = [documentsDir stringByAppendingPathComponent:@"launchImage.png"];
    return [UIImage imageWithContentsOfFile:pngfile];
}


-(UIImage *)showRewardsCardImage{
    NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir  = [documentPaths objectAtIndex:0];
    NSString  *pngfile = [documentsDir stringByAppendingPathComponent:@"RewardsCard.png"];
    return [UIImage imageWithContentsOfFile:pngfile];
}
@end
