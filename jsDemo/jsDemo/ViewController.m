//
//  ViewController.m
//  jsDemo
//
//  Created by zx on 1/13/15.
//  Copyright (c) 2015 zx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation ViewController
static NSString *JSHandler;

+ (void)initialize {
    JSHandler = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"resource/ajax_handler" withExtension:@"js"] encoding:NSUTF8StringEncoding error:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:JSHandler];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"resource/index" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:path];
    [self.webView loadRequest:request];
}

#define CocoaJSHandler @"mpAjaxHandler"
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([[[request URL] scheme] isEqual:CocoaJSHandler]) {
        NSString *requestedURLString = [[[request URL] absoluteString] substringFromIndex:[CocoaJSHandler length] + 3];
        
        NSLog(@"ajax request: %@", requestedURLString);
        return NO;
    }
    
    return YES;
}

@end
