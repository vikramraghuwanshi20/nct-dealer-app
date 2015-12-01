//
//  CreateProfile.m
//  KeenanHonda
//
//  Created by Vikram on 4/24/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "CreateProfile.h"
#import "ProfileCell.h"

@interface CreateProfile ()
{

    NSInteger forPicker;
    BOOL rowTap;
   // NSMutableDictionary *userData;
}
@end

@implementation CreateProfile

- (void)viewDidLoad
{
    [super viewDidLoad];
//    forPicker=0;
//    rowTap=NO;
//    self.automaticallyAdjustsScrollViewInsets=NO;
//   userData=[[NSMutableDictionary alloc]init];
//    self.vSpace.constant -=70;
//    [self.toolBar layoutIfNeeded];
//    UIImage *barImage=[[UIImage imageNamed:@"navBarFade.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(-20, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
//    [self.profileNavBar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
       // Do any additional setup after loading the view.
  }

//-(void)viewDidAppear:(BOOL)animated{
//    animated=YES;
//}
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

//Navigation Buttons
-(IBAction)tapNavCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)tapNavDone:(id)sender
{
   // NSLog(@"Save Data %@",userData);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section==3) {
        return 2;
    }
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCell *cell;
    if (indexPath.section==0) {
        cell=[tableView dequeueReusableCellWithIdentifier:@"nameCell" forIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        cell.txtFname.tag=1;
        cell.txtLname.tag=2;
        cell.txtFname.delegate=self;
        cell.txtLname.delegate=self;
        
       
    }
    if (indexPath.section==1) {
        cell=[tableView dequeueReusableCellWithIdentifier:@"mailCell" forIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
        cell.txtEmail.tag=3;
        cell.txtPhone.tag=4;
        cell.txtEmail.delegate=self;
        cell.txtPhone.delegate=self;
        
    }
    if (indexPath.section==2) {
        cell=[tableView dequeueReusableCellWithIdentifier:@"rewardCell" forIndexPath:[NSIndexPath indexPathForItem:0 inSection:2]];
        cell.txtRewardNumber.tag=5;
        cell.txtRewardNumber.delegate=self;
          }
    if (indexPath.section==3) {
        cell=[tableView dequeueReusableCellWithIdentifier:@"cpreferenceCell" forIndexPath:[NSIndexPath indexPathForItem:0 inSection:3]];
        if (indexPath.row==1) {
            cell.lblTitle.text=@"My location";
            cell.lblContacPref.text=@"Keenan honda";
        }
    }
    if (indexPath.section==4) {
       
        cell=[tableView dequeueReusableCellWithIdentifier:@"locationCell" forIndexPath:[NSIndexPath indexPathForItem:0 inSection:4]];
           }

    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  //  [self.view layoutIfNeeded];
    NSLog(@"%ld,%ld",indexPath.section,indexPath.row);
    if(rowTap==YES){
        [self HiedPickerview];
    }
    
    if (indexPath.section==3 && indexPath.row==1){
        pickerData = @[@"Keenan Honda"];
        [self showPickerview];
        [self.pickerView reloadAllComponents];
        forPicker=1;
        
    }
    else if(indexPath.section==3 && indexPath.row==0){
        pickerData = @[@"By Phone", @"By Email", @"By App"];
        [self showPickerview];
        [self.pickerView reloadAllComponents];
        forPicker=0;
    }
       
  
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//PickerView DataSource Delegate

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerData[row];
}

//PickerView Deleagte

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    NSString *resultString = pickerData[row];
    ProfileCell *cell=(ProfileCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:forPicker inSection:3]];
  
    cell.lblContacPref.text=resultString;
    if (forPicker==0) {
        [self setValue:resultString forKey:@"Contacts"];
    }else{
        [self setValue:resultString forKey:@"Location"];
    }
   
}

#pragma mark
#pragma mark TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   
    NSArray *titleArray=@[@"Fname",@"Lname",@"Email",@"Phone",@"Contacts",@"Rewardnum"];
    
         [self setValue:textField.text forKey:[titleArray objectAtIndex:textField.tag-1]];
    
    
    NSInteger nextTag = textField.tag + 1;
    if (nextTag>5) {
       [self.tableView setContentOffset:CGPointMake(0, 50) animated:YES];
        pickerData = @[@"By Phone", @"By Email", @"By App"];
        [self showPickerview];
        [self.pickerView reloadAllComponents];
    }
    UIView* nextResponder = [self.view viewWithTag:nextTag];
    [textField resignFirstResponder];
       if (nextResponder) {
       
        [nextResponder becomeFirstResponder];
    }
    return YES;
}

//Dictionary For UserData

- (void)setValue:(id)value forKey:(NSString *)key
{
    //[userData setObject:value forKey:key];
}

#pragma mark PickerControls Method

-(void)showPickerview{
    rowTap=YES;
      [self.tableView setContentOffset:CGPointMake(0, 50) animated:YES];
        [UIView animateWithDuration:0.3f animations:^{
            // CGRect newFrame = self.toolBar.frame;
            self.vSpace.constant +=225 ;
            [self.view layoutIfNeeded];
        }];
        
}

-(void)HiedPickerview{
    rowTap=NO;
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    [UIView animateWithDuration:0.3f animations:^{
        // CGRect newFrame = self.toolBar.frame;
        self.vSpace.constant -=225 ;
        [self.view layoutIfNeeded];
    }];

}
- (IBAction)tapDone:(id)sender {
    [self HiedPickerview];
}

- (IBAction)tapCancel:(id)sender {
    [self HiedPickerview];
}



@end
