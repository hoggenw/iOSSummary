//
//  ShowInfoTableViewCell.m
//  iOSProject
//
//  Created by 王留根 on 2019/4/16.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "ShowInfoTableViewCell.h"
#import "ShowMessageModel.h"

@interface ShowInfoTableViewCell ()<UITextViewDelegate>
@property (nonatomic , strong) UIImageView *leadImageView;
@property (nonatomic , strong) UILabel *desLable;
@end

@implementation ShowInfoTableViewCell

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
    
    static NSString * const identifier = @"ShowInfoTableViewCell";
    ShowInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        // 代码创建
        cell=  [ShowInfoTableViewCell new];
        
    }
//    [cell addLineWithSide: LineViewSideInBottom lineColor: [UIColor lightGrayColor] lineHeight: 0.5 leftMargin:10 rightMargin:10];
//    cell.backgroundColor = [UIColor colorWithHexString:@"f3f4f5"];
    return cell;
}

-(void)setModel:(ShowMessageModel *)model {
    _model = model;
    if (model.showType == TextType) {
        [self.desLable setHidden: false];
         self.desLable.attributedText = [self stringWithcontentString: model.content boldString: model.boldString];
        [self.imageView setHidden: true];
    }else if (model.showType == ImageType){
         [self.desLable setHidden: true];
        [self.imageView setHidden: false];
        self.imageView.image = model.image;
    }
   
    
}

- (NSAttributedString *)stringWithcontentString:(NSString *) contentString  boldString:(NSString *)boldString{
    // 创建一个富文
    NSRange range = [contentString rangeOfString:boldString];
    
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString: contentString];
    // 修改富文本中的不同文字的样式
    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"666666"] range:NSMakeRange(0, contentString.length)];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize: 14] range:NSMakeRange(0, contentString.length)];
    
    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"3333333"] range:range];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize: 16] range:range];
    
    return attriStr;
}

-(UIImageView *)leadImageView{
    if(_leadImageView == nil){
        _leadImageView = [UIImageView new];
        [self addSubview:_leadImageView];
        [_leadImageView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.edges.equalTo(self.contentView);
         }];
    }
    
    return _leadImageView;
    
}

-(UILabel *)desLable{
    if (!_desLable) {
        UILabel * desTextView = [UILabel new];
        
        desTextView.font = [UIFont systemFontOfSize: 14];
        desTextView.textColor = [UIColor colorWithHexString:@"666666"];
        desTextView.numberOfLines = 0;
//        desTextView.delegate = self;
//        desTextView.returnKeyType = UIReturnKeyDone;
        [self.contentView addSubview: desTextView];
        [desTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        _desLable = desTextView;
        
    }
    return  _desLable;
}


@end
