//
//  oDealerData.h
//  LoeberMotors
//
//  Created by ncompasstrac on 4/6/14.
//
//

#import <Foundation/Foundation.h>
#include "iRecord.h"

enum DEALER_NUMBER {
	kDealerMERCEDES =1,
	kDealerPORSCHE,
	kDealerSPRINTER,
    kDealerSMART
    
};


#define D_DNAME  @"dname"
#define D_DTAGLINE @"dtagline"
#define D_ADDRESS1 @"address1"
#define D_ADDRESS2 @"address2"
#define D_CITY  @"city"
#define D_STATE @"state"
#define D_ZIP   @"zip"
#define D_PHONE  @"phone"
#define D_FAX  @"fax"
#define D_EMAIL  @"email"
#define D_WEBSITE  @"website"
#define D_MAKEAPPTWEBSITE  @"makeapptwebsite"
#define D_MAKEAPPTWEBSITEPORSCHE @"makeapptwebsiteporsche"
#define D_CONTACTWEBSITE  @"contactwebsite"
#define D_TESTIMONIALWEBSITE  @"testimonialwebsite"
#define D_REPUTATIONWEBSITE  @"reputationwebsite"
#define D_HISTORYWEBSITE  @"historywebsite"
#define D_EMPLOYMENTWEBSITE  @"employmentwebsite"
#define D_ROADSIDEPHONE @"roadsidephone"
#define D_ROADSIDEPHONEPORSCHE @"roadsidephoneporsche"
#define D_CARWASHPHONE @"carwashphone"
#define D_CARWASHDAYS @"carwashdays"
#define D_CARWASHHOURS @"carwashhours"
#define D_NEWSALESPHONE @"newsalesphone"
#define D_NEWSALESEMAIL @"newsalesemail"
#define D_NEWSALESINVENTORY @"newsalesinventory"
#define D_NEWSALESINVENTORYPORSCHE @"newsalesinventoryporsche"
#define D_NEWSALESINVENTORYSPRINTER @"newsalesinventorysprinter"
#define D_NEWSALESINVENTORYSMART @"newsalesinventorysmart"
#define D_NEWSALESSPECIALS  @"newsalesspecials"
#define D_NEWSALESHOURS @"newsaleshours"
#define D_NEWSALESDAYS @"newsalesdays"
#define D_PREOWNEDPHONE @"preownedphone"
#define D_PREOWNEDEMAIL @"preownedemail"
#define D_PREOWNEDINVENTORY @"preownedinventory"
#define D_PREOWNEDINVENTORYPORSCHE @"preownedinventoryporsche"
#define D_PREOWNEDSPECIALS @"preownedspecials"
#define D_PREOWNEDHOURS  @"preownedhours"
#define D_PREOWNEDDAYS  @"preowneddays"
#define D_SERVICEPHONE  @"servicephone"
#define D_SERVICEEMAIL  @"serviceemail"
#define D_SERVICEHOURS  @"servicehours"
#define D_SERVICEHOURSPORSCHE  @"servicehoursporsche"
#define D_SERVICEHOURSSPRINTER  @"servicehourssprinter"
#define D_SERVICEHOURSSMART  @"servicehourssmart"
#define D_SERVICEDAYS  @"servicedays"
#define D_SERVICESPECIALS  @"servicespecials"
#define D_PARTSPHONE  @"partsphone"
#define D_PARTSFAX  @"partsfax"
#define D_PARTSEMAIL  @"partsemail"
#define D_PARTSHOURS  @"partshours"
#define D_PARTSDAYS  @"partsdays"
#define D_PARTSSPECIALS  @"partsspecials"
#define D_KBBWEBSITE  @"kbbwebsite"
#define D_FINANCIALWEBSITE @"financialwebsite"
#define D_LOANWEBSITE @"loanwebsite"
#define D_SPRINTERINVENTORY1 @"sprinterinventory1"
#define D_SPRINTERINVENTORY2 @"sprinterinventory2"
#define D_MISC1  @"misc1"
#define D_MISC2  @"misc2"
#define D_MISC3  @"misc3"
#define D_MISC4  @"misc4"
#define D_MISC5  @"misc5"
#define D_TP1  @"tp1"
#define D_TP2  @"tp2"
#define D_TP3  @"tp3"
#define D_TP4  @"tp4"
#define D_NEWSLETTER @"newsletter"
#define D_FACEBOOK @"facebook"
#define D_TWITTER  @"twitter"
#define D_YOUTUBE  @"youtube"
#define D_EBAY  @"ebay"
#define D_YELP  @"yelp"
#define D_ABOUTUSWEBSITE  @"aboutuswebsite"
#define D_NOTES @"notes"
#define D_BENEFITSWEBSITE @"benefitswebsite"
#define D_DIRECTIONSWEBSITE @"directionswebsite"
#define D_DIRECTIONSWEBSITEPORSCHE @"directionswebsiteporsche"
#define D_SMARTINVENTORY1 @"smartinventory1"
#define D_SMARTINVENTORY2  @"smartinventory2"
#define D_REWARDSWEBSITE  @"rewards"


@interface oDealerData : NSObject
{
    NSInteger nDealerNumber;
    NSString *dddata;
}
@property  NSInteger nDealerNumber;
@property(nonatomic,retain)  NSString *dddata;



-(NSString *) DealerGetFld:(NSString *)fld;
-(void) LoadDealerInfo;
-(NSString *)GetRoadSide;


@end
