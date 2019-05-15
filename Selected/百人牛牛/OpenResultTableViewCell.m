//
//  OpenResultTableViewCell.m
//  Selected
//
//  Created by lf on 2019/5/14.
//  Copyright © 2019 oops. All rights reserved.
//

#import "OpenResultTableViewCell.h"
#import "Masonry.h"
#import "DCSpeedy.h"
@implementation OpenResultTableViewCell




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
//    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.gameNum = [[UILabel alloc] init];
    self.gameNum.text = @"2351局";
//    self.gameNum.font = [UIFont fontWithName:@"" size:10];
    self.gameNum.font = [UIFont systemFontOfSize:11];
    [self addSubview:self.gameNum];
    [self.gameNum  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(20);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.right.equalTo(self.mas_left).with.offset(70);
        
    }];
    
    self.zhuang = [[UILabel alloc] init];
    self.zhuang.text = @"庄（牛5）";
//    self.zhuang.font = [UIFont fontWithName:@"" size:10];
    self.zhuang.font = [UIFont systemFontOfSize:11];

    [self addSubview:self.zhuang];
    [self.zhuang  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.gameNum.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.right.equalTo(self.gameNum.mas_right).with.offset(60);
        
    }];
    
    
    self.xian1 = [[UILabel alloc] init];
    self.xian1.text = @"闲1（无牛）";
    //    self.zhuang.font = [UIFont fontWithName:@"" size:10];
    self.xian1.font = [UIFont systemFontOfSize:11];
    
    [self addSubview:self.xian1];
    [self.xian1  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.zhuang.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.right.equalTo(self.zhuang.mas_right).with.offset(65);
        
    }];
    
    
    self.xian2 = [[UILabel alloc] init];
    self.xian2.text = @"闲2（无牛）";
    //    self.zhuang.font = [UIFont fontWithName:@"" size:10];
    self.xian2.font = [UIFont systemFontOfSize:11];
    
    [self addSubview:self.xian2];
    [self.xian2  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.xian1.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.right.equalTo(self.xian1.mas_right).with.offset(65);
        
    }];
    
    
    
    self.xian3 = [[UILabel alloc] init];
    self.xian3.text = @"闲3（无牛）";
    //    self.zhuang.font = [UIFont fontWithName:@"" size:10];
    self.xian3.font = [UIFont systemFontOfSize:11];
    
    [self addSubview:self.xian3];
    [self.xian3  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.xian2.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.right.equalTo(self.xian2.mas_right).with.offset(65);
        
    }];
    
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
