//
//  OpenResultView.m
//  Selected
//
//  Created by lf on 2019/5/14.
//  Copyright © 2019 oops. All rights reserved.
//

#import "OpenResultView.h"
#import "Masonry.h"
#import "DCSpeedy.h"
#import "SinglopenResultView.h"
#import "OpenResultTableViewCell.h"
@interface OpenResultView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign)NSInteger index;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSTimer *timer;

@end

@implementation OpenResultView

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
    backimage.image = [UIImage imageNamed:@"开奖记录背景"];
    backimage.center = self.center;
    backimage.userInteractionEnabled = YES;
    [self addSubview:backimage];
    
    UIButton *closed = [[UIButton alloc] init];
    closed.backgroundColor = [UIColor clearColor];
//        [closed setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    
    [closed addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
    [backimage addSubview:closed];
    [closed  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backimage.mas_top).with.offset(18);
        make.left.equalTo(backimage.mas_right).with.offset(-22);
        make.bottom.equalTo(backimage.mas_top).with.offset(40);
        make.right.equalTo(backimage.mas_right).with.offset(0);
        
    }];
    
    
    
   
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(20,40, backimage.frame.size.width-40, backimage.frame.size.height-70) style:UITableViewStylePlain];
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
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"OpenResultTableViewCell";//以indexPath来唯一确定cell
    
    OpenResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[OpenResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text = @"开奖结果 中了5990000000";
//    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"?>>>>>>>>>>>>");
    SinglopenResultView *singl = [[SinglopenResultView alloc] initWithFrame:self.frame];
    [self addSubview:singl];
}




-(void)hideView{
    
    [self removeFromSuperview];
}
@end
