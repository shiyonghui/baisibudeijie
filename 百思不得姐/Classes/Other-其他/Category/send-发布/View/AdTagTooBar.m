//
//  AdTagTooBar.m
//  百思不得姐
//
//  Created by 施永辉 on 16/5/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AdTagTooBar.h"
#import "AddTagToolBarController.h"

@interface AdTagTooBar ()
//顶部控件
@property (weak, nonatomic) IBOutlet UIView *topView;
//存放所有的标签label
@property (nonatomic,strong)NSMutableArray * tagLabels;
//添加按钮
@property (weak, nonatomic)  UIButton *addButton;
@end


@implementation AdTagTooBar

+ (instancetype)toolbar
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}
- (void)awakeFromNib
{
    //添加一个加号按钮
    UIButton * addButton = [[UIButton alloc]init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_iconN_57x32_@1x"] forState:UIControlStateNormal];
    addButton.size = addButton.currentImage.size;
    addButton.x = TagMargin;
    [self.topView addSubview:addButton];
    self.addButton = addButton;
    //默认拥有两个标签
    [self createTages:@[@"吐槽",@"糗事"]];
}
- (void)addButtonClick
{
    AddTagToolBarController * adVC = [[AddTagToolBarController alloc]init];
    __weak typeof (self) weakSelf = self;
    [adVC setTagsBlock:^(NSArray * tags) {
        [weakSelf createTages:tags];
    }];
    adVC.tags = [self.tagLabels valueForKeyPath:@"text"];
    UIViewController * root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController * naV = (UINavigationController *)root.presentedViewController;

    [naV pushViewController:adVC animated:YES];
}
//创建标签
- (void)createTages:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    for (int i = 0;  i <tags.count; i ++) {
        UILabel * tagsLabel = [[UILabel alloc]init];
        [self.tagLabels addObject:tagsLabel];
        tagsLabel.backgroundColor = [UIColor blueColor];
        tagsLabel.text = tags[i];
        tagsLabel.textColor = [UIColor whiteColor];
        tagsLabel.textAlignment = NSTextAlignmentCenter;
        tagsLabel.font = [UIFont systemFontOfSize:14];
        [tagsLabel sizeToFit];
        
        tagsLabel.width  += 2 * TagMargin;
        tagsLabel.height = TagH;
        
        [self.topView addSubview:tagsLabel];
        //设置位置
        if (i == 0) {//最前面的标签按钮
            
            tagsLabel.x = 0;
            tagsLabel.y = 0;
        }else{//其他标签按钮
            
            UILabel * lastTagLabel = self.tagLabels[i-1];
            //计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + TagMargin;
            
            //计算当前右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagsLabel.width)
            {//按钮显示在当前行
                tagsLabel.y =lastTagLabel.y;
                tagsLabel.x = leftWidth;
            }else
            {//按钮显示在下一行
                tagsLabel.x = 0;
                tagsLabel.y = CGRectGetMaxY(lastTagLabel.frame) + TagMargin;
                
            }
        }
    }
    //最后一个标签按钮
    UILabel * lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + TagMargin;
    //更新textField的frame
    if (self.topView.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    }else{
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) +TagMargin;
    }

}
@end
