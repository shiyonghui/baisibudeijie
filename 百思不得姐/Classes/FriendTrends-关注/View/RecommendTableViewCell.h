//
//  RecommendTableViewCell.h
//  
//
//  Created by 施永辉 on 16/4/22.
//
//

#import <UIKit/UIKit.h>
@class RecommendModel;
@interface RecommendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *UIViewid;
@property (nonatomic,strong) RecommendModel * model;
@end
