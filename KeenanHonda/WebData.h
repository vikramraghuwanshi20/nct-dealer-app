//
//  WebData.h
//  KeenanHonda
//
//  Created by Vikram on 4/17/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLDictionary.h"
#import "oRewards.h"


@class XMLDictionry;
@protocol WebDataDelegate <NSObject>

-(void)dataDidFinishLoading:(NSDictionary *)response;
-(void)failToGetData:(NSError *)error;
-(void)displayImage:(UIImage *)img;
-(void)forHeaderImage:(UIImage *)img;

@end

@interface WebData : NSObject<NSXMLParserDelegate>
{
    
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSString *element;
    
    XMLDictionry *xmlDict;
    NSMutableString *startElement;
    NSString *endElement;
    //NSDictionary *xmlDict;
    NSMutableData *webData;
    NSURLConnection *connection;
    NSUserDefaults *de;
    NSDictionary *dataDict;
    NSDictionary *locDict;
     UIAlertView *alert;
    BOOL isUpdated;
    
    NSInteger initialLoading;
    NSArray *imageArray;
}
-(void)postData:(NSString *)urlString;
-(void)postXMLData:(NSString *)urlString;
- (NSString *)UpdateFromWebWithAccountNumber:(NSString *)acctNo andZip:(NSString *)zip;

-(void)saveDataToUserDefault:(NSDictionary *)dict;

-(NSDictionary *)getAppData;
-(NSDictionary *)getLocation;
-(UIImage *)showBgImage;
-(UIImage *)showHeaderImage;
-(UIImage *)showLoadingImage;
-(UIImage *)showRewardsCardImage;



@property (nonatomic, strong) oRewards *currentCustomer;
@property(nonatomic,weak) id<WebDataDelegate> delegate;
@end
