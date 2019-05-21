//
//  RecentlyCowResultView.m
//  Selected
//
//  Created by oops on 2019/5/17.
//  Copyright © 2019 oops. All rights reserved.
//

#import "RecentlyCowResultView.h"

@interface RecentlyCowResultView()

@property(nonatomic,strong)NSMutableArray<NSArray<UIView *> *> *resultViews;

@end

@implementation RecentlyCowResultView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }return self;
}

-(void)createUI{
    
    CGFloat startX = 21;
    CGFloat width = (ScreenWidth - 80)/4;
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new"]];
    image.center = CGPointMake(startX + width/2, 4);
    [self addSubview:image];
    
    self.resultViews = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        UIView *back = [[UIView alloc] initWithFrame:CGRectMake(21 + i * (width + 13), 8, width, 20)];
        NSMutableArray *arr = [NSMutableArray array];
        
        for (int j = 0; j < 3; j++) {
            UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"num2"]];
            img.center = CGPointMake(width/2 + 17 * (j - 1), 8);
            
            [back addSubview:img];
            [arr addObject:img];
        }
        [self addSubview:back];
        [self.resultViews addObject:arr];
    }
    
    
}

-(void)setRecentData:(NSArray *)arr{
    for (int i = 0 ; i < 4; i++) {
        NSArray *imgArrs = self.resultViews[i];
        NSArray *data = arr[i];
        for (int j = 0; j < 3; j++) {
            UIImageView *img = imgArrs[j];
            img.image = [UIImage imageNamed:[NSString stringWithFormat:@"num%@",data[j]]];
        }
    }
}

@end
