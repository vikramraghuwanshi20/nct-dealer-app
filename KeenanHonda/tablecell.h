//
//  tablecell.h
//  NcompassDealerApp
//
//  Created by prateek on 16/12/15.
//  Copyright © 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tablecell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIImageView *iconImage;
@property(nonatomic,strong)IBOutlet UILabel *lblTitle;
@property(nonatomic,strong)IBOutlet UILabel *lblSubTitle;


@end
