//
//  ViewController.m
//  TestInternational
//
//  Created by TF14975 on 2018/8/29.
//  Copyright © 2018年 TF14975. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){10,100,80,14}];
    
//    [NSBundle.mainBundle localizedStringForKey:@"" value:nil table:nil];
    label.text = NSLocalizedString(@"你好", nil);
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
