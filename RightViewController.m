//
//  RightViewController.m
//  KeenanHonda
//
//  Created by Vikram on 4/16/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "RightViewController.h"
#import "WebViewController.h"
#import "TableController.h"
#import "FeedBackViewController.h"
#import "Costants.h"

#import  <SDWebImage/UIImageView+WebCache.h>
#import "UIViewController+MMDrawerController.h"

#define hHeight 50


@interface RightViewController ()
{
    
    NSDictionary *dataDict;
    NSArray *iconImagesArray;
    NSMutableArray *fsectionArry;
    NSMutableArray *deparmentsArray;
    NSMutableArray *sSectionArry;
    NSMutableArray *timeArray;
    NSMutableArray *dayArray;
    NSArray *dIconImages;
    NSString * stradd;
    NSString * dealerAddress;
    
    NSDictionary *dealerinfo;
    NSString *phoneNumber;
    NSString *webUrl;
    NSString *webTitle;
    NSString *departmentTime;
    NSString *departmentMail;
    
    BOOL isMain;
    
    CGFloat headerHeight;
}
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    }
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    webResponse=[[WebData alloc]init];
    webResponse.delegate=self;
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [self viewSetUp];
 
}
-(void)viewSetUp{
    
    dataDict=[webResponse getAppData];
    dealerinfo=[dataDict objectForKey:@"dealerInfo"];
//   stradd=[NSString stringWithFormat:@"CONTACT INFO\n%@\n%@ %@ %@",[dealerinfo objectForKey:@"dealerStreet"],[dealerinfo objectForKey:@"dealerCity"],[dealerinfo objectForKey:@"dealerState"],[dealerinfo objectForKey:@"dealerZip"]];
    stradd=@"CONTACT INFO";
    

  dealerAddress=[NSString stringWithFormat:@"%@ %@ %@ %@",[dealerinfo objectForKey:@"dealerStreet"],[dealerinfo objectForKey:@"dealerCity"],[dealerinfo objectForKey:@"dealerState"],[dealerinfo objectForKey:@"dealerZip"]];
    [self getLatLongFromAdd:dealerAddress];
    
    //stradd = [NSString stringWithFormat:@"CONTACT INFO\n%@ %@ %@ %@",[dealerinfo objectForKey:@"dealerStreet"],[dealerinfo objectForKey:@"dealerCity"],[dealerinfo objectForKey:@"dealerState"],[dealerinfo objectForKey:@"dealerZip"]];



    [self getLatLongFromAdd:stradd];
    NSLog(@"address %@",stradd);
    headerImg.image=[webResponse showHeaderImage];
   
    //TableContent
    timeArray = [[NSMutableArray alloc]initWithObjects:stradd,[dealerinfo objectForKey:NEW_SALES_HOUR],[dealerinfo objectForKey:PREOWNED_SALES_HOUR],[dealerinfo objectForKey:SERVICES_HOUR],[dealerinfo objectForKey:PARTS_HOUR],[dealerinfo objectForKey:COLLISION_CENTER_HOUR],[dealerinfo objectForKey:FINANCE_HOUR], nil];
    
     dayArray = [[NSMutableArray alloc]initWithObjects:@"Main",[dealerinfo objectForKey:NEW_SALES_DAYS],[dealerinfo objectForKey:PREOWNED_SALES_DAYS],[dealerinfo objectForKey:SERVICES_DAYS],[dealerinfo objectForKey:PARTS_DAYS],[dealerinfo objectForKey:COLLISION_CENTER_DAYS],[dealerinfo objectForKey:FINANCE_DAYS], nil];
    
    deparmentsArray = [[NSMutableArray alloc]initWithObjects:@"Call Sales Department",@"Visit Our Website",@"Send Us Feedback",@"Department Hours", nil];
    
       fsectionArry=[[NSMutableArray alloc]initWithObjects:@"Call Our Main Number",@"Visit Our Website",@"Get Directions",@"Roadside Assistance",@"Send Us Feedback", nil];
   
    iconImagesArray = @[@"phone.png",@"website.png",@"get_directions.png",@"roadside.png",@"envelope.png"];
    dIconImages = @[@"phone.png",@"website.png",@"envelope.png",@"clock.png"];
    
    sSectionArry=[[NSMutableArray alloc]initWithObjects:@"Main",NEW_SALES,PRE_OWNED,@"Service",@"Parts",@"Collision Center",@"Finance", nil];
    
    //NSDictionary *tblContent=
    tableContents=[[NSMutableDictionary alloc]initWithObjectsAndKeys:fsectionArry,stradd,sSectionArry,@"DEPARTMENTS", nil];
    sectionArry=[[NSMutableArray alloc]initWithObjects:stradd,@"DEPARTMENTS",nil];
    
    //SET UP STARTING VALUES
    [self setInitialValues];
}
-(void)setInitialValues{
    
    phoneNumber = [dealerinfo objectForKey:MAIN_PHONE];
    webUrl = [dealerinfo objectForKey:MAIN_URL];
    webTitle = OUR_WEBSITE;
    headerHeight = hHeight;
    isMain = YES;
    
    [rightMenuTbl reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Table View Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [sectionArry count];
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSString *title = [sectionArry objectAtIndex:0];
//    NSLog(@"Title %@",title);
//    return [sectionArry objectAtIndex:0];
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[tableContents objectForKey:[sectionArry objectAtIndex:section]] count];
    //return  [iconImagesArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"rightCell%ld";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
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
    
    NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-240-[redView]"
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
    
    NSArray *lblconstraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[lblView(220)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:lblviewsDictionary];
    [customLabel addConstraints:lblconstraint_H];
    [customLabel addConstraints:lblconstraint_V];
    NSArray *lblconstraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lblView]"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:lblviewsDictionary];
    
    NSArray *lblconstraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[lblView]-50-|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:lblviewsDictionary];
    
    [cell.contentView addConstraints:lblconstraint_POS_H];
    [cell.contentView addConstraints:lblconstraint_POS_V];
    
    if (indexPath.section == 0) {
        if (isMain)
         customImageView.image=[UIImage imageNamed:[iconImagesArray objectAtIndex:indexPath.row]];
        else
        customImageView.image=[UIImage imageNamed:[dIconImages objectAtIndex:indexPath.row]];
    }
   
    customLabel.text = [[tableContents objectForKey:[sectionArry objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    //customLabel.text = [fsectionArry objectAtIndex:indexPath.row];
    customLabel.textAlignment=NSTextAlignmentRight;
    
    return cell;
}


#pragma mark TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    switch (indexPath.section) {
        case 0:
        {
    WebControllerViewController *webController=[storyBoard instantiateViewControllerWithIdentifier:@"webContent"];
      if (row==0) {
        NSString *callStr=[NSString stringWithFormat:@"Would You Like To Call %@",phoneNumber];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Call" message:callStr delegate:self cancelButtonTitle:@"No,Thanks" otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else if (row==1){
    
        [webController setWebTitle:webTitle];
        [webController setIsPresentView:YES];
         [webController setWebUrl:webUrl];
        [self presentViewController:webController animated:YES completion:nil];
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
        case 1:{
            if (row == 1) {
                [self changeArrayValuesAtIndex:indexPath fValue:@"Call Sales Department" svalue:@"Get a Quote"];
                phoneNumber = [dealerinfo objectForKey:NEW_SALES_PHONE];
                webUrl = [dealerinfo objectForKey:NEW_SALES_URL];
                webTitle = [sSectionArry objectAtIndex:indexPath.row];
                departmentMail =[dealerinfo objectForKey:NEW_SALES_EMAIL];
            }
            else if (row == 2){
                [self changeArrayValuesAtIndex:indexPath fValue:@"Call Sales Department" svalue:@"Get a Quote"];
                phoneNumber = [dealerinfo objectForKey:PREOWNED_SALES_PHONE];
                 webUrl = [dealerinfo objectForKey:PREOWNED_SALES_URL];
                webTitle = [sSectionArry objectAtIndex:indexPath.row];
                  departmentMail =[dealerinfo objectForKey:PREOWNED_SALES_EMAIL];
            }
            else if (row == 3){
                [self changeArrayValuesAtIndex:indexPath fValue:@"Call Service Department" svalue:@"Sechduel Appointment"];
                phoneNumber = [dealerinfo objectForKey:SERVICES_PHONE];
                 webUrl = [dealerinfo objectForKey:SERVICES_URL];
                webTitle = [sSectionArry objectAtIndex:indexPath.row];
                departmentMail =[dealerinfo objectForKey:SERVICES_EMAIL];
            }
            else if (row == 4){
            [self changeArrayValuesAtIndex:indexPath fValue:@"Call Parts Department" svalue:@"Order a Part"];
                phoneNumber = [dealerinfo objectForKey:PARTS_PHONE];
                 webUrl = [dealerinfo objectForKey:PARTS_URL];
                webTitle = [sSectionArry objectAtIndex:indexPath.row];
                  departmentMail =[dealerinfo objectForKey:PARTS_EMAIL];
            }
            else if (row == 5){
                [self changeArrayValuesAtIndex:indexPath fValue:@"Call Collision Center" svalue:@"Schedule an Estimate"];
                phoneNumber = [dealerinfo objectForKey:COLLISION_CENTER_PHONE];
                 webUrl = [dealerinfo objectForKey:COLLISION_CENTER_URL];
                webTitle = [sSectionArry objectAtIndex:indexPath.row];
                  departmentMail =[dealerinfo objectForKey:COLLISION_CENTER_EMAIL];
            }
            else if (row == 6){
                [self changeArrayValuesAtIndex:indexPath fValue:@"Call Sales Department" svalue:@"Get a Quote"];
                phoneNumber = [dealerinfo objectForKey:FINANCE_PHONE];
                 webUrl = [dealerinfo objectForKey:FINANCE_URL];
                webTitle = [sSectionArry objectAtIndex:indexPath.row];
                  departmentMail =[dealerinfo objectForKey:FINANCE_EMAIL];
            }

            else{
                [fsectionArry removeAllObjects];
                [fsectionArry addObjectsFromArray:@[@"Call Our Main Number",@"Visit Our Website",@"Get Directions",@"Roadside Assistance",@"Send Us Feedback"]];
                [sectionArry replaceObjectAtIndex:0 withObject:stradd];
                [tableContents removeObjectForKey:[sSectionArry objectAtIndex:indexPath.row]];
                [tableContents setObject:fsectionArry forKey:stradd];
                [rightMenuTbl setContentOffset:CGPointZero animated:YES];
                [self setInitialValues];
            }
            break;
        }
        default:
            break;
    }

 
}

-(void)changeArrayValuesAtIndex:(NSIndexPath *)indexPath fValue:(NSString *)firstValue svalue:(NSString *)secondValue{
  
     isMain = NO;
    [fsectionArry removeAllObjects];
    
    [deparmentsArray replaceObjectAtIndex:0 withObject:firstValue];

    [fsectionArry addObjectsFromArray:[deparmentsArray mutableCopy]];
    
    //For Header
    NSString *strHeader = [self setHeaderTitleAtIndex:indexPath];
    departmentTime = [timeArray objectAtIndex:indexPath.row];
    [sectionArry replaceObjectAtIndex:0 withObject:strHeader];
    
    if(indexPath.row == 1){
    [tableContents removeObjectForKey:[sectionArry objectAtIndex:0]];
    }else{
     [tableContents removeObjectForKey:[sSectionArry objectAtIndex:indexPath.section]];
    }
    
    [tableContents setObject:fsectionArry forKey:strHeader];
    //END
    
    [rightMenuTbl reloadData];
    [rightMenuTbl setContentOffset:CGPointZero animated:YES];

}
-(NSString *)setHeaderTitleAtIndex:(NSIndexPath *)indexpath{
    NSString *headerTime = [timeArray objectAtIndex:indexpath.row];
    NSString *mfTymstr = [headerTime componentsSeparatedByString:@","][0];
    NSString *satStr = @"";
         headerHeight = hHeight;
    if ([[headerTime componentsSeparatedByString:@","] count] != 1) {
        headerHeight = hHeight + 20;
        satStr = [headerTime substringFromIndex:[mfTymstr length]+1];
    }
    
    NSString *newHeaderTym =[NSString stringWithFormat:@"%@\n%@",mfTymstr,satStr];
    NSString *headerTitle =  [NSMutableString stringWithFormat:@"%@\n%@",[sSectionArry objectAtIndex:indexpath.row],newHeaderTym];
    
    return headerTitle;
}

- (CGFloat)tableView:(UITableView*)tableView
heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return headerHeight;
    }
    return 30.0;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}

- (UIView*)tableView:(UITableView*)tableView
viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 280, 70)];
    label.textColor=[UIColor darkGrayColor];
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:(16.0)];
    label.lineBreakMode=NSLineBreakByWordWrapping;
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentCenter;
    NSString *title = [sectionArry objectAtIndex:section];
    label.text= title;
   
    return label;
}

-(void)getLatLongFromAdd:(NSString *)address{
    double latitude = 0, longitude = 0;
    NSString *trimmed = [address stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *addUrl=[NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?address=%@&sensor=false",trimmed];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:addUrl] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    self.deslat=[NSString stringWithFormat:@"%f",latitude];
    self.deslong=[NSString stringWithFormat:@"%f",longitude];
    
}

#pragma AlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==101 && buttonIndex==1) {

        NSString *urlString =[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%@&saddr=%@,%@",[dealerAddress stringByReplacingOccurrencesOfString:@" " withString:@"+"],app.latitude,app.longitude];

        NSLog(@"urlstr %@",urlString);
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: urlString]];
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
@end
