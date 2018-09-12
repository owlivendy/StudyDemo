//
//  ViewController.m
//  CoreTextDemo
//
//  Created by TF14975 on 2018/8/31.
//  Copyright © 2018年 TF14975. All rights reserved.
//

#import "ViewController.h"
#import "CTDisplayView.h"
#import <CoreText/CoreText.h>
//controller
#import "AttributeStringDemoController.h"

static CGFloat ascentCallback(void *ref) {
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"height"] floatValue];
}
static CGFloat descentCallback(void *ref) {
    return 0;
}
static CGFloat widthCallback(void* ref) {
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"width"] floatValue];
}

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CTDisplayView *ctview;

@property (nonatomic, copy) NSDictionary *info;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableAttributedString *attriText = [[NSMutableAttributedString alloc] init];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;
    paragraphStyle.paragraphSpacing = 10;
    paragraphStyle.firstLineHeadIndent = 20;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    const char httpchar[21] = "http://www.baidu.com\n";
    NSString *http = [NSString stringWithCString:httpchar encoding:NSUTF8StringEncoding];
    [attriText appendAttributedString:[[NSAttributedString alloc] initWithString:http attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSLinkAttributeName:[NSURL URLWithString:@"http://www.baidu.com"],NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSFontAttributeName:[UIFont systemFontOfSize:16]}]];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    UIImage *appadd_img = [UIImage imageNamed:@"app_add"];
    attachment.image = appadd_img;
    attachment.bounds = CGRectMake(0, 0, appadd_img.size.width, appadd_img.size.height);
    [attriText appendAttributedString:[[NSAttributedString alloc] initWithString:@"图片（Attachment）" attributes:@{NSParagraphStyleAttributeName:paragraphStyle}]];
    
    //****************************图片排版*************************************
    //******coretext 不支持图片排版，通过设置空白占位的宽高预留图片的位置************
    self.info = @{@"width":@(15),@"height":@(15)};
    NSDictionary *dict = self.info;
    CTRunDelegateCallbacks callbacks;
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)(dict));

    // 使用空格作为空白的占位符
    NSMutableAttributedString *space =
    [[NSMutableAttributedString alloc] initWithString:@" "
                                           attributes:nil];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space,
                                   CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    
    [attriText appendAttributedString:space];
    //***********************************************************************
    
    [attriText appendAttributedString:[[NSAttributedString alloc] initWithString:@"阿斯达达到企鹅请求爱迪生ad强无敌阿斯达ad切切任务\n"
                                       "阿斯达切切为睡觉觉就前两位偶读请我觉就是垃圾诶就前两位偶读请我\n" attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSStrikethroughStyleAttributeName:@(1),NSStrikethroughColorAttributeName:[UIColor grayColor],NSForegroundColorAttributeName:[UIColor blueColor]}]];
    
    self.ctview.attributeText = attriText;
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

//action
- (IBAction)attributeDemo:(id)sender {
    NSLog(@"%@",self.info);
//    AttributeStringDemoController *vc = [[AttributeStringDemoController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}



@end
