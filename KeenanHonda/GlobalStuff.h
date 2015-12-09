//
//  GlobalStuff.h
//  LoveAtTheMovies
//
//  Created by supermandt on 9/6/12.
//  Copyright (c) 2012 LoveATTheMovies.com. All rights reserved.
//

#import "GlobalStuff.h"
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
    
    NSUserDefaults *usrDef;
    NSMutableArray *aTerminalItems;
    NSMutableArray *aButtons;
    NSMutableArray *aHistory;
    UIAlertView *alertwaiting;
    UIAlertView *alert;
    NSString *sBarcode;
    NSString *gAppData;
    NSString *website;
    NSString *sServerAddress;
    NSInteger nPageToGoTo;
    NSInteger nScanType;
    
}
@property(nonatomic,retain)UIAlertView *alertwaiting;
@property(nonatomic,retain)UIAlertView *alert;
@property(nonatomic,retain)NSString *sBarcode;
@property(nonatomic,retain)NSString *gAppData;
@property(nonatomic,retain)NSString *website;
@property(nonatomic,retain)NSString *sServerAddress;
@property(nonatomic,retain)NSMutableArray *aTerminalItems;
@property(nonatomic,retain)NSMutableArray *aButtons;
@property(nonatomic,retain)NSMutableArray *aHistory;
@property(nonatomic,retain)NSUserDefaults *usrDef;
@property NSInteger nScanType;
@property NSInteger nPageToGoTo;


+ (id)sharedManager;
-(BOOL)StringInString:(NSString *)str stringtofind:(NSString *)strfind;
-(NSString *)webQueryString:(NSString *)url;
-(NSString *)GetDataPath:(NSString *)filename;
-(NSString *)GetTodaysDateMDY;
-(NSString *)GetUserName;
-(NSString *)GetUserPassword;
-(NSString *)GetUserPhoto:(NSString *)username;
-(NSString *)GetUserPhotoThumb:(NSString *)username;
-(NSString *)GetServerAddress;
-(NSString *)GetStringBetween:(NSString *)s string1:(NSString *)s1 string2:(NSString *)s2;
-(NSString *)GetDateTime;
-(NSString *)Trim:(NSString *)s;
-(NSString *)StringAfter:(NSString *)str  stringtofind:(NSString *)sfind;
-(NSString *)StringBefore:(NSString *)str  stringtofind:(NSString *)sfind;
-(NSString *)LoadHistoryFromWeb:(NSString *)acct;
+(NSString *)RemoveDiacritics:(NSString *)str;
+(NSString *)FormatForPhone:(NSString *)phone;

-(void)SaveSettings;
-(void)AddHistoryItem:(NSString *)rec;
-(void)ClearHistory;
-(void)ClearBarcode;
-(void)WebConnectStart:(NSString *)mes;
-(void)WebConnectEnd;
-(void)ShowWaitingMessageStart:(NSString *)title;
-(void)ShowWaitingMessageEnd;
-(void) playSound:(NSString *)mp3;
-(void)webLoadHtml:(UIWebView *)web html:(NSString *)txtfile;
-(void) SaveServerAddress:(NSString *)saddr;
-(void)ShowMessageBox:(NSString *)message  title:(NSString *)newtitle;
-(void)AddHistoryItem:(NSString *)cardnumber  item:(NSString *)newitem  qty:(NSString *)newqty amount:(NSString *)newamount;
- (int)CountString:(NSString *)stringToCount inText:(NSString *)text;
-(UIImage *)MakeThumbnailOfSize:(UIImage *)img newsize:(CGSize)size;
-(UIImage *)GetImageFromWeb:(NSString *)path;
-(NSInteger)GetTotalTerminalItems;



@end