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
//    scroll.alwaysBounceVertical = YES;
//    scroll.alwaysBounceHorizontal = YES;
    [self addSubview:scroll];
    
    UIImageView *ltip1 =[[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 140, 30)];
    ltip1.image = [UIImage imageNamed:@"小标题BG"];
    [scroll addSubview:ltip1];

    UILabel *ltip1l = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 140, 30)];
    ltip1l.text = @"开奖时间";
    ltip1l.textAlignment = NSTextAlignmentCenter;
    [scroll addSubview:ltip1l];

    UILabel *ltip1lcontent = [[UILabel alloc] init];
    NSString *str1 = @"内伶仃岛，是珠江三角洲当中的一座岛屿，原名伶仃山，名字释义为海上孤独的山，后为区别于外伶仃岛，内伶仃岛，是珠江三角洲当中的一座岛屿，原名伶仃山，内伶仃岛，是珠江三角洲当中的一座岛屿，原名伶仃山，名字释义为海上孤独的山，后为区别于外伶仃岛，内伶仃岛，是珠江三角洲当中的一座岛屿，原名伶仃山2333333";
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:str1];
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:6];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str1 length])];
    
    ltip1lcontent.attributedText = attributedString1;
    [ltip1lcontent setFont:[UIFont systemFontOfSize:15]];
    ltip1lcontent.numberOfLines = 0;
    CGFloat textH1 = [DCSpeedy dc_calculateTextSizeWithText:str1 WithTextFont:15 WithMaxW:scroll.frame.size.width - 50].height;
    ltip1lcontent.frame = CGRectMake(30, ltip1l.frame.size.height+30, scroll.frame.size.width - 50, textH1);
    [scroll addSubview:ltip1lcontent];


    UIImageView *ltip2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, ltip1l.frame.size.height+30+textH1+20+10, 140, 30)];
    ltip2.image = [UIImage imageNamed:@"小标题BG"];
    [scroll addSubview:ltip2];

    UILabel *ltip2l = [[UILabel alloc] initWithFrame:CGRectMake(30, ltip1l.frame.size.height+30+textH1+20+10, 140, 30)];
    ltip2l.text = @"玩法规则";
    ltip2l.textAlignment = NSTextAlignmentCenter;
    [scroll addSubview:ltip2l];

    UILabel *ltip2lcontent = [[UILabel alloc] init];
    NSString *str2 = @"内伶仃岛曾是英国鸦片走私的基地。清朝道光朝以前，英国对华鸦片贸易主要在黄埔和澳门进行。1821年清廷下令驱逐鸦片船。此後，英国鸦片商便将走私活动改在虎门口外伶仃洋一带，设置鸦片趸船，冬季停泊在内伶仃岛附近，台风季节则移泊于金星门和香港水域。通常走私的办法是：先将鸦片从印度等地运来，卸进趸船，再由本地烟贩交钱提货，用叫做“快蟹”的小船偷运到珠江三角洲各地出售";
//    ltip2lcontent.text = str2;
   
    CGFloat textH2 = [DCSpeedy dc_calculateTextSizeWithText:str2 WithTextFont:15 WithMaxW:scroll.frame.size.width - 50].height;
    ltip2lcontent.frame = CGRectMake(30, ltip1l.frame.size.height+textH1+100, scroll.frame.size.width - 50, textH2);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str2];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str2 length])];
    [ltip2lcontent setFont:[UIFont systemFontOfSize:15]];
    ltip2lcontent.numberOfLines = 0;
    ltip2lcontent.attributedText = attributedString;
    [scroll addSubview:ltip2lcontent];
   



    UIImageView *ltip3 = [[UIImageView alloc] initWithFrame:CGRectMake(30, ltip1l.frame.size.height+textH1+textH2+120, 140, 30)];
    ltip3.image = [UIImage imageNamed:@"小标题BG"];
    [scroll addSubview:ltip3];
   
    UILabel *ltip3l = [[UILabel alloc] initWithFrame:CGRectMake(30, ltip1l.frame.size.height+textH1+textH2+120, 140, 30)];
    ltip3l.text = @"牌型大小";
    ltip3l.textAlignment = NSTextAlignmentCenter;
    [scroll addSubview:ltip3l];
 
    
    
    UILabel *ltip3lcontent = [[UILabel alloc] init];
    NSString *str3 = @"内伶仃岛曾是英国鸦片走私的基地。清朝道光朝以前，英国对华鸦片贸易主要在黄埔和澳门进行。1821年清廷下令驱逐鸦片船。此後，英国鸦片商便将走私活动改在虎门口外伶仃洋一带，设置鸦片趸船，冬季停泊在内伶仃岛附近，台风季节则移泊于金星门和香港水域。通常走私的办法是：先将鸦片从印度等地运来，卸进趸船，再由本地烟贩交钱提货，用叫做“快蟹”的小船偷运到珠江三角洲各地出售233";
    
    [ltip3lcontent setFont:[UIFont systemFontOfSize:15]];
    ltip3lcontent.numberOfLines = 0;
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:str3];
    NSMutableParagraphStyle *paragraphStyle3 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle3 setLineSpacing:6];
   
    [attributedString3 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle3 range:NSMakeRange(0, [str3 length])];
     ltip3lcontent.attributedText = attributedString3;
     CGFloat textH3 = [DCSpeedy dc_calculateTextSizeWithText:str3 WithTextFont:15 WithMaxW: scroll.frame.size.width - 50].height;
     ltip3lcontent.frame = CGRectMake(30, textH1+textH2+190, scroll.frame.size.width - 50, textH3);
    [scroll addSubview:ltip3lcontent];
   

    
    scroll.contentSize = CGSizeMake(0, (textH1+textH2+190+textH3));
    
}

-(void)hideView{
    
    [self removeFromSuperview];
}
@end
