//
//  LoginRegistViewController.m
//  百思不得姐
//
//  Created by 施永辉 on 16/4/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LoginRegistViewController.h"

@interface LoginRegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
//登录框距离左边的距离
@property (weak, nonatomic) IBOutlet UIView *registerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation LoginRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //文字属性
//    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//   //NSAttributedString： 带有属性的文字（富文本）
//    NSAttributedString * placeholder = [[NSAttributedString alloc]initWithString:@"手机号" attributes:attrs];
//    self.phoneText.attributedPlaceholder = placeholder;
    
//    NSMutableAttributedString * placeholder = [[NSMutableAttributedString alloc]initWithString:@"手机号"];
//    [placeholder setAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]} range:NSMakeRange(1, 1)];
//    self.phoneText.attributedPlaceholder = placeholder;
     
    
    
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showRegister:(UIButton *)sender{
    //退出键盘
    [self.view endEditing:YES];
    if(self.loginViewLeftMargin.constant == 0){
        //显示注册界面
        self.loginViewLeftMargin.constant = - self.view.width;
         self.registerView.hidden = NO;
        sender.selected = YES;
//        [sender setTitle:@"已有账号？" forState:UIControlStateNormal];
    }else{
        //显示登录界面
        self.registerView.hidden = YES;
        self.loginViewLeftMargin.constant = 0;
        sender.selected = NO;
//        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        //马上更新布局
        [self.view layoutIfNeeded];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//让当前控制器对应得状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
