//
//  GlobalStuff.h
//  LoveAtTheMovies
//
//  Created by supermandt on 9/6/12.
//  Copyright (c) 2012 LoveATTheMovies.com. All rights reserved.
//

#import "GlobalStuff.h"
//#import "oDealerData.h"

#import <UIKit/UIKit.h>

#define KEY_USERNAME @"username"
#define KEY_USERPASS @"userpass"
#define KEY_SERVERADDRESS @"serveraddress"
#define SCANTYPE_CARDNUMBER 1
#define SCANTYPE_DRIVERSLICENSE 2
#define RESPONSE_SUCCESS @"~SUCCESS~"

#define PAGE_MAIN 1
#define PAGE_DATAENTRY 2
#define PAGE_SIGNATURE 3
#define PAGE_SELECTBIKE 4
#define PAGE_SELECTTIME 5
#define PAGE_SIGNATURESCOMPLETED 6


@interface GlobalStuff : NSObject {
    NSString *website;
    NSUserDefaults *usrDef;
    NSMutableArray *aTerminalItems;
    NSMutableArray *aButtons;
    NSString *sServerAddress;
    NSMutableArray *aHistory;
    NSString *sBarcode;
    NSInteger nScanType;
    UIAlertView *alert;
    UIAlertView *alertwaiting;
    NSString *gAppData;
    NSInteger nPageToGoTo;
    //oDealerData *dd;
    
}
@property NSInteger nPageToGoTo;

@property(nonatomic,retain)   UIAlertView *alertwaiting;
//@property(nonatomic,retain)   oDealerData *dd;

@property(nonatomic,retain) NSString *gAppData;
@property(nonatomic,retain) UIAlertView *alert;
@property(nonatomic,retain)   NSString *sBarcode;
@property(nonatomic,retain)   NSString *sServerAddress;
@property (nonatomic, retain) NSMutableArray *aTerminalItems;
@property (nonatomic, retain) NSMutableArray *aButtons;
@property (nonatomic, retain) NSMutableArray *aHistory;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSUserDefaults *usrDef;
@property     NSInteger nScanType;

+ (id)sharedManager;
-(BOOL)StringInString:(NSString *)str stringtofind:(NSString *)strfind;
-(NSString *)webQueryString:(NSString *)url;
-(NSString *)GetDataPath:(NSString *)filename;
-(NSString *)GetTodaysDateMDY;
-(UIImage *)GetImageFromWeb:(NSString *)path;
-(NSString *)GetUserName;
-(NSString *)GetUserPassword;
-(void)SaveSettings;
-(void)webLoadHtml:(UIWebView *)web html:(NSString *)txtfile;

- (int)CountString:(NSString *)stringToCount inText:(NSString *)text;
-(NSString *)GetStringBetween:(NSString *)s string1:(NSString *)s1 string2:(NSString *)s2;
-(UIImage *)MakeThumbnailOfSize:(UIImage *)img newsize:(CGSize)size;
-(NSString *)GetUserPhoto:(NSString *)username;
-(NSString *)GetUserPhotoThumb:(NSString *)username;

-(void)ShowMessageBox:(NSString *)message  title:(NSString *)newtitle;
-(NSString *)GetServerAddress;
-(void) SaveServerAddress:(NSString *)saddr;



-(NSInteger)GetTotalTerminalItems;


-(void)AddHistoryItem:(NSString *)cardnumber  item:(NSString *)newitem  qty:(NSString *)newqty amount:(NSString *)newamount;
-(void)AddHistoryItem:(NSString *)rec;
-(void)ClearHistory;
-(NSString *) LoadHistoryFromWeb:(NSString *)acct;
-(void)ClearBarcode;
-(void)WebConnectStart:(NSString *)mes;
-(void)WebConnectEnd;
-(void)ShowWaitingMessageStart:(NSString *)title;
-(void)ShowWaitingMessageEnd;
-(NSString *)GetDateTime;
-(NSString *)Trim:(NSString *)s;
-(void) playSound:(NSString *)mp3;
-(NSString *)StringAfter:(NSString *)str  stringtofind:(NSString *)sfind;
-(NSString *)StringBefore:(NSString *)str  stringtofind:(NSString *)sfind;
+(NSString *)RemoveDiacritics:(NSString *)str;
+(NSString *)FormatForPhone:(NSString *)phone;

@end