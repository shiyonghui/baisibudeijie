//
//  AddTagToolBarController.m
//  百思不得姐
//
//  Created by 施永辉 on 16/5/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AddTagToolBarController.h"
#import "TagButton.h"
#import <SVProgressHUD.h>
@interface AddTagToolBarController ()<UITextFieldDelegate>
@property (nonatomic,strong)UIView * contentView;
@property (nonatomic,strong)UITextField * textField;//文本输入框
@property (nonatomic,strong)UIButton * addbutton;//添加标签按钮
@property (nonatomic,strong)NSMutableArray * tagButtons;
@end

@implementation AddTagToolBarController

- (UIButton *)addbutton
{
    if (!_addbutton) {
        UIButton * addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.width = self.contentView.width;
        addButton.height = 35;
        addButton.backgroundColor = [UIColor blueColor];
        [addButton addTarget:self action:@selector(addbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, TagMargin, 0, TagMargin);
        //让按钮内部的文字和图片都左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:addButton];
        _addbutton = addButton;
    }
    return _addbutton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setnaV];
    
    [self setupContentView];
    [self setupTextFiled];
    [self setupTags];
}
- (void)setupTags
{
    for (NSString * tag in self.tags) {
        self.textField.text = tag;
        [self addbuttonClick];
    }
}
-(NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}
- (void)setupContentView
{
    UIView * contentView = [[UIView alloc]init];
    contentView.x = TagMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.y =64 + TagMargin;
    contentView.height = self.view.height;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}
- (void)setupTextFiled
{
    UITextField * textField = [[UITextField alloc]init];
    textField.placeholder = @"多个标签用逗号或换行隔开";
    textField.height = 25;
    textField.width = kWindowWidth;
    textField.delegate = self;
    [textField becomeFirstResponder];
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [_contentView addSubview:textField];
    self.textField = textField;

}
- (void)setnaV
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}
- (void)done
{
    //传递tags block
    NSArray * tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    
    !self.tagsBlock ? : self.tagsBlock(tags);
    [self.navigationController popViewControllerAnimated:YES];
    
}

//监听文字改变
- (void)textDidChange
{

    if (self.textField.hasText) {//有文字 显示添加标签按钮按钮
      
        self.addbutton.hidden = NO;
        self.addbutton.y = CGRectGetMaxY(self.textField.frame) + TagMargin;
        [self.addbutton setTitle:[NSString stringWithFormat:@"添加标签：%@",self.textField.text] forState:UIControlStateNormal];
        //获得最后一个字符
        NSString * text = self.textField.text;
        NSUInteger len = text.length;
      NSString * lastLatter = [self.textField.text substringFromIndex:len -1];
        if ([lastLatter isEqualToString:@"," ]|| [lastLatter isEqualToString:@"，"]) {
            //除去逗号
            self.textField.text = [text substringToIndex:len-1];
            [self addbuttonClick];
        }
    }else{
        //没文字  隐藏添加标签按钮按钮
        self.addbutton.hidden = NO;
      
    }
    //更新标签和文本框的frame
    [self updateTagButtonFrame];
}
//监听添加标签按钮点击
- (void)addbuttonClick
{
    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多只能添加5个"];
        return;
    }
    //添加一个标签按钮
    TagButton * tagButton = [TagButton buttonWithType:UIButtonTypeCustom];
   
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
   
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    
    
    
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    
    //更新标签frame
    [self updateTagButtonFrame];
    //清空textField文字
    self.textField.text = nil;
    self.addbutton.hidden = YES;
}
//专门用来更新标签按钮的frame
- (void)updateTagButtonFrame
{
    
    for (int i = 0; i<self.tagButtons.count; i++) {
        TagButton * tagButton = self.tagButtons[i];
        if (i == 0) {//最前面的标签按钮
            
            tagButton.x = 0;
            tagButton.y = 0;
        }else{//其他标签按钮
          
            TagButton * lastTagButton = self.tagButtons[i-1];
            //计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + TagMargin;
            
            //计算当前右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagButton.width)
            {//按钮显示在当前行
                tagButton.y =lastTagButton.y;
                tagButton.x = leftWidth;
            }else
            {//按钮显示在下一行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + TagMargin;
                
            }
        }
    }
    //最后一个标签按钮
    TagButton * lastTagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + TagMargin;
    //更新textField的frame
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.y = lastTagButton.y;
        self.textField.x = leftWidth;
    }else{
    self.textField.x = 0;
    self.textField.y = CGRectGetMaxY(lastTagButton.frame) +TagMargin;
    }
}
//标签按钮的点击
- (void)tagButtonClick:(TagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    //重新更新所有标签按钮
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
    }];
    
}
//textField的文字宽度
- (CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textW);
}
#pragma mark --- <UITextFieldDelegate>
//监听键盘最右下角点击 return key
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.hasText) {
        [self addbuttonClick];
    }
    return YES;
}

@end
