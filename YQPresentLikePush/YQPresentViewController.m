//
//  YQPresentViewController.m
//  YQPresentLikePush
//
//  Created by 杨麒 on 16/8/13.
//  Copyright © 2016年 杨麒. All rights reserved.
//

#import "YQPresentViewController.h"

@interface YQPresentViewController ()

@end

@implementation YQPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"present页面";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //添加返回键
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismissAction:)];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark - 返回按钮
- (void)dismissAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
