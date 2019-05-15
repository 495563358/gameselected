//
//  PlayRullView.m
//  Selected
//
//  Created by lf on 2019/5/14.
//  Copyright © 2019 oops. All rights reserved.
//

#import "PlayRullView.h"
#import "Masonry.h"
#import "DCSpeedy.h"
@implementation PlayRullView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self crearPlayRulView];
    }
    return self;
}
-(void)crearPlayRulView
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
//    self.alpha = 0.6;
    
    UIImageView *backimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*325/375, self.frame.size.width*400/375)];
    backimage.image = [UIImage imageNamed:@"玩法说明-背景"];
    backimage.center = self.center;
    backimage.userInteractionEnabled = YES;
    [self addSubview:backimage];

    UIButton *closed = [[UIButton alloc] init];
    closed.backgroundColor = [UIColor clearColor];
    [closed setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];

    [closed addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
    [backimage addSubview:closed];
    [closed  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backimage.mas_top).with.offset(18);
        make.left.equalTo(backimage.mas_right).with.offset(-22);
        make.bottom.equalTo(backimage.mas_top).with.offset(40);
        make.right.equalTo(backimage.mas_right).with.offset(0);
        
    }];
    
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*325/375-40, self.frame.size.width*400/375-80)];
    scroll.center = self.center;
    scroll.bounces = NO;
    scroll.backgroundColor = [UIColor clearColor];
    [self addSubview:scroll];
    
    
    UIImageView *ltip1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"小标题BG"]];
    [scroll addSubview:ltip1];
    [ltip1  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(scroll.mas_top).with.offset(20);
            make.left.equalTo(backimage.mas_left).with.offset(37);
            make.bottom.equalTo(scroll.mas_top).with.offset(50);
            make.right.equalTo(backimage.mas_left).with.offset(174);
        }];
    UILabel *ltip1l = [[UILabel alloc] init];
    ltip1l.text = @"      开奖时间";
    [scroll addSubview:ltip1l];
    [ltip1l  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scroll.mas_top).with.offset(20);
        make.left.equalTo(backimage.mas_left).with.offset(37);
        make.bottom.equalTo(scroll.mas_top).with.offset(50);
        make.right.equalTo(backimage.mas_left).with.offset(174);
        
    }];
    UILabel *ltip1lcontent = [[UILabel alloc] init];
    NSString *str1 = @"内伶仃岛，是珠江三角洲当中的一座岛屿，原名伶仃山，名字释义为海上孤独的山，后为区别于外伶仃岛，内伶仃岛，是珠江三角洲当中的一座岛屿，原名伶仃山，内伶仃岛，是珠江三角洲当中的一座岛屿，原名伶仃山，名字释义为海上孤独的山，后为区别于外伶仃岛，内伶仃岛，是珠江三角洲当中的一座岛屿，原名伶仃山";
    ltip1lcontent.text = str1;
    [ltip1lcontent setFont:[UIFont systemFontOfSize:15]];
    ltip1lcontent.numberOfLines = 0;
    CGFloat textH1 = [DCSpeedy dc_calculateTextSizeWithText:str1 WithTextFont:15 WithMaxW:self.frame.size.width - 20].height;
    [scroll addSubview:ltip1lcontent];
    [ltip1lcontent  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ltip1l.mas_bottom).with.offset(20);
        make.left.equalTo(backimage.mas_left).with.offset(37);
        make.bottom.equalTo(ltip1l.mas_bottom).with.offset(textH1);
        make.right.equalTo(backimage.mas_right).with.offset(-37);
//        make.height.equalTo(10);
    }];
    
    
    
    UIImageView *ltip2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"小标题BG"]];
    [scroll addSubview:ltip2];
    [ltip2  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ltip1lcontent.mas_bottom).with.offset(20);
        make.left.equalTo(backimage.mas_left).with.offset(37);
        make.bottom.equalTo(ltip1lcontent.mas_bottom).with.offset(50);
        make.right.equalTo(backimage.mas_left).with.offset(174);
    }];
    UILabel *ltip2l = [[UILabel alloc] init];
    ltip2l.text = @"      玩法规则";
    [scroll addSubview:ltip2l];
    [ltip2l  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ltip1lcontent.mas_bottom).with.offset(20);
        make.left.equalTo(backimage.mas_left).with.offset(37);
        make.bottom.equalTo(ltip1lcontent.mas_bottom).with.offset(50);
        make.right.equalTo(backimage.mas_left).with.offset(174);

    }];
    UILabel *ltip2lcontent = [[UILabel alloc] init];
    NSString *str2 = @"内伶仃岛曾是英国鸦片走私的基地。清朝道光朝以前，英国对华鸦片贸易主要在黄埔和澳门进行。1821年清廷下令驱逐鸦片船。此後，英国鸦片商便将走私活动改在虎门口外伶仃洋一带，设置鸦片趸船，冬季停泊在内伶仃岛附近，台风季节则移泊于金星门和香港水域。通常走私的办法是：先将鸦片从印度等地运来，卸进趸船，再由本地烟贩交钱提货，用叫做“快蟹”的小船偷运到珠江三角洲各地出售";
    ltip2lcontent.text = str2;
    [ltip2lcontent setFont:[UIFont systemFontOfSize:15]];
    ltip2lcontent.numberOfLines = 0;
    CGFloat textH2 = [DCSpeedy dc_calculateTextSizeWithText:str2 WithTextFont:15 WithMaxW:self.frame.size.width - 20].height;
    [scroll addSubview:ltip2lcontent];
    [ltip2lcontent  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ltip2l.mas_bottom).with.offset(20);
        make.left.equalTo(backimage.mas_left).with.offset(37);
        make.bottom.equalTo(ltip2l.mas_bottom).with.offset(textH2);
        make.right.equalTo(backimage.mas_right).with.offset(-37);

    }];

    
    
    
    
    
    UIImageView *ltip3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"小标题BG"]];
    [scroll addSubview:ltip3];
    [ltip3  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ltip2lcontent.mas_bottom).with.offset(20);
        make.left.equalTo(backimage.mas_left).with.offset(37);
        make.bottom.equalTo(ltip2lcontent.mas_bottom).with.offset(50);
        make.right.equalTo(backimage.mas_left).with.offset(174);
    }];
    UILabel *ltip3l = [[UILabel alloc] init];
    ltip3l.text = @"      牌型大小";
    [scroll addSubview:ltip3l];
    [ltip3l  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ltip2lcontent.mas_bottom).with.offset(20);
        make.left.equalTo(backimage.mas_left).with.offset(37);
        make.bottom.equalTo(ltip2lcontent.mas_bottom).with.offset(50);
        make.right.equalTo(backimage.mas_left).with.offset(174);
        
    }];
    UILabel *ltip3lcontent = [[UILabel alloc] init];
    NSString *str3 = @"内伶仃岛曾是英国鸦片走私的基地。清朝道光朝以前，英国对华鸦片贸易主要在黄埔和澳门进行。1821年清廷下令驱逐鸦片船。此後，英国鸦片商便将走私活动改在虎门口外伶仃洋一带，设置鸦片趸船，冬季停泊在内伶仃岛附近，台风季节则移泊于金星门和香港水域。通常走私的办法是：先将鸦片从印度等地运来，卸进趸船，再由本地烟贩交钱提货，用叫做“快蟹”的小船偷运到珠江三角洲各地出售";
    ltip3lcontent.text = str3;
    [ltip3lcontent setFont:[UIFont systemFontOfSize:15]];
    ltip3lcontent.numberOfLines = 0;
     CGFloat textH3 = [DCSpeedy dc_calculateTextSizeWithText:str3 WithTextFont:15 WithMaxW:self.frame.size.width - 20].height;
    [scroll addSubview:ltip3lcontent];
    [ltip3lcontent  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ltip3l.mas_bottom).with.offset(20);
        make.left.equalTo(backimage.mas_left).with.offset(37);
        make.bottom.equalTo(scroll.mas_bottom).with.offset(textH1+textH2+textH3+190);
        make.right.equalTo(backimage.mas_right).with.offset(-37);
        
    }];
    
    scroll.contentSize = CGSizeMake(0, (textH1+textH2+textH3+190));
    
    
}

-(void)hideView{
    [self removeFromSuperview];
}
@end
