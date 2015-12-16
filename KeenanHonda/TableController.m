//
//  TableController.m
//  KeenanHonda
//
//  Created by Vikram on 4/27/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "TableController.h"
#import "WebViewController.h"
//#import "FirstViewController.h"
#import "WebData.h"
//#import "CustomCell.h"
//#import "FirstViewCell.h"
#import "tablecell.h"
#import <MMDrawerController.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface TableController ()
{
    WebData *webResponse;
    NSDictionary *dataDict;
    NSString *callStr;
}
@end

@implementation TableController
@synthesize finance;

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets=NO;
    webResponse=[[WebData alloc]init];

    [self viewSetUp];
    //[[UIScrollView appearance] setTranslatesAutoresizingMaskIntoConstraints:NO];
    // [[UIScrollView appearance] setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f]];
//    [[UITableView appearance] setBackgroundColor:[UIColor clearColor]];
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor clearColor];
//    self.tableView.backgroundView = view;
//    UIImageView *transparent=[UIImageView new];
//    [self.tableView insertSubview:transparent atIndex:0];
    
    
    
    
    
    
    
    
    
    UIImage *barImage=[[UIImage imageNamed:@"navBarFade.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.roadSideNavBar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
    self.roadSideNavBar.shadowImage = [UIImage new];
    self.roadSideNavBar.translucent=YES;
    self.roadSideNavBar.barTintColor=[UIColor clearColor];
    self.view.backgroundColor=[UIColor clearColor];
     //Do any additional setup after loading the view.
}

-(void)viewSetUp
{
    NSDictionary *dict=[webResponse getAppData];
    
    if (!finance)
    {
 
        dataDict=[dict objectForKey:@"dealerInfo"];
        _callArray = [@[[dataDict objectForKey:@"dealerServicePhone"]]mutableCopy];
    }
    else
    {
       self.roadSideNavBar.topItem.title = @"Financial Link's";
        _callArray = [dict objectForKey:@"financialLinks"];
        //_callArray = [@[[dataDict objectForKey:@"dealerServicePhone"]]mutableCopy];
    }
  
    
    [self.tableView reloadData];
   
 
      [self.bgImage setImage:[webResponse showBgImage]];
    
   // UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
   // UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
   // effectView.frame = self.view.frame;
    
  //  [self.bgImage addSubview:effectView];
    
    //  [self.tableView insertSubview:_bgImage atIndex:0];
    // [self.view setNeedsLayout];
}


#pragma mark TableViewDataSourcesDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_callArray count];
    //return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"tabcell";
    tablecell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
   {
      cell=[[tablecell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSLog(@"hiiiiiiiiiii");
    
   //cell.lblTitle.text = @"Honda";
   //cell.lblSubTitle.text=[_callArray objectAtIndex:indexPath.row];
   
    cell.backgroundColor=[UIColor clearColor];
//    cell.backgroundView=nil;
//
    if (finance)
    {
        cell.lblSubTitle.font = [UIFont systemFontOfSize:15];
        cell.lblSubTitle.text = [_callArray[indexPath.row] objectForKey:@"linkTitle"];
        cell.lblTitle.text = @"Honda";
    }
    else
    {
    cell.lblSubTitle.text=[_callArray objectAtIndex:indexPath.row];
    cell.lblTitle.text = @"Honda";
    cell.iconImage.image=[UIImage imageNamed:@"hondaOwner.png"];
    }
//
//    [cell.iconImage.layer setCornerRadius:10.0f];
    
    
    return cell;
}
#pragma mark TableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (finance) {
        WebControllerViewController *webController=[self.storyboard  instantiateViewControllerWithIdentifier:@"webContent"];
        [webController setWebUrl:[_callArray[indexPath.row] objectForKey:@"linkURL"]];
        [webController setWebTitle:[_callArray[indexPath.row] objectForKey:@"linkTitle"]];
        [webController setIsPresentView:YES];
        [self presentViewController:webController animated:YES completion:nil];
    }else {
    callStr = [_callArray objectAtIndex:indexPath.row];
    NSString *message = [NSString stringWithFormat:@"Would You Like To Call %@", callStr];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Call" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark AlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
        if (buttonIndex==1) {
            NSString *phoneNumber=callStr;
            
            NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phoneNumber]];
            
            if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
                [[UIApplication sharedApplication] openURL:phoneUrl];
            } else
            {
                UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [calert show];
            }
        }
    
}


- (IBAction)tapCancel:(id)sender
{
    MMDrawerController*first=[self.storyboard instantiateViewControllerWithIdentifier:@"Drawer"];
    [self presentViewController:first animated:NO completion:nil];
    
}
@end
