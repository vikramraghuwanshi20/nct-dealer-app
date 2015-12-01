//
//  Costants.h
//  KeenanHonda
//
//  Created by Vikram on 4/21/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#ifndef KeenanHonda_Costants_h
#define KeenanHonda_Costants_h


#define Rgb2UIColor(r, g, b, d)[UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(d)]
#define ABOUT @"About"

//iPHONE SIZES

#define iPHONE_6 [UIScreen mainScreen].bounds.size.height == 667
#define iPHONE_6plus [UIScreen mainScreen].bounds.size.height == 736

//MAIN URL'S

#define NCWEBSITE @"http://www.ncompassmkt.com"
#define IMG_2DFILENAME  @"img_accountnumber.jpg"
#define DATA_URL @"http://www.ncompassmkt.com/Assets/100/AppConfig.txt"
#define OUR_MAIN_WEBSITE @"http://www.ncompasstrac.com"

//MAIN MENUS

#define OWNER_LINK @"http://owners.honda.com"
#define LOCAL_GAS_LINK @"https://m.gasbuddy.com/?gbTouch"
#define Traffic_Report @"https://m.here.com/traffic"

//WEBVIEW CONSTANT

#define Show_Floor @"Show Floor"
#define PRE_OWNED @"Pre-Owned Sales"
#define OUR_WEBSITE @"Our Website"
#define NEW_SALES @"New Sales"

//DEPARTMENTS HOUR

#define NEW_SALES_HOUR @"dealerNewSalesHours"
#define PREOWNED_SALES_HOUR @"dealerPreOwnedSalesHours"
#define SERVICES_HOUR @"dealerServiceHours"
#define PARTS_HOUR @"dealerPartsHours"
#define COLLISION_CENTER_HOUR @"dealerCollisionCenterHours"
#define FINANCE_HOUR @"dealerFinanceHours"

//DEPARTMENTS PHONE

#define MAIN_PHONE @"dealerMainPhone"
#define NEW_SALES_PHONE @"dealerNewSalesPhone"
#define PREOWNED_SALES_PHONE @"dealerPreOwnedSalesPhone"
#define SERVICES_PHONE @"dealerServicePhone"
#define PARTS_PHONE @"dealerPartsPhone"
#define COLLISION_CENTER_PHONE @"dealerCollisionCenterPhone"
#define FINANCE_PHONE @"dealerFinancePhone"

//DEPARTMENTS EMAILS

#define MAIN_EMAIL @""
#define NEW_SALES_EMAIL @"dealerNewSalesEmail"
#define PREOWNED_SALES_EMAIL @"dealerPreOwnedSalesEmail"
#define SERVICES_EMAIL @"dealerServiceEmail"
#define PARTS_EMAIL @"dealerPartsEmail"
#define COLLISION_CENTER_EMAIL @"dealerCollisionCenterEmail"
#define FINANCE_EMAIL @"dealerFinanceEmail"

//DEPARTMENTS URLS

#define MAIN_URL @"dealerWebsite"
#define NEW_SALES_URL @"dealerNewSalesURL"
#define PREOWNED_SALES_URL @"dealerPreOwnedSalesURL"
#define SERVICES_URL @"dealerServiceURL"
#define PARTS_URL @"dealerPartsURL"
#define COLLISION_CENTER_URL @"dealerCollisionCenterURL"
#define FINANCE_URL @"dealerFinanceSpecialsURL"

//DEPARTMENTS DAYS

#define MAIN_DAYS @""
#define NEW_SALES_DAYS @"dealerNewSalesDays"
#define PREOWNED_SALES_DAYS @"dealerPreOwnedSalesDays"
#define SERVICES_DAYS @"dealerServiceDays"
#define PARTS_DAYS @"dealerPartsDays"
#define COLLISION_CENTER_DAYS @"dealerCollisionCenterDays"
#define FINANCE_DAYS @"dealerFinanceDays"

#endif
