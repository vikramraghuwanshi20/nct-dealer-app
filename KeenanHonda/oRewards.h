//
//  oRewards.h
//  RABMotors
//
//  Created by supermandt on 1/2/13.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface oRewards : NSObject
{
    NSString *acctnumber;
    NSString *fullname;
    NSString *zipcode;
    UIImage *barcode;
    NSString *pointsbalance;
    NSString *bdesc1;
    NSString *bdesc2;
    NSString *bdesc3;
    NSString *bdesc4;
    NSString *qty1;
    NSString *qty2;
    NSString *qty3;
    NSString *qty4;
    
}

@property(nonatomic,copy) NSString *acctnumber;
@property(nonatomic,copy) NSString *fullname;
@property(nonatomic,copy) NSString *zipcode;
@property(nonatomic,copy) UIImage *barcode;

@property(nonatomic,copy) NSString *pointsbalance;
@property(nonatomic,copy) NSString *bdesc1;
@property(nonatomic,copy) NSString *bdesc2;
@property(nonatomic,copy) NSString *bdesc3;
@property(nonatomic,copy) NSString *bdesc4;
@property(nonatomic,copy) NSString *qty1;
@property(nonatomic,copy) NSString *qty2;
@property(nonatomic,copy) NSString *qty3;
@property(nonatomic,copy) NSString *qty4;



-(void)LoadInfo;
- (NSString *)GetDataPath;
-(void)SavePhotoToDisk;
-(UIImage *)LoadPhotoFromDisk;
-(void)SaveInfo;

+(void)MessageBox:(NSString *)stitle message:(NSString *)mes;
+(void)FlipHorizontal:(UIView *)img;
+(void)FlipVertical:(UIView *)img;
+(void)FlipToOriginal:(UIView *)img;
+(void)FlipBackground:(UIView *)v;
+(void)FlipBackground:(UIView *)v newTag:(NSInteger)tag;


@end
