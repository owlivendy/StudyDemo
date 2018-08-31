//
//  ViewController.m
//  CoreTextDemo
//
//  Created by TF14975 on 2018/8/31.
//  Copyright © 2018年 TF14975. All rights reserved.
//

#import "AttributeStringDemoController.h"

@interface AttributeStringDemoController ()<UITextViewDelegate>

@end

@implementation AttributeStringDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextView *testLb = [[UITextView alloc] initWithFrame:(CGRect){10,20,300,200}];
    testLb.delegate = self;
    testLb.editable = NO;
    testLb.backgroundColor = [UIColor yellowColor];
//    testLb.numberOfLines = 0;
    [self.view addSubview:testLb];
    
    NSMutableAttributedString *attriText = [[NSMutableAttributedString alloc] init];
    [attriText appendAttributedString:[[NSAttributedString alloc] init]];
//    NSTextAttachment
//    [UIFont systemFontOfSize:14].lineHeight
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;
    paragraphStyle.paragraphSpacing = 10;
    paragraphStyle.firstLineHeadIndent = 10;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    [attriText appendAttributedString:[[NSAttributedString alloc] initWithString:@"http://www.baidu.com\n" attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSLinkAttributeName:[NSURL URLWithString:@"http://www.baidu.com"]}]];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    UIImage *appadd_img = [UIImage imageNamed:@"app_add"];
    attachment.image = appadd_img;
    attachment.bounds = CGRectMake(0, 0, appadd_img.size.width, appadd_img.size.height);
    [attriText appendAttributedString:[[NSAttributedString alloc] initWithString:@"图片（Attachment）" attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSAttachmentAttributeName:attachment}]];
    [attriText appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    
    
    [attriText appendAttributedString:[[NSAttributedString alloc] initWithString:@"阿斯达达到企鹅请求爱迪生ad强无敌阿斯达ad切切任务\n"
                                       "阿斯达切切为睡觉觉就前两位偶读请我觉就是垃圾诶就前两位偶读请我\n" attributes:@{NSParagraphStyleAttributeName:paragraphStyle}]];
    
    testLb.attributedText = attriText;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    NSLog(@"%@",textAttachment);
    NSLog(@"%@",NSStringFromRange(characterRange));
    NSLog(@"%d",interaction);
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    NSLog(@"%@",URL);
    NSLog(@"%@",NSStringFromRange(characterRange));
    NSLog(@"%d",interaction);
    return YES;
}




@end
