//
//  BussinessWebViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/17.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BussinessWebViewController.h"
#import "Header.h"

@interface BussinessWebViewController ()<UIWebViewDelegate>
@property(nonatomic, strong)UIWebView *webView;

@end

@implementation BussinessWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] init];
    //    self.webView.frame = CGRectMake(0, CGRectGetMaxY(self.titleImv.frame)+20, self.view.frame.size.width, 300);
    
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.backBT addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.webView.scalesPageToFit = YES;
    NSLog(@"%@", self.webAddress);
    
    NSURL * url = [NSURL URLWithString:self.webAddress];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
    self.webView.delegate = self;
    
    
}

//返回
-(void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"加载出错");
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"停止加载");
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载");
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
