//
//  FirstViewController.h
//  KeenanHonda
//
//  Created by Vikram on 4/17/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebData.h"
#import "SDWebImageManager.h"
#import <MessageUI/MessageUI.h>

@interface FirstViewController : UIViewController<WebDataDelegate,UICollectionViewDataSource,UICollectionViewDelegate,SDWebImageManagerDelegate,UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
{
    WebData *webResponse;
    IBOutlet UIImageView *bgImage;
    
    
}

@property(strong,nonatomic)MFMailComposeViewController *mailer;
@property (strong, nonatomic) NSMutableArray *iconsArray;
@property (strong, nonatomic) NSMutableArray *titleArray;
@property(nonatomic) BOOL showLaunchScreen;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property(strong,nonatomic)IBOutlet UITableView*tableView;
-(void)CallEmailDirectionMethod;
-(UIButton *)buttonWithTitle:(NSString *)title
                       target:(id)target
                     selector:(SEL)selector
                        frame:(CGRect)frame
                        image:(UIImage *)image
                 imagePressed:(UIImage *)imagePressed
                darkTextColor:(BOOL)darkTextColor;
@end
