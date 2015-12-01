//
//  LeftViewController.m
//  KeenanHonda
//
//  Created by Vikram on 4/16/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "LeftViewController.h"
#import "WebViewController.h"
#import "TableController.h"
#import "AppDelegate.h"
#import "MMDrawerBarButtonItem.h"
#import "MMDrawerController.h"
#import "WebData.h"
#import "UIViewController+MMDrawerController.h"
#import "LeftItemsController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Costants.h"

#define hHeight 30
#define DHeader @"Contact Us"

@interface LeftViewController ()
{
    NSDictionary *dataDict;
    NSString *strHeader;
    WebData *webResponse;
    NSArray *fSectionImage;
    NSArray *sSectionImage;
    NSArray *tSectionImage;
    
    NSMutableArray *deparmentsArray;
    NSMutableArray *timeArray;
    NSMutableArray *fourthSecArray;
    NSMutableArray *fifthSecArray;
    NSArray *iconImagesArray;
    NSArray *dIconImages;
    NSDictionary *dealerinfo;
    BOOL isMain;
    NSString *phoneNumber;
    NSString *webUrl;
    NSString *webTitle;
    CGFloat headerHeight;
    NSString *departmentTime;
    NSString *departmentMail;
}
@end

@implementation LeftViewController
- (NSArray *) testModel{
    return @[@"Home",@"Page 1"];
}



- (void)viewDidLoad {
    [super viewDidLoad];
   self.automaticallyAdjustsScrollViewInsets=NO;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self viewSetUp];
  

}
-(void)viewSetUp{
    
    webResponse=[[WebData alloc]init];
    dataDict=[webResponse getAppData];
   
    
    headerBg.image=[webResponse showHeaderImage];
    
    dealerinfo=[dataDict objectForKey:@"dealerInfo"];
    strHeader=[NSString stringWithFormat:@"Keenan Honda\n%@\n%@, %@ %@",[dealerinfo objectForKey:@"dealerStreet"],[dealerinfo objectForKey:@"dealerCity"],[dealerinfo objectForKey:@"dealerState"],[dealerinfo objectForKey:@"dealerZip"]];
    NSLog(@"address %@",strHeader);
    //TableContent
    NSArray *fSectionArry=[[NSArray alloc]initWithObjects:@"Dashboard",nil];
   fSectionImage=@[@"toolkit.png"];
    NSArray *sSectionArry=[[NSArray alloc]initWithObjects:@"Dealer News",@"Manufacturer News",@"Social Media",@"Financial Links",@"Honda Owner's Link", nil];
   sSectionImage=@[@"news.png",@"news.png",@"news.png",@"news.png",@"news.png"];
    NSArray *tSectionArry=[[NSArray alloc]initWithObjects:@"About Us", nil];
    tSectionImage=@[@"about.png",@"setting.png"];
    
    //Add New Items to Menu
    
    timeArray = [[NSMutableArray alloc]initWithObjects:DHeader,[dealerinfo objectForKey:NEW_SALES_HOUR],[dealerinfo objectForKey:PREOWNED_SALES_HOUR],[dealerinfo objectForKey:SERVICES_HOUR],[dealerinfo objectForKey:PARTS_HOUR],[dealerinfo objectForKey:COLLISION_CENTER_HOUR],[dealerinfo objectForKey:FINANCE_HOUR], nil];
    
    deparmentsArray = [[NSMutableArray alloc]initWithObjects:@"Call Sales Department",@"Visit Our Website",@"Send Us Feedback",@"Department Hours", nil];
    
   fourthSecArray = [[NSMutableArray alloc]initWithObjects:@"Call Our Main Number",@"Visit Our Website",@"Get Directions",@"Roadside Assistance",@"Send Us Feedback", nil];
    
    fifthSecArray = [[NSMutableArray alloc]initWithObjects:@"Main",NEW_SALES,PRE_OWNED,@"Service",@"Parts",@"Collision Center",@"Finance", nil];

    
    iconImagesArray = @[@"phone.png",@"website.png",@"get_directions.png",@"roadside.png",@"envelope.png"];
    dIconImages = @[@"phone.png",@"website.png",@"envelope.png",@"clock.png"];
    
    NSDictionary *tblContent=[[NSDictionary alloc]initWithObjectsAndKeys:fSectionArry,strHeader,sSectionArry,@"OWNER'S RESOURCES",tSectionArry,@"EXTRAS", fourthSecArray, DHeader, fifthSecArray, @"Departments", nil];
    
    tableContents=[tblContent mutableCopy];
   

    sectionArry = [[NSMutableArray alloc] initWithObjects:strHeader, DHeader, @"Departments",@"OWNER'S RESOURCES", @"EXTRAS", nil];
    [self setInitialValues];
}

-(void)setInitialValues
{
    phoneNumber = [dealerinfo objectForKey:MAIN_PHONE];
    webUrl = [dealerinfo objectForKey:MAIN_URL];
    webTitle = OUR_WEBSITE;
    headerHeight = hHeight;
    isMain = YES;
    [leftMenuTbl reloadData];
}

#pragma mark - Table View Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [sectionArry count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [sectionArry objectAtIndex:section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[tableContents objectForKey:[sectionArry objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSArray *imageArray;
    if (indexPath.section==0) {
        imageArray=fSectionImage;
        }
    if (indexPath.section==3) {
        imageArray=sSectionImage;
    }
    if (indexPath.section==4) {
        imageArray=tSectionImage;
    }
    if (indexPath.section==1) {
        if (isMain)
           imageArray=iconImagesArray;
        else
            imageArray=dIconImages;
    }
    

    UIImageView *customImageView = [[UIImageView alloc] init];
    customImageView.translatesAutoresizingMaskIntoConstraints = NO;
    customImageView.tag = 10;
    [cell.contentView addSubview:customImageView];
    
    UILabel  *customLabel = [[UILabel alloc] init];
    customLabel.translatesAutoresizingMaskIntoConstraints = NO;
    customLabel.tag = 20;
    [cell.contentView addSubview:customLabel];
    
    NSDictionary *viewsDictionary = @{@"redView":customImageView};

    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[redView(25)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    
    NSArray *constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[redView(25)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    [customImageView addConstraints:constraint_H];
    [customImageView addConstraints:constraint_V];
    NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[redView]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    
    NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[redView]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
   
    [cell.contentView addConstraints:constraint_POS_H];
    [cell.contentView addConstraints:constraint_POS_V];
    
    NSDictionary *lblviewsDictionary = @{@"lblView":customLabel};
    
    NSArray *lblconstraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lblView(30)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:lblviewsDictionary];
    
    NSArray *lblconstraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[lblView(200)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:lblviewsDictionary];
    [customLabel addConstraints:lblconstraint_H];
    [customLabel addConstraints:lblconstraint_V];
    NSArray *lblconstraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lblView]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:lblviewsDictionary];
    
    NSArray *lblconstraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[lblView]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:lblviewsDictionary];
    
    [cell.contentView addConstraints:lblconstraint_POS_H];
    [cell.contentView addConstraints:lblconstraint_POS_V];

    customImageView.image=[UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
  
    customLabel.text = [[tableContents objectForKey:[sectionArry objectAtIndex:[indexPath section]]] objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark TableView Delegate
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    cell.backgroundColor=[UIColor blackColor];
//    cell.alpha=0.3;
//}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return 70;
    }
    if (section == 1) {
        return headerHeight;
    }
    return 30.0;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {

    return 0.0;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 280, 70)];
    label.textColor=[UIColor darkGrayColor];
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:(16.0)];
    label.lineBreakMode=NSLineBreakByWordWrapping;
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.text=[NSString stringWithFormat:@"%@",[sectionArry objectAtIndex:section]];
  
    return label;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableString *strUrl;
   
    if (indexPath.section == 0 || indexPath.section== 3 || indexPath.section== 4 ) {
    
    NSInteger index = indexPath.row;
    NSString *strUrls;
    NSString *title;
    UIViewController *vcmain = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
    UINavigationController *aboutvc = [self.storyboard instantiateViewControllerWithIdentifier:@"about"];
    UINavigationController *settingvc = [self.storyboard instantiateViewControllerWithIdentifier:@"setting"];
    UINavigationController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"leftmenuitems"];
    NSArray *controllers=[vc  viewControllers];
         UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
    if (indexPath.section==0) {
        switch (index) {
            case 0:{
                [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
                    self.mm_drawerController.centerViewController = vcmain;
                    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
                }];
                break;
            }
            default:
                break;
        }
     }
     else if (indexPath.section==3) {
        switch (index) {
            case 0:{
                strUrls=[[dataDict objectForKey:@"dealerRSS"] objectForKey:@"dealerNewsRSS"];
                title=@"Dealer News";
                break;
            }
            case 1:{
               strUrls=[[dataDict objectForKey:@"dealerRSS"] objectForKey:@"dealerManufacturerNewsRSS"];
                title=@"Manufacturer News";
                break;
            }
            case 2:{
             strUrls=@"Glove";
            title=@"Social Media";
            
                break;
            }
            case 3:{
                TableController *tableView=[self.storyboard instantiateViewControllerWithIdentifier:@"tableController"];
                [tableView setFinance:YES];
                [self presentViewController:tableView animated:YES completion:nil];
                return;
            }
            case 4:{
                  strUrl=[OWNER_LINK mutableCopy];
                  title=@"Owner’s Link";
                 [self webmethod:@"Owner’s Link" weburl:strUrl];
                return;
            }
            default:
                break;
        }
        
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
         
            [[controllers objectAtIndex:0] setDataUrls:strUrls];
            [[controllers objectAtIndex:0] setNewsTitle:title];
        
           self.mm_drawerController.centerViewController = vc;
            
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
            
        }];
        return;
     }
     else if(indexPath.section==4){
     
         switch (index) {
             case 0:
             {
                 [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
                     
                     self.mm_drawerController.centerViewController = aboutvc;
                     
                     [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
                     
                 }];
                 break;
             }
             case 1:
             {
                 [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
                     
                   
                     self.mm_drawerController.centerViewController = settingvc;
                     
                     [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
                     
                 }];
                 break;
             }

             default:
                 break;
         }
     }
    //Default
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
             self.mm_drawerController.centerViewController = vc;
             [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
             
         }];
        
    }else{
    
        NSInteger row = indexPath.row;
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        switch (indexPath.section) {
            case 1:
            {
                WebControllerViewController *webController=[storyBoard instantiateViewControllerWithIdentifier:@"webContent"];
                if (row==0) {
                    NSString *callStr=[NSString stringWithFormat:@"Would You Like To Call %@",phoneNumber];
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Call" message:callStr delegate:self cancelButtonTitle:@"No,Thanks" otherButtonTitles:@"OK", nil];
                    [alert show];
                }
                else if (row==1)
                {
                    [self webmethod:webTitle weburl:webUrl];
                }
                else if (row==2){
                    if (isMain) {
                        UIAlertView *mapAlert=[[UIAlertView alloc]initWithTitle:@"Get Directions" message:@"This will open your Map application, are you sure want to exit?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                        [mapAlert setTag:101];
                        [mapAlert show];
                    }else{
                        UIAlertView *mapAlert=[[UIAlertView alloc]initWithTitle:@"Send Feedback to:" message:departmentMail delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                        [mapAlert setTag:102];
                        [mapAlert show];
                    }
                }
                else if (row==3){
                    if (isMain) {
                        TableController *tableView=[storyBoard instantiateViewControllerWithIdentifier:@"tableController"];
                        [self presentViewController:tableView animated:YES completion:nil];
                    }
                    else{
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Department Hours" message:departmentTime delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    return;
                }else if (row==4){
                    [webController setWebTitle:@"Feedback"];
                    [webController setIsPresentView:YES];
                    [webController setWebUrl:[[dataDict objectForKey:@"dealerInfo"] objectForKey:@"dealerTestimonialURL"]];
                    [self presentViewController:webController animated:YES completion:nil];
                }
                break;
            }
            case 2:{
                if (row == 1) {
                    [self changeArrayValuesAtIndex:indexPath fValue:@"Call Sales Department" svalue:@"Get a Quote"];
                    phoneNumber = [dealerinfo objectForKey:NEW_SALES_PHONE];
                    webUrl = [dealerinfo objectForKey:NEW_SALES_URL];
                    webTitle = [fifthSecArray objectAtIndex:indexPath.row];
                    departmentMail =[dealerinfo objectForKey:NEW_SALES_EMAIL];
                }
                else if (row == 2){
                    [self changeArrayValuesAtIndex:indexPath fValue:@"Call Sales Department" svalue:@"Get a Quote"];
                    phoneNumber = [dealerinfo objectForKey:PREOWNED_SALES_PHONE];
                    webUrl = [dealerinfo objectForKey:PREOWNED_SALES_URL];
                    webTitle = [fifthSecArray objectAtIndex:indexPath.row];
                    departmentMail =[dealerinfo objectForKey:PREOWNED_SALES_EMAIL];
                }
                else if (row == 3){
                    [self changeArrayValuesAtIndex:indexPath fValue:@"Call Service Department" svalue:@"Sechduel Appointment"];
                    phoneNumber = [dealerinfo objectForKey:SERVICES_PHONE];
                    webUrl = [dealerinfo objectForKey:SERVICES_URL];
                    webTitle = [fifthSecArray objectAtIndex:indexPath.row];
                    departmentMail =[dealerinfo objectForKey:SERVICES_EMAIL];
                }
                else if (row == 4){
                    [self changeArrayValuesAtIndex:indexPath fValue:@"Call Parts Department" svalue:@"Order a Part"];
                    phoneNumber = [dealerinfo objectForKey:PARTS_PHONE];
                    webUrl = [dealerinfo objectForKey:PARTS_URL];
                    webTitle = [fifthSecArray objectAtIndex:indexPath.row];
                    departmentMail =[dealerinfo objectForKey:PARTS_EMAIL];
                }
                else if (row == 5){
                    [self changeArrayValuesAtIndex:indexPath fValue:@"Call Collision Center" svalue:@"Schedule an Estimate"];
                    phoneNumber = [dealerinfo objectForKey:COLLISION_CENTER_PHONE];
                    webUrl = [dealerinfo objectForKey:COLLISION_CENTER_URL];
                    webTitle = [fifthSecArray objectAtIndex:indexPath.row];
                    departmentMail =[dealerinfo objectForKey:COLLISION_CENTER_EMAIL];
                }
                else if (row == 6){
                    [self changeArrayValuesAtIndex:indexPath fValue:@"Call Sales Department" svalue:@"Get a Quote"];
                    phoneNumber = [dealerinfo objectForKey:FINANCE_PHONE];
                    webUrl = [dealerinfo objectForKey:FINANCE_URL];
                    webTitle = [fifthSecArray objectAtIndex:indexPath.row];
                    departmentMail =[dealerinfo objectForKey:FINANCE_EMAIL];
                }
                
                else{
                    [fourthSecArray removeAllObjects];
                    [fourthSecArray addObjectsFromArray:@[@"Call Our Main Number",@"Visit Our Website",@"Get Directions",@"Roadside Assistance",@"Send Us Feedback"]];
                    [sectionArry replaceObjectAtIndex:1 withObject:DHeader];
                    [tableContents removeObjectForKey:[fifthSecArray objectAtIndex:indexPath.row]];
                    [tableContents setObject:fourthSecArray forKey:DHeader];
                    [leftMenuTbl setContentOffset:CGPointZero animated:YES];
                    [self setInitialValues];
                }
                break;
            }
            default:
                break;
        }
        
    }

}
-(void)webmethod:(NSString*)Title weburl:(NSString*)url

{
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebControllerViewController *webController=[storyBoard instantiateViewControllerWithIdentifier:@"webContent"];
    [webController setWebTitle:Title];
    [webController setIsPresentView:YES];
    [webController setWebUrl:url];
    [self presentViewController:webController animated:YES completion:nil];
}
-(void)changeArrayValuesAtIndex:(NSIndexPath *)indexPath fValue:(NSString *)firstValue svalue:(NSString *)secondValue{
    
    isMain = NO;
    [fourthSecArray removeAllObjects];
    [deparmentsArray replaceObjectAtIndex:0 withObject:firstValue];
    [fourthSecArray addObjectsFromArray:[deparmentsArray mutableCopy]];
    
    //For Header
    
    NSString *Header = [self setHeaderTitleAtIndex:indexPath];
    departmentTime = [timeArray objectAtIndex:indexPath.row];
    [sectionArry replaceObjectAtIndex:1 withObject:Header];
    
    if(indexPath.row == 1){
        [tableContents removeObjectForKey:[sectionArry objectAtIndex:1]];
    }else{
        [tableContents removeObjectForKey:[fifthSecArray objectAtIndex:indexPath.section]];
    }
    
    [tableContents setObject:fourthSecArray forKey:Header];
    
    //END
    
    [leftMenuTbl reloadData];
    NSIndexPath *scrollindexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [leftMenuTbl scrollToRowAtIndexPath:scrollindexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}
-(NSString *)setHeaderTitleAtIndex:(NSIndexPath *)indexpath{
    
    NSString *strtime;
    NSString *headerTime = [timeArray objectAtIndex:indexpath.row];
    NSString *mfTymstr = [headerTime componentsSeparatedByString:@","][0];
    NSString *satStr = @"";
    strtime = headerTime;
   
    if ([[headerTime componentsSeparatedByString:@","] count] != 1) {
      
        satStr = [headerTime substringFromIndex:[mfTymstr length]+1];
        NSString *newHeaderTym =[NSString stringWithFormat:@"%@\n%@",mfTymstr,satStr];
        strtime = newHeaderTym;
    }
    
    NSString *headerTitle =  [NSMutableString stringWithFormat:@"%@\n%@",[fifthSecArray objectAtIndex:indexpath.row],strtime];
    
    //Set Headerheight 
    CGSize maximumSize = CGSizeMake(300, 9999);
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize mSize = [headerTitle boundingRectWithSize:maximumSize
                             options:NSStringDrawingUsesLineFragmentOrigin
                          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11],
                                       NSParagraphStyleAttributeName:paragraphStyle}
                             context:nil].size;
   
    headerHeight = mSize.height + 20;
    
    return headerTitle;
}

#pragma AlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *dealerAddress = [NSString stringWithFormat:@"%@ %@ %@ %@",[dealerinfo objectForKey:@"dealerStreet"],[dealerinfo objectForKey:@"dealerCity"],[dealerinfo objectForKey:@"dealerState"],[dealerinfo objectForKey:@"dealerZip"]];
    
    if (alertView.tag==101 && buttonIndex==1) {
        
        NSString *urlString =[NSString stringWithFormat:@"https://maps.apple.com/?daddr=%@&saddr=%@,%@",[dealerAddress stringByReplacingOccurrencesOfString:@" " withString:@"+"],app.latitude,app.longitude];
        
        NSLog(@"urlstr %@",urlString);
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: urlString]]) {
            
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: urlString]];

        }
    }
    else if (alertView.tag==102 && buttonIndex==1){
        [self sendMailTo:departmentMail];
    }
    else{
        if (buttonIndex==1) {
            // NSString *phoneNumber=[[dataDict objectForKey:@"dealerInfo"] objectForKey:@"dealerMainPhone"];
            
            NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phoneNumber]];
            
            if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
                [[UIApplication sharedApplication] openURL:phoneUrl];
            } else
            {
                UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [calert show];
            }
        }
    }
}

//SETUP MailComposerController

-(void)sendMailTo:(NSString *)recipient {
    self.mailer = [[MFMailComposeViewController alloc] init];
    
    if ([MFMailComposeViewController canSendMail]) {
        
        self.mailer.mailComposeDelegate = self;
        [self.mailer setSubject:@"FeedBack"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:recipient, nil];
        [self.mailer setToRecipients:toRecipients];
        
        /* You might want to uncomment the following, if you
         * have images to attach */
        // UIImage *myImage = [UIImage imageNamed:@"myfabolousimage.png"];
        // NSData *imageData = UIImagePNGRepresentation(myImage);
        // [self.mailer addAttachmentData:imageData
        //              mimeType:@"image/png" fileName:@"myfabolousimage.png"];
        
        NSString *emailBody = @"";
        [self.mailer setMessageBody:emailBody isHTML:NO];
        
        [self presentViewController:self.mailer animated:YES completion:nil];
    }
    
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
}


@end
