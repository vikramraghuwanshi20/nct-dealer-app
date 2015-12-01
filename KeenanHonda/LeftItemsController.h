//
//  LeftItemsController.h
//  KeenanHonda
//
//  Created by Vikram on 4/21/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"
#import "LeftViewController.h"

@interface LeftItemsController : UIViewController<UITableViewDataSource,UITableViewDelegate ,MWFeedParserDelegate,LeftMenuDelegate>
{
    LeftViewController *leftmenu;
    // Parsing
    
    MWFeedParser *feedParser;
    NSMutableArray *parsedItems;
   
    // Displaying
    NSArray *itemsToDisplay;
    NSDateFormatter *formatter;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnNavCancel;
@property(nonatomic,strong) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSString *dataUrls;
@property(nonatomic,strong) NSString *mainMenu;
@property(nonatomic,strong) NSString *newsTitle;
@property(nonatomic,strong)NSArray *itemsToDisplay;

- (IBAction)tapNavCancel:(id)sender;
@end
