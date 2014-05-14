//
//  ViewController.m
//  MySafari
//
//  Created by tbredemeier on 5/14/14.
//  Copyright (c) 2014 Mobile Makers Academy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UITextField *myURLTextField;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation ViewController

// DRY helper method
- (void)goToURLString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView  loadRequest:request];
}

- (IBAction)onBackButtonPressed:(id)sender
{
    [self.myWebView goBack];
}

- (IBAction)onForwardButtonPressed:(id)sender
{
    [self.myWebView goForward];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender
{
    [self.myWebView stopLoading];
}

- (IBAction)onReloadButtonPressed:(id)sender
{
    [self.myWebView reload];
}

- (IBAction)onClearButtonPressed:(id)sender
{
    self.myURLTextField.text = @"";
}

- (IBAction)onPlusButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]init];
    alert.title = @"Coming Soon!";
    [alert addButtonWithTitle:@"Done"];
    alert.delegate = self;
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *prefix = @"http://";
    NSString *urlString = textField.text;
    if(![urlString hasPrefix: prefix])
    {
        urlString = [prefix stringByAppendingString:urlString];
    }

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView  loadRequest:request];

    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backButton.enabled = self.myWebView.canGoBack;
    self.forwardButton.enabled = self.myWebView.canGoForward;
    self.myURLTextField.text = self.myWebView.request.URL.absoluteString;
}

@end
