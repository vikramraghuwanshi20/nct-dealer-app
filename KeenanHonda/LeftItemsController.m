//
//  LeftItemsController.m
//  KeenanHonda
//
//  Created by Vikram on 4/21/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "LeftItemsController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "DetailTableViewController.h"
#import "RSSCellTableViewCell.h"
#import "NSString+HTML.h"
#import "WebData.h"
#import "Costants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SDWebImageManager.h"
#import "WebViewController.h"



@interface LeftItemsController ()<WebDataDelegate>
{
    
    WebData *webResponse;
    NSDictionary *dataDict;

    NSString *strAbout;
    NSString *strAbtImg;
    NSArray *socialLinkArray;
    NSArray *socialTitle;
}
@end

@implementation LeftItemsController
@synthesize itemsToDisplay;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    if ([self.mainMenu isEqualToString:@"Main"]) {
        self.btnNavCancel.title=@"Cancel";
    }else{
    [self setupLeftMenuButton];
   // [self setupRightMenuButton];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;

//self.navigationController.navigationBar.translucent = YES;
    
    
    self.title = @"Loading...";
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    parsedItems = [[NSMutableArray alloc] init];
    self.itemsToDisplay = [NSArray array];
    
  
    // Parse
    //	NSURL *feedURL = [NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
    //	NSURL *feedURL = [NSURL URLWithString:@"http://feeds.mashable.com/Mashable"];
    
  
      NSURL *feedURL = [NSURL URLWithString:self.dataUrls];
    feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
    feedParser.connectionType = ConnectionTypeAsynchronously;
    [feedParser parse];
   
    //Glove box
    webResponse=[[WebData alloc]init];
    dataDict=[webResponse getAppData];
    NSDictionary *infoDict=[dataDict objectForKey:@"dealerInfo"];
    socialLinkArray=@[[infoDict objectForKey:@"dealerFacebookURL"],[infoDict objectForKey:@"dealerTwitterURL"],[infoDict objectForKey:@"dealerYouTubeURL"],[infoDict objectForKey:@"dealerGooglePlusURL"],[infoDict objectForKey:@"dealerBlogURL"]];
    
    socialTitle=@[@"Like us on Facebook!",@"Follow us on Twitter!",@"YouTube",@"Google+",@"Blog"];
    
}
-(void)viewWillAppear:(BOOL)animated{
    UIImage *barImage=[[UIImage imageNamed:@"navBarFade.png"]
                       resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:barImage                                                forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupLeftMenuButton {
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton];
}
- (void)setupRightMenuButton {
    UIImage *phoneImage=[[UIImage imageNamed:@"mphone.png"]
                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(0.0, 0.0, 25.0, 25.0)];
    [button1 addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setImage:phoneImage forState:UIControlStateNormal];
    
    MMDrawerBarButtonItem * rightDrawerButton = [[MMDrawerBarButtonItem alloc] initWithCustomView:button1];

    [self.navigationItem setRightBarButtonItem:rightDrawerButton];
}

- (void)leftDrawerButtonPress:(id)leftDrawerButtonPress {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (void)rightDrawerButtonPress:(id)rightDrawerButtonPress {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewDidDisappear:(BOOL)animated{
 [feedParser stopParsing];
}
- (void)refresh {
   
    self.title = @"Refreshing...";
    [parsedItems removeAllObjects];
   
    [feedParser parse];
    self.tableView.userInteractionEnabled = NO;
    self.tableView.alpha = 0.3;
}

- (void)updateTableWithParsedItems {
    self.itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
                           [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date"
                                                                                ascending:NO]]];
    self.tableView.userInteractionEnabled = YES;
    self.tableView.alpha = 1;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
    NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    NSLog(@"Parsed Feed Info: “%@”", info.title);
   // self.title = info.title;
    self.title=self.newsTitle;
    
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    NSLog(@"Parsed Feed Item: “%@”", item.title);
    if (item) [parsedItems addObject:item];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
    [self updateTableWithParsedItems];
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    NSLog(@"Finished Parsing With Error: %@", error);
    if (parsedItems.count == 0) {
        if (![self.dataUrls isEqualToString:@"Glove"]) {
            
            self.title=@"Failed";
        }else{
            self.title=self.newsTitle;
        }
 // Show failed message in title
    } else {
        // Failed but some items parsed, so show and inform of error
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parsing Incomplete"
                                                        message:@"There was an error during the parsing of this feed. Not all of the feed items could parsed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [alert show];
    }
    [self updateTableWithParsedItems];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (![self.dataUrls isEqualToString:@"Glove"]) {
       
        return itemsToDisplay.count;
    }else{
     return [socialTitle count];
    }
   
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    RSSCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
    if (![self.dataUrls isEqualToString:@"Glove"]) {
    
    MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
    if (item) {
        
        // Process
        NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
        cell.lblTitle.text=itemTitle;
        NSString *yourFullURL = item.content;
        NSRange t = [yourFullURL rangeOfString:@"/>"];
        if(t.location !=NSNotFound){
            NSString *yourJPGURL = [yourFullURL substringToIndex:t.location];
           
            yourJPGURL = [yourJPGURL substringFromIndex:[yourJPGURL rangeOfString:@"src="].location+[@"src=" length]+1];
            yourJPGURL = [yourJPGURL substringToIndex:[yourJPGURL rangeOfString:@"width="].location-2];
           
            
            cell.imgRss.layer.borderColor=[UIColor whiteColor].CGColor;
            cell.imgRss.layer.borderWidth=1;
            cell.imgRss.layer.masksToBounds=YES;
            if (yourFullURL==nil) {
                cell.imgRss.layer.cornerRadius=5;
                cell.imgRss.image=[UIImage imageNamed:@"transparent honda.png"];
            }else{
                cell.imgRss.layer.cornerRadius=10;
                [cell.imgRss sd_setImageWithURL:[NSURL URLWithString:yourJPGURL] placeholderImage:nil];
            }

        }
      
     }
    }else {
        cell.lblTitle.text=[socialTitle objectAtIndex:indexPath.row];
        cell.lblTitle.font=[UIFont systemFontOfSize:20];
        cell.imgRss.image=[UIImage imageNamed:@"transparent honda.png"];
    }
    
    [cell.imgRss setContentMode:UIViewContentModeScaleAspectFill];

    return cell;
}
#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![self.dataUrls isEqualToString:@"Glove"]) {
    // Show detail
    DetailTableViewController *detail = [[DetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    detail.item = (MWFeedItem *)[itemsToDisplay objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
        
    }
    else
    {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      WebControllerViewController *webController=[storyboard instantiateViewControllerWithIdentifier:@"webContent"];
        [webController setWebUrl:[socialLinkArray objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:webController animated:YES];
    }
   
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
    
}

- (IBAction)tapNavCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
