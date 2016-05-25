//
//  ShowPictureViewController.m
//  百思不得姐
//
//  Created by 施永辉 on 16/5/3.
//  Copyright © 2016年 mac. All rights reserved.
//
#import <UIImageView+WebCache.h>
#import "ShowPictureViewController.h"
#import "WordModel.h"
#import <SVProgressHUD.h>
#import <DALabeledCircularProgressView.h>
@interface ShowPictureViewController ()
@property (nonatomic,strong)UIImageView * imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation ShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加图片
    self.imageView = [[UIImageView alloc]init];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:self.imageView];
    //屏幕尺寸
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
   //显示宽度 xx
    //图片宽度 图片高度
    
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.model.height / self.model.width;
    
    if (pictureH > screenH){//图片显示高度超过一个屏幕
        //需要滚动查看
        self.imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
        self.imageView.size =  CGSizeMake(pictureW, pictureH);
        self.imageView.centerY = screenH * 0.5;
    }
        //马上显示当前图片的下载进度
//         [self.progressView setProgress:self.model.pictureProgress animated:NO];
        //下载图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.image2]placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = 1.0 * receivedSize / expectedSize ;
        
        [self.progressView setProgress:progress animated:NO];
     

    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
   }
- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片并没有下载完"];
        return;
    }
    //将我们图片存入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
@end
