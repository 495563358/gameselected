//
//  PaiHangView.m
//  Selected
//
//  Created by lf on 2019/5/14.
//  Copyright © 2019 oops. All rights reserved.
//

#import "PaiHangView.h"
#import "Masonry.h"
#import "DCSpeedy.h"
@interface PaiHangView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign)NSInteger index;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSTimer *timer;
@end
@implementation PaiHangView

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
    UIImageView *backimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*325/375, self.frame.size.width*400/375)];
    backimage.image = [UIImage imageNamed:@"在线排行-BG"];
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
    
    
    
    UILabel *paihang = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backimage.frame.size.width/3, 30)];
    paihang.center = CGPointMake(backimage.frame.size.width/6, 70);
    paihang.text = @"排行";
    paihang.font =  [UIFont fontWithName:@"STYuanti-SC-Bold" size:20];
    paihang.textAlignment = NSTextAlignmentCenter;
    [backimage addSubview:paihang];
    
    
    
    
    UILabel *wanjia = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backimage.frame.size.width/3, 30)];
    wanjia.center = CGPointMake(self.frame.size.width/2, 70);
    wanjia.text = @"玩家";
    wanjia.font =  [UIFont fontWithName:@"STYuanti-SC-Bold" size:20];
    wanjia.textAlignment = NSTextAlignmentLeft;
    [backimage addSubview:wanjia];
    
    
    UILabel *nea = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backimage.frame.size.width/3, 30)];
    nea.center = CGPointMake(self.frame.size.width/6.5*5, 70);
    nea.text = @"近20局";
    nea.font =  [UIFont fontWithName:@"STYuanti-SC-Bold" size:20];
    nea.textAlignment = NSTextAlignmentLeft;
    [backimage addSubview:nea];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(20,70, backimage.frame.size.width-40, backimage.frame.size.height-70) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.userInteractionEnabled = YES;
    //    _tableView.backgroundColor = SystemColor;
    
    [backimage addSubview:_tableView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"RedPocketDetailCell";//以indexPath来唯一确定cell
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"玩家排行";
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}

-(void)hideView{
    
    [self removeFromSuperview];
}
@end
