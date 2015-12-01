//
//  WebControllerViewController.m
//  KeenanHonda
//
//  Created by Vikram on 4/18/15.
//  Copyright (c) 2015 Vikram. All rights reserved.
//

#import "WebViewController.h"
#import "Costants.h"
#import "WebData.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface WebControllerViewController ()

@end

@implementation WebControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewSetUp];
//    webView.layer.borderColor=[UIColor blackColor].CGColor;
//    webView.layer.borderWidth=1;
//    webView.layer.cornerRadius=1;
   
    UIImage *barImage=[[UIImage imageNamed:@"navBarFade.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.webNavBar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
     self.webNavBar.shadowImage = [UIImage new];
    if (self.isPresentView) {
        self.btnNavCancel.title=@"Cancel";
        self.webNavBar.topItem.title=self.webTitle;
    }else{
    self.btnNavCancel.title=@"";
    }
    
    self.title= self.webTitle;
    [self loadRequestFromString:self.webUrl];
}

-(void)viewSetUp{
    WebData *webResponse=[[WebData alloc]init];
    NSDictionary *dataDict=[webResponse getAppData];
    NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir  = [documentPaths objectAtIndex:0];
    NSString  *pngfile = [documentsDir stringByAppendingPathComponent:@"bgImage.png"];
    
    self.bgImage.image=[UIImage imageWithContentsOfFile:pngfile];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadRequestFromString:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)tapNavCancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)nxtBtn:(id)sender{
    [webView goForward];
}
-(IBAction)preBtn:(id)sender{
    [webView goBack];
}
-(IBAction)refreshBtn:(id)sender{
    [webView reload];
}
-(IBAction)homeBtn:(id)sender{
    
    [self loadRequestFromString:self.webUrl];
}



#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.btnBackward.enabled=NO;
    self.btnForward.enabled=NO;
    self.btnHome.enabled=NO;
    self.btnRefresh.enabled=NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  
}
- (void)webViewDidFinishLoad:(UIWebView *)theWebView
{
    if ([self.webTitle isEqualToString:Show_Floor] ||[self.webTitle isEqualToString:PRE_OWNED] ||[self.webTitle isEqualToString:OUR_WEBSITE] ||[self.webTitle isEqualToString:NEW_SALES]) {
        if (iPHONE_6) {
            NSString *jsCommand = [NSString stringWithFormat:@"document.body.style.zoom = 1.2;"];
            [webView stringByEvaluatingJavaScriptFromString:jsCommand];

        }else if (iPHONE_6plus)
        {
            NSString *jsCommand = [NSString stringWithFormat:@"document.body.style.zoom = 1.3;"];
            [webView stringByEvaluatingJavaScriptFromString:jsCommand];
        }
    }


    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.btnBackward.enabled=YES;
    self.btnForward.enabled=YES;
    self.btnHome.enabled=YES;
    self.btnRefresh.enabled=YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error Message %@ ",error.localizedDescription);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
}
-(void)viewDidDisappear:(BOOL)animated{
   
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}
@end
