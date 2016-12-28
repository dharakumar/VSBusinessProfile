//
//  YelpDisplayViewController.m
//  VSBusinessProfile
//
//  Created by Admin on 12/22/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "YelpDisplayViewController.h"

@interface YelpDisplayViewController ()

@end

@implementation YelpDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewDidAppear:(BOOL)animated
{
    NSLog(@"yelp VC appeared %@",self.string);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT ,0),
                   ^{
   [ self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.string]]];
                       });
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
