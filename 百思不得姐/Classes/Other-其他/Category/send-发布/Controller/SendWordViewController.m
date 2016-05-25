//
//  SendWordViewController.m
//  百思不得姐
//
//  Created by 施永辉 on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SendWordViewController.h"
#import "PlaceholderTextView.h"
#import "AdTagTooBar.h"
@interface SendWordViewController ()<UITextViewDelegate>
@property (nonatomic,weak)PlaceholderTextView * textView;
@property (nonatomic,weak)AdTagTooBar * toolbar;
@end

@implementation SendWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextView];
    [self setupNav];
    [self setupToolBar];
}
- (void)setupToolBar
{
    AdTagTooBar * toolBar = [AdTagTooBar toolbar];
    toolBar.width = self.view.width;
    toolBar.y = kWindowHeight - toolBar.height;
   
    [self.view addSubview:toolBar];
    self.toolbar = toolBar;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
//监听键盘的弹出和隐藏
- (void)keyboarWillChangeFrame:(NSNotification *)note
{//键盘最终的frame
   CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0,keyboardF.origin.y - kWindowHeight);

    }];
   }
- (void)setupNav
{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}
- (void)setupTextView
{
    PlaceholderTextView * textView = [[PlaceholderTextView alloc]init];
    textView.frame =CGRectMake(0, 0, kWindowWidth, kWindowHeight);
   
    textView.placeholder = @"把好视频段子或者悲催的事情写出来，接受千万网友的膜拜吧！接受千万网友的膜拜吧！接受千万网友的膜拜吧！接受千万网友的膜拜吧！";
    textView.delegate = self;
    textView.placeholderColor = [UIColor redColor];
    [textView becomeFirstResponder];
//    textView.inputAccessoryView =[AdTagTooBar toolbar];//把tooBar添加到键盘上
    [self.view addSubview:textView];
    self.textView = textView;
}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)post
{
    
}
#pragma mark -- <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end
