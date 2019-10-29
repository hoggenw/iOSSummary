//
//  DefaultTableViewCell.m
//  iOSProject
//
//  Created by 王留根 on 2018/11/19.
//  Copyright © 2018年 hoggenWang.com. All rights reserved.
//

#import "DefaultTableViewCell.h"

@interface DefaultTableViewCell()

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UIImageView *leadImageView;
@property (nonatomic , strong) UILabel *desLabel;

@end

@implementation DefaultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 便利构造
+ (instancetype)cellInTableView:(UITableView *)tableView
{
    // 重用机制
    
    static NSString * const identifier = @"DefaultTableViewCell";
    DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        // 代码创建
        cell=  [DefaultTableViewCell new];
        
    }
    [cell addLineWithSide: LineViewSideInBottom lineColor: [UIColor lightGrayColor] lineHeight: 0.5 leftMargin:10 rightMargin:10];
    cell.backgroundColor = [UIColor colorWithHexString:@"f3f4f5"];
    return cell;
}

-(void)setModel:(DefualtCellModel *)model {
      self.accessoryType = model.cellAccessoryType;
    if (model.leadImageName.length  > 0) {
        self.leadImageView.image = [UIImage imageNamed: model.leadImageName];
    }else{
        [self.leadImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(0));
        }];
    }
    
    self.titleLabel.text = model.title;
    self.desLabel.text = model.desc;
    
}

-(UIImageView *)leadImageView{
    if(_leadImageView == nil){
        _leadImageView = [UIImageView new];
        [self addSubview:_leadImageView];
        [_leadImageView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.equalTo(self.contentView).with.offset(16);
             make.centerY.equalTo(self.contentView);
             make.width.mas_equalTo(25);
             make.height.mas_equalTo(25);
         }];
    }
    
    return _leadImageView;
        
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel * label = [UILabel new];
        label.font = [UIFont systemFontOfSize: 15];
        label.textColor = [UIColor colorWithHexString:@"333333"];
        [self.contentView addSubview: label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leadImageView.mas_right).offset(10);
            make.width.lessThanOrEqualTo(@(120));
            make.centerY.equalTo(self.contentView);
        }];
        _titleLabel = label;
        
    }
    return  _titleLabel;
}

-(UILabel *)desLabel {
    if (!_desLabel) {
        UILabel * label = [UILabel new];
        label.font = [UIFont systemFontOfSize: 15];
        label.textColor = [UIColor colorWithHexString:@"333333"];
        [self.contentView addSubview: label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.centerY.equalTo(self.contentView);
        }];
        _desLabel = label;
        
    }
    return  _desLabel;
}

@end
