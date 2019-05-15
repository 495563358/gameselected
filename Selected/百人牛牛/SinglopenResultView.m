//
//  SinglopenResultView.m
//  Selected
//
//  Created by lf on 2019/5/14.
//  Copyright © 2019 oops. All rights reserved.
//

#import "SinglopenResultView.h"
#import "Masonry.h"
#import "DCSpeedy.h"
@implementation SinglopenResultView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self craetOpenResultView];
    }
    return self;
}
-(void)craetOpenResultView
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    UIImageView *backimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*325/425, self.frame.size.width*325/418)];
    backimage.image = [UIImage imageNamed:@"--牛牛弹窗"];
    backimage.center = self.center;
    backimage.userInteractionEnabled = YES;
    [self addSubview:backimage];
    
    UIButton *closed = [[UIButton alloc] init];
    closed.backgroundColor = [UIColor clearColor];
    [closed setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    
    [closed addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
    [backimage addSubview:closed];
    [closed  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backimage.mas_top).with.offset(-15);
        make.left.equalTo(backimage.mas_right).with.offset(-15);
        make.bottom.equalTo(backimage.mas_top).with.offset(15);
        make.right.equalTo(backimage.mas_right).with.offset(15);
        
    }];
}




-(void)hideView{
    
    [self removeFromSuperview];
}
@end
