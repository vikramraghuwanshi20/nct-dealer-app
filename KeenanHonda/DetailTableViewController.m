//
//  DetailTableViewController.m
//  MWFeedParser
//
//  Copyright (c) 2010 Michael Waterfall
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  1. The above copyright notice and this permission notice shall be included
//     in all copies or substantial portions of the Software.
//  
//  2. This Software cannot be used to archive or collect data such as (but not
//     limited to) that of events, news, experiences and activities, for the 
//     purpose of any concept relating to diary/journal keeping.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "DetailTableViewController.h"
#import "NSString+HTML.h"
#import "WebViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

typedef enum { SectionHeader ,SectionDetail} Sections;
typedef enum { SectionHeaderTitle, SectionHeaderDate, SectionHeaderURL, SectionHeaderAuthor  } HeaderRows;
typedef enum { SectionDetailSummary } DetailRows;

@implementation DetailTableViewController

@synthesize item, dateString, summaryString, contentString;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithStyle:style])) {
		
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	
	// Super
    [super viewDidLoad];

	// Date
	if (item.date) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterMediumStyle];
		[formatter setTimeStyle:NSDateFormatterMediumStyle];
		self.dateString = [formatter stringFromDate:item.date];
	}
	
	// Summary
	if (item.summary || item.content) {
		self.summaryString = [item.summary stringByConvertingHTMLToPlainText];
        self.contentString=[item.content stringByConvertingHTMLToPlainText];
	} else {
        self.contentString= @"[No Content]";
		self.summaryString = @"[No Summary]";
	}
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    //self.tableView.backgroundColor=[UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}
-(void)viewWillAppear:(BOOL)animated{
    UIImage *barImage=[[UIImage imageNamed:@"navBarFade.png"]
                       resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:barImage                                                forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor=[UIColor clearColor];
}
#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	switch (section) {
		case 0: return 4;
		default: return 1;
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // Get cell
	static NSString *CellIdentifier = @"CellA";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	// Display
	cell.textLabel.textColor = [UIColor blackColor];
	cell.textLabel.font = [UIFont systemFontOfSize:15];
	if (item) {
		
		// Item Info
		NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
		
		// Display
		switch (indexPath.section) {
			case SectionHeader: {
				
				// Header
				switch (indexPath.row) {
                    case SectionHeaderTitle:{
                        
                   UIImageView *customImageView = [[UIImageView alloc] init];
                        customImageView.translatesAutoresizingMaskIntoConstraints = NO;
                        customImageView.tag = 10;
                        [cell.contentView addSubview:customImageView];
                        
                     UILabel   *customLabel = [[UILabel alloc] init];
                        customLabel.translatesAutoresizingMaskIntoConstraints = NO;
                        customLabel.tag = 20;
                        [cell.contentView addSubview:customLabel];
                        
                        NSDictionary *views = NSDictionaryOfVariableBindings(customImageView, customLabel);
                        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[customImageView]-10-|" options:0 metrics:nil views:views]];
                        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[customImageView]-3-|"                 options:0 metrics:nil views:views]];
                        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[customLabel]-3-|"                     options:0 metrics:nil views:views]];
                        NSString *yourFullURL = item.content;
                        NSRange t = [yourFullURL rangeOfString:@"/>"];
                        if(t.location !=NSNotFound){
                            NSString *yourJPGURL = [yourFullURL substringToIndex:t.location];
                            
                            yourJPGURL = [yourJPGURL substringFromIndex:[yourJPGURL rangeOfString:@"src="].location+[@"src=" length]+1];
                            yourJPGURL = [yourJPGURL substringToIndex:[yourJPGURL rangeOfString:@"width="].location-2];
                          
                            customImageView.layer.borderColor=[UIColor whiteColor].CGColor;
                            customImageView.layer.borderWidth=1;
                            customImageView.layer.masksToBounds=YES;
                            if (yourFullURL==nil) {
                                customImageView.layer.cornerRadius=5;
                                customImageView.image=[UIImage imageNamed:@"transparent honda.png"];
                            }else{
                                customImageView.layer.cornerRadius=10;
                              [customImageView sd_setImageWithURL:[NSURL URLWithString:yourJPGURL] placeholderImage:nil];
                            }            NSLog(@"images %@",cell.imageView);
                            
                            [customImageView setContentMode:UIViewContentModeScaleAspectFill];

                           
                        }
      
						break;
                    }
					case SectionHeaderDate:
						cell.textLabel.text = dateString ? dateString : @"[No Date]";
						break;
					case SectionHeaderURL:
						cell.textLabel.text = item.link ? item.link : @"[No Link]";
						cell.textLabel.textColor = [UIColor blueColor];
						cell.selectionStyle = UITableViewCellSelectionStyleBlue;
						break;
					case SectionHeaderAuthor:
                        
                        //cell.textLabel.text = item.author ? item.author : @"[No author]";
                        
                        cell.textLabel.text =[NSString stringWithFormat:@"%@",summaryString];
                        cell.textLabel.numberOfLines = 0;
						break;
                    	}
				break;
				
			}
//            case SectionDetail: {
//                
//                // Summary
//                cell.textLabel.text =[NSString stringWithFormat:@"%@",summaryString];
//                cell.textLabel.numberOfLines = 0; // Multiline
//                break;
//                
//            }

		}
	}
    
    return cell;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == SectionHeader) {
        if(indexPath.row==0){
            return 250;
        }
        else if (indexPath.row==3){
            NSString *conSumString=[NSString stringWithFormat:@"%@",summaryString];
            // Get height of summary
            NSString *summary = @"[No Summary]";
            if (summaryString) summary = conSumString;
            CGSize s = [summary sizeWithFont:[UIFont systemFontOfSize:15]
                           constrainedToSize:CGSizeMake(self.view.bounds.size.width - 40, MAXFLOAT)  // - 40 For cell padding
                               lineBreakMode:UILineBreakModeWordWrap];
            return s.height + 16; // Add padding
            
        }

		return 34;
		
	}
       else {
        NSString *conSumString=[NSString stringWithFormat:@"%@",summaryString];
		// Get height of summary
		NSString *summary = @"[No Summary]";
		if (summaryString) summary = conSumString;
		CGSize s = [summary sizeWithFont:[UIFont systemFontOfSize:15] 
					   constrainedToSize:CGSizeMake(self.view.bounds.size.width - 40, MAXFLOAT)  // - 40 For cell padding
						   lineBreakMode:UILineBreakModeWordWrap];
		return s.height + 16; // Add padding
		
	}
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	// Open URL
	if (indexPath.section == SectionHeader && indexPath.row == SectionHeaderURL) {
		if (item.link) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            WebControllerViewController *webController = (WebControllerViewController *)[storyboard instantiateViewControllerWithIdentifier:@"webContent"];
            webController.webUrl=item.link;
            [self.navigationController pushViewController:webController animated:YES];
		}
	}
	
	// Deselect
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }
    return 0;
}

@end

