//
//  MakePaymentController.m
//  KeenanHonda
//
//  Created by Vikram on 4/28/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "MakePaymentController.h"
#import "CustomPayCell.h"
#import "WebData.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "WebService.h"
#import "globals.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MakePaymentController ()
{
    WebData *webResponse;
     NSArray * invoiceListArr;
    NSString * strCardNumber;
}
@end

@implementation MakePaymentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewSetUp];
    [self displayQuickCardSetupAlert];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewSetUp{
    self.title=@"Make a Payment";
    webResponse=[[WebData alloc]init];
    NSDictionary *dataDict=[webResponse getAppData];
   
    [self.bgImage setImage:[webResponse showBgImage]];
    
    self.paymentTable.rowHeight = UITableViewAutomaticDimension;
    self.paymentTable.estimatedRowHeight = 44.0;
    self.paymentTable.layer.borderColor=[UIColor blackColor].CGColor;
    self.paymentTable.layer.borderWidth=2;
    self.paymentTable.layer.cornerRadius=10;
}

- (void)displayQuickCardSetupAlert
{
    UIAlertView *quickSetupAlert = [[UIAlertView alloc] initWithTitle:@"Rewards Setup" message:@"You must setup your rewards card to use this feature.\nEnter your card details in the fields below to begin using your points!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Finish", nil];
    
    [quickSetupAlert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    
    UITextField *firstField = [quickSetupAlert textFieldAtIndex:0];
    [firstField setTextAlignment:NSTextAlignmentCenter];
    [firstField setSecureTextEntry:NO];
    [firstField setKeyboardType:UIKeyboardTypeNumberPad];
    [firstField setPlaceholder:@"Enter Card Number"];
    
    UITextField *secondField = [quickSetupAlert textFieldAtIndex:1];
    [secondField setTextAlignment:NSTextAlignmentCenter];
    [secondField setSecureTextEntry:NO];
    [secondField setKeyboardType:UIKeyboardTypeNumberPad];
    [secondField setPlaceholder:@"Enter Your Zip Code"];
    
  //  [quickSetupAlert setTag:QUICKSETUPALERT_TAG];
    
    [quickSetupAlert show];
}
#pragma mark - Alert View Delegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
        if (buttonIndex != alertView.cancelButtonIndex) {
           UITextField *cardNumberField = [alertView textFieldAtIndex:0];
           UITextField *zipCodeField = [alertView textFieldAtIndex:1];
             [self setupRewardsCardWithNumber:cardNumberField.text andZip:zipCodeField.text];
        }
        else {
            // TODO: Pop the user back to the previous view.
            [self.navigationController popViewControllerAnimated:YES];
        }
    
}
#pragma mark- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSLog(@"calllllll");
    static NSString *headreID=@"headerCell";
    UITableViewCell *headerview=[tableView dequeueReusableCellWithIdentifier:headreID];
    [headerview setBackgroundColor:[UIColor lightGrayColor]];
    if (headerview == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    
       return headerview;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"payCell";
    
    CustomPayCell *cell = (CustomPayCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    NSDictionary * invoiceList = [invoiceListArr objectAtIndex:indexPath.row];
    
    //set values
    [cell.lblDate setText:[invoiceList valueForKey:@"transdate"]];
    [cell.lblAmount setText:[NSString stringWithFormat:@"%.02f", [[invoiceList valueForKey:@"invoiceamount"] floatValue]]];
    [cell.lblInvoice setText:[invoiceList valueForKey:@"invoicenumber"]];
//  cell.lblDate.text=@"12-12-12";
//    cell.lblInvoice.text=@"123123";
//    cell.lblAmount.text=@"$100";
    return cell;
}

#pragma mark TableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 50;
    }
    return 0;
}

#pragma mark - Rewards Card Setup Methods
- (void)setupRewardsCardWithNumber:(NSString *)cardNumber andZip:(NSString *)zipCode
{
    NSString *results = [webResponse UpdateFromWebWithAccountNumber:cardNumber andZip:zipCode];
    if ([globals StringInString:results stringtofind:@"~SUCCESS~"])
    {
        // TODO: Begin fetching of invoice list data from the api
        //Call WebService to get invoice list
        strCardNumber = cardNumber;
        NSString * requestURL = [NSString stringWithFormat:@"GetInvoiceByCardNo/%@",cardNumber];
        [self perform_getInvoiceList:requestURL];
    }
    else
    {
        // TODO: Inform the user that No Member was found, and that they should check that they entered the correct data and try again.
        [[[UIAlertView alloc] initWithTitle:@"LoeberMotors" message:@"No Member was found, Please enter the correct data and try again!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}
#pragma mark-
#pragma mark- WebService Method

-(void)perform_getInvoiceList:(NSString *)URLToPost{
    
    Reachability *internetReachable = [Reachability reachabilityForInternetConnection];
    if ([internetReachable isReachable])
    {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [WebService getDataFromJson:nil WebMethod:URLToPost requestType:@"GET" ContentType:@"json" getData:^(NSDictionary * resultDic, NSError * error, BOOL success) {
            NSLog(@"Error %@",error.localizedDescription);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (success) {
                //Invoice list with other details & assign value in invoiceListArr
                invoiceListArr = [resultDic valueForKey:@"response"];
            
                if (invoiceListArr.count > 0) {
                    [self.paymentTable reloadData];
                }else{
                    [[[UIAlertView alloc] initWithTitle:@"Beshoff MotorCars" message:@"No Data Found!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
                }
            }else{
                [[[UIAlertView alloc] initWithTitle:@"Beshoff MotorCars" message:@"Unable to process, Please try again!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            }
            
        }];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Beshoff MotorCars" message:@"Please check your internet connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}



@end
