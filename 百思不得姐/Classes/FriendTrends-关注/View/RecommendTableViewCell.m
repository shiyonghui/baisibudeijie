//
//  RecommendTableViewCell.m
//  
//
//  Created by 施永辉 on 16/4/22.
//
//

#import "RecommendTableViewCell.h"
#import "RecommendModel.h"
@implementation RecommendTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = GlobalBg;
    self.label.textColor = RGBColor(78, 78, 78);
    self.label.highlightedTextColor = RGBColor(219, 21, 26);
    UIView * bg = [[UIView alloc]init];
    bg.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = bg;
}


-(void)setModel:(RecommendModel *)model
{
    _model = model;
    self.label.text =model.name;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //重新调整内部textlabel的frame
    self.textLabel.y =2;
    self.textLabel.height = self.contentView.height-2 * self.textLabel.y;
}
//可以在这个方法中监听cell的选中和取消选中
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.UIViewid.hidden = !selected;
}
@end
