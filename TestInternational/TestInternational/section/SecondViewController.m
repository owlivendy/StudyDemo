//
//  SecondViewController.m
//  TestInternational
//
//  Created by TF14975 on 2018/8/30.
//  Copyright © 2018年 TF14975. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){10,100,80,14}];
    //    [NSBundle.mainBundle localizedStringForKey:@"" value:nil table:nil];
    
    label.text = NSLocalizedString(@"首页", nil);;
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
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
