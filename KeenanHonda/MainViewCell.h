//
//  MainViewCell.h
//  KeenanHonda
//
//  Created by Vikram on 4/26/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewCell : UICollectionViewCell
//@property(strong,nonatomic)IBOutlet UIImageView *imgIcon;
//@property(strong,nonatomic)IBOutlet UILabel *lblIconTitle;



@property(nonatomic,strong)IBOutlet UIImageView *iconImage;
@property(nonatomic,strong)IBOutlet UILabel *lblTitle;
@property(nonatomic,strong)IBOutlet UILabel *lblSubTitle;

@end
