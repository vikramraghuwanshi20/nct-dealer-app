//
//  FeedBackViewController.m
//  KeenanHonda
//
//  Created by Vikram on 4/28/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "FeedBackViewController.h"
#import "FeedbackCell.h"
#import "CreateProfile.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *barImage=[[UIImage imageNamed:@"navBarFade.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(-20, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.feedNavBar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
    //self.feedNavBar.shadowImage = [UIImage new];
    self.feedNavBar.translucent=NO;
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FeedbackCell *cell;
    if (indexPath.row==0) {
        cell=[tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
        [cell.btnCreateProfile addTarget:self action:@selector(tapProfile) forControlEvents:UIControlEventTouchUpInside];
    }else if (indexPath.row==1){
    
        cell=[tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
        
    }
    return cell;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    textView.textColor=[UIColor blackColor];
textView.text=@"";
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqual:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
   
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
     NSLog(@"text %@",textView.text);
    return YES;
}
-(void)tapProfile{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CreateProfile *profile=(CreateProfile *)[storyboard instantiateViewControllerWithIdentifier:@"createprofile"];
    [self presentViewController:profile animated:YES completion:nil];
}
- (IBAction)tapNavCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tapNavSend:(id)sender {
}
@end
