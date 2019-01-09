//
//  NetWorkViewController.m
//  WYAiOSEnv
//
//  Created by 李世航 on 2018/7/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "NetWorkViewController.h"
#import "BaseNetWorking.h"
#import "NSString+FilePath.h"
#import "UIButton+Category.h"

@interface NetWorkViewController ()
@property (nonatomic, strong) UIProgressView * prog;
@end

@implementation NetWorkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if (self.section == 0) {
        if (self.row == 0) {
            [self exampleUploadImage];
        } else if (self.row == 2) {
            [self exampleUploadOneFile];
        } else {
            UILabel * label     = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 300) / 2, (self.view.frame.size.height - 30) / 2, 300, 30)];
            label.text          = @"暂无服务器地址，无法测试";
            label.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:label];
        }

    } else {
        if (self.row == 0) {
            [self exampleDownloadOneFile];
        } else {
            [self exampleDownloadSomeFile];
        }
    }
}

- (void)exampleUploadImage
{
    [self.view addSubview:self.prog];

    UIImage * image = [UIImage imageNamed:@"navbgimg"];

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"上传图片" forState:UIControlStateNormal];
    [button addCallBackAction:^(UIButton * button) {
        [BaseNetWorking UploadImageWithUrl:@"https://wyaoa.ruishan666.com/uploadfile/upimg.json?action=uploadfile&encode=utf-8&code=xcx" params:nil Images:@[ image ] ImageNames:@[ @"navbgimg" ] ImageType:imageForPNG ImageCompressionRatio:0 progress:^(float progress) {
            NSLog(@"progress==%f", progress);
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.prog.progress = progress;
            });

        } Success:^(id data) {

            [self alertWithMessage:@"上传成功"];
        } Fail:^(NSString * errorDes) {

            [self alertWithMessage:errorDes];
        }];

    }];
    button.frame = CGRectMake((self.view.frame.size.width - 100) / 2, (self.view.frame.size.height - 50) / 2, 100, 30);
    [button setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button];
}

- (void)exampleUploadOneFile
{
    [self.view addSubview:self.prog];

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"上传文件" forState:UIControlStateNormal];
    [button addCallBackAction:^(UIButton * button) {

        NSString * path = [[NSBundle mainBundle] pathForResource:@"git操作" ofType:@"pages" inDirectory:nil];
        [BaseNetWorking UploadFileWithUrl:@"https://wyaoa.ruishan666.com/uploadfile/upimg.json?action=uploadfile&encode=utf-8&code=xcx" Params:nil FilePaths:@[ path ] FileNames:@[ @"git操作" ] progress:^(float progress) {
            NSLog(@"progress==%f", progress);
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.prog.progress = progress;
            });
        } Success:^(id data) {
            [self alertWithMessage:@"上传成功"];
        } Fail:^(NSString * errorDes) {
            [self alertWithMessage:errorDes];
        }];
    }];
    button.frame = CGRectMake((self.view.frame.size.width - 100) / 2, (self.view.frame.size.height - 50) / 2, 100, 30);
    [button setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button];
}

- (void)exampleDownloadOneFile
{
    NSString * string = [[NSString docPath] stringByAppendingPathComponent:@"aaa.mp4"];
    NSLog(@"string-==%@", string);
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"下载" forState:UIControlStateNormal];
    [button addCallBackAction:^(UIButton * button) {
        [BaseNetWorking DownloadFileWithUrl:@"" Params:nil FilePath:string progress:^(float progress) {
            NSLog(@"progress==%f", progress);
        } Success:^(id data) {
            NSLog(@"成功");
        } Fail:^(NSString * errorDes) {
            NSLog(@"失败==%@", errorDes);
        }];
    }];
    button.frame = CGRectMake((self.view.frame.size.width - 50) / 2, (self.view.frame.size.height - 50) / 2, 50, 30);
    [button setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button];
}

- (void)exampleDownloadSomeFile
{
}

- (void)alertWithMessage:(NSString *)message
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction  = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIProgressView *)prog
{
    if (!_prog) {
        _prog                   = [[UIProgressView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200) / 2, self.view.frame.size.height / 2 - 60, 200, 30)];
        _prog.progressTintColor = [UIColor redColor];
        //        _prog.trackTintColor = [UIColor grayColor];
    }
    return _prog;
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
