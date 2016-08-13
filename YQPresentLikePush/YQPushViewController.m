//
//  YQPushViewController.m
//  YQPresentLikePush
//
//  Created by 杨麒 on 16/8/13.
//  Copyright © 2016年 杨麒. All rights reserved.
//

#import "YQPushViewController.h"

@interface YQPushViewController ()

@end

@implementation YQPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title= @"push过来的页面";
    
    self.view.backgroundColor = [UIColor lightGrayColor];
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
