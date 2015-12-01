//
//  oRewards.m
//  RABMotors
//
//  Created by supermandt on 1/2/13.
//
//

#import "oRewards.h"

#define IMG_ACCOUNTNUMBER  @"img_accountnumber.jpg"


@implementation oRewards

@synthesize fullname,barcode,zipcode,acctnumber,pointsbalance,bdesc1,bdesc2,bdesc3,bdesc4,qty1,qty2,qty3,qty4;

-(id)init
{
	if (self = [super init])
	{
        
	}
	
	return self;
}


-(void)LoadInfo
{

    NSUserDefaults *usr  = [NSUserDefaults standardUserDefaults];
    self.acctnumber = [usr stringForKey:@"acctnumber"];
    self.fullname = [usr stringForKey:@"fullname"];
    self.zipcode = [usr stringForKey:@"zipcode"];
    self.pointsbalance = [usr stringForKey:@"pointsbalance"];
    self.bdesc1 =[usr stringForKey:@"bdesc1"];
    self.bdesc2 =[usr stringForKey:@"bdesc2"];
    self.bdesc3 =[usr stringForKey:@"bdesc3"];
    self.bdesc4 =[usr stringForKey:@"bdesc4"];
    self.qty1 =[usr stringForKey:@"qty1"];
    self.qty2 =[usr stringForKey:@"qty2"];
    self.qty3 =[usr stringForKey:@"qty3"];
    self.qty4 =[usr stringForKey:@"qty4"];
    
    //[self LoadPhotoFromDisk];
    
}

-(void)SaveInfo
{
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
    [usr setObject:self.acctnumber forKey:@"acctnumber"];
    [usr setObject:self.fullname forKey:@"fullname"];
    [usr setObject:self.zipcode forKey:@"zipcode"];
    [usr setObject:self.pointsbalance forKey:@"pointsbalance"];
    [usr setObject:self.bdesc1 forKey:@"bdesc1"];
    [usr setObject:self.bdesc2 forKey:@"bdesc2"];
    [usr setObject:self.bdesc3 forKey:@"bdesc3"];
    [usr setObject:self.bdesc4 forKey:@"bdesc4"];
    [usr setObject:self.qty1 forKey:@"qty1"];
    [usr setObject:self.qty2 forKey:@"qty2"];
    [usr setObject:self.qty3 forKey:@"qty3"];
    [usr setObject:self.qty4 forKey:@"qty4"];
    
//    [self SavePhotoToDisk];
    
}



-(void)SavePhotoToDisk
{
    
	[UIImageJPEGRepresentation(barcode,0.9) writeToFile:[self GetDataPath] atomically:YES];
}

-(UIImage *)LoadPhotoFromDisk
{
    barcode = [UIImage imageWithContentsOfFile:[self GetDataPath]];
	
	return barcode;
}

- (NSString *)GetDataPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:IMG_ACCOUNTNUMBER];
}

+(void)MessageBox:(NSString *)stitle message:(NSString *)mes
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:stitle
                                                      message:mes
                                                     delegate:nil
                                            cancelButtonTitle:@"Okay"
                                            otherButtonTitles:nil];
    
    [message show];
}


+(void)FlipHorizontal:(UIView *)img
{
	img.transform = CGAffineTransformMakeScale(-1, 1);
}
+(void)FlipVertical:(UIView *)img
{
	img.transform = CGAffineTransformMakeScale(1.0, -1.0);
}

+(void)FlipToOriginal:(UIView *)img
{
	img.transform = CGAffineTransformIdentity;
}


+(void)FlipBackground:(UIView *)v
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.76];
	if (v.tag == 0)
	{
		[self FlipHorizontal:v];
		v.tag = 989;
	}
	else
	{
		[self FlipToOriginal:v];
		v.tag = 0;
	}
	
	
	[UIView commitAnimations];
    
}

+(void)FlipBackground:(UIView *)v newTag:(NSInteger)tag
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.76];
	if (v.tag == 0)
	{
		[self FlipHorizontal:v];
		v.tag = tag;
	}
	else
	{
		[self FlipToOriginal:v];
		v.tag = 0;
	}
	
	
	[UIView commitAnimations];
    
}




@end
