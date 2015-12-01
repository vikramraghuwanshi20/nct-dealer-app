//
//  ODOClubViewController.m
//  KeenanHonda
//
//  Created by Vikram on 4/28/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "ODOClubViewController.h"

#import "Costants.h"
#import "WebData.h"
#import "globals.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ODOClubViewController ()
{
    WebData *webResponse;
    NSDictionary *dataDict;
    //Specials
    NSString *bdesc1;
    NSString *bdesc2;
    NSString *bdesc3;
    NSString *bdesc4;
    
    NSString *qty1;
    NSString *qty2;
    NSString *qty3;
    NSString *qty4;
}
@end

@implementation ODOClubViewController
@synthesize o;
- (void)viewDidLoad {
    [super viewDidLoad];
    webResponse=[[WebData alloc]init];
    [self viewSetUp];
    [_txtAccountNumber becomeFirstResponder];
    [self initialView];
    
    
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
    
    self.title=@"Rewards";
    dataDict=[webResponse getAppData];
    [self.viewBg setImage:[webResponse showRewardsCardImage]];
     [self.bgImage setImage:[webResponse showBgImage]];
}
-(void)initialView{
    
    _lblCardNumber.hidden=YES;
    _lblClientName.hidden=YES;
    _txtViewSpecials.alpha=0;
    _imgBarCode.hidden=YES;
    
}


- (IBAction)tapSubmit:(id)sender {

//        [_txtAccountNumber resignFirstResponder];
//        [_txtZipCode resignFirstResponder];
    
    
        if ([_txtAccountNumber.text length] == 0)
        {
           // [oRewards MessageBox:@"Rewards Error" message:@"Please enter a valid customer number. Try again."];
            return;
        }
        
        if ([_txtZipCode.text length] < 5)
        {
         //   [oRewards MessageBox:@"Rewards Error" message:@"Please enter a valid zipcode. Try again."];
            return;
        }
        
        [self UpdateFromWeb];
 
    
    }
    
- (void)UpdateFromWeb
    {
        NSString *strAcctNumber = _txtAccountNumber.text;
        NSString *zipcode = _txtZipCode.text;
        
        NSString *weburl2dbarcode = [NSString stringWithFormat:@"%@/Mobile/Get2DBarCode.aspx?number=%@",NCWEBSITE,strAcctNumber];
      
     
        NSString *results = [webResponse UpdateFromWebWithAccountNumber:strAcctNumber andZip:zipcode];
        NSLog(@"result %@",results);
        if ([globals StringInString:results stringtofind:@"~SUCCESS~"])
        {
            //        oRewards *o = [[oRewards alloc] init];
            
            //Fro Special
            [self.view endEditing:YES];
            bdesc1 = [globals GetStringBetween:results string1:@"<bdesc1>" string2:@"</bdesc1>"];
            bdesc2 = [globals GetStringBetween:results string1:@"<bdesc2>" string2:@"</bdesc2>"];
            bdesc3 = [globals GetStringBetween:results string1:@"<bdesc3>" string2:@"</bdesc3>"];
            bdesc4 = [globals GetStringBetween:results string1:@"<bdesc4>" string2:@"</bdesc4>"];
            
            qty1 = [globals GetStringBetween:results string1:@"<qty1>" string2:@"</qty1>"];
            qty2 = [globals GetStringBetween:results string1:@"<qty2>" string2:@"</qty2>"];
            qty3 = [globals GetStringBetween:results string1:@"<qty3>" string2:@"</qty3>"];
            qty4 = [globals GetStringBetween:results string1:@"<qty4>" string2:@"</qty4>"];
            
            //End

            
            UIImage *newBarImage = [globals GetImageFromWeb:weburl2dbarcode];
            _imgBarCode.image = newBarImage;
            [globals SavePhotoToDisk:newBarImage filename:IMG_2DFILENAME];
            
             NSString *fullname = [NSString stringWithFormat:@"%@ %@",[globals GetStringBetween:results string1:@"<fname>" string2:@"</fname>"],[globals GetStringBetween:results string1:@"<lname>" string2:@"</lname>"] ];
            _lblClientName.hidden=NO;
            _lblClientName.text = fullname;
             NSLog(@"fullName %@",_lblClientName.text);
            _lblClientName.textColor=[UIColor lightGrayColor];
            _lblClientName.textAlignment=NSTextAlignmentLeft;
            _txtAccountNumber.text = strAcctNumber;
            _txtZipCode.text = zipcode;
            _txtAccountNumber.borderStyle = UITextBorderStyleNone;
            _txtAccountNumber.textColor = [UIColor whiteColor];
            _txtZipCode.textColor = [UIColor whiteColor];
            
            _txtAccountNumber.textAlignment = NSTextAlignmentLeft;
            _txtZipCode.hidden = YES;
            _imgBarCode.hidden = NO;
            _btnSubmit.hidden = YES;
            
            _lblPointBalance.text = [NSString stringWithFormat:@"Points Balance is: %@",[globals GetStringBetween:results string1:@"<pointsbalance>" string2:@"</pointsbalance>"]];
            
            [self LoadSpecials];
            
        }
        else
        {
           
           
            _lblClientName.text = @"CUSTOMER NOT FOUND!";
            [_txtZipCode resignFirstResponder];
           
           [self performSelector:@selector(callAlertview) withObject:nil afterDelay:1];
            
        }
        
    }

-(void)callAlertview{
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Sorry, Invalid customer number. Please try again."
                                                      message:@"Rewards Error"
                                                     delegate:self
                                            cancelButtonTitle:@"Okay"
                                            otherButtonTitles:nil];
    
    [message show];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    _txtZipCode.text = @"";
    _txtAccountNumber.text = @"";
    [_txtAccountNumber becomeFirstResponder];
}

- (IBAction)tapReset:(id)sender {
    [self performSelector:@selector(UpdateFromWeb) withObject:nil afterDelay:0.5];
}

- (IBAction)tapResetCard:(id)sender {
    
        [_txtAccountNumber becomeFirstResponder];
         o.acctnumber = @"";
        o.zipcode = @"";
        [o SaveInfo];
        _txtAccountNumber.text=@"";
        _txtZipCode.text=@"";
        _txtViewSpecials.text=@"";
        _lblPointBalance.text=@"0";
        _imgBarCode.hidden = YES;
        _lblPointBalance.text = @"Points Balance is: 0";
        _txtViewSpecials.alpha = 0;
        _lblClientName.text=@"";
        _txtAccountNumber.textColor = [UIColor blackColor];
        _txtZipCode.textColor = [UIColor blackColor];
        _txtAccountNumber.backgroundColor=[UIColor whiteColor];
        _txtZipCode.backgroundColor=[UIColor whiteColor];
        _txtAccountNumber.borderStyle = UITextBorderStyleRoundedRect;
        _txtZipCode.borderStyle=UITextBorderStyleRoundedRect;
        _txtZipCode.hidden = NO;
        _btnSubmit.hidden = NO;
        
    }



- (IBAction)tapSpecial:(id)sender
{
    if (_rewardView.tag == 0)
    {
        [_btnSpecial setTitle:@"Hide Specials" forState:UIControlStateNormal];
        [self performSelector:@selector(FadeInSpecials:) withObject:@"1" afterDelay:0.5];
        
    }
    else
    {
        [_btnSpecial setTitle:@"Specials" forState:UIControlStateNormal];
        [self performSelector:@selector(FadeInSpecials:) withObject:@"0" afterDelay:0.0];
    }
    [oRewards FlipBackground:_rewardView newTag:900];
    
}

-(void)FadeInSpecials:(NSString *)sender
{
    [UIView animateWithDuration:0.3 animations:
     ^{
         _txtViewSpecials.alpha = [sender isEqualToString:@"1"] ? 1 : 0;
     }
                     completion:^ (BOOL finished)
     {
         
     }];
    
    
}

-(void)LoadSpecials
{
    o=[[oRewards alloc]init];
    NSLog(@"qyt %@  %@",qty1,bdesc1);
    NSInteger nQty = 0;
    NSString *allspecials = @"Specials Remaining:\n\n";
    if (![qty1 isEqualToString:@"0"])
    {
        allspecials = [allspecials stringByAppendingFormat:@"(%@) %@\n",qty1,bdesc1];
        nQty++;
    }
    if (![qty2 isEqualToString:@"0"])
    {
        allspecials = [allspecials stringByAppendingFormat:@"(%@) %@\n",qty2,bdesc2];
        nQty++;
    }
    if (![qty3 isEqualToString:@"0"])
    {
        allspecials = [allspecials stringByAppendingFormat:@"(%@) %@\n",qty3,bdesc3];
        nQty++;
    }
    if (![qty4 isEqualToString:@"0"])
    {
        allspecials = [allspecials stringByAppendingFormat:@"(%@) %@\n",qty4,bdesc4];
        nQty++;
    }
    
    if (nQty == 0)
    {
        allspecials = [allspecials stringByAppendingString:@"NONE"];
    }
    
    _txtViewSpecials.text = allspecials;
    
}

@end
