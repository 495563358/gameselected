//
//  MyScence.m
//  Selected
//
//  Created by oops on 2019/4/20.
//  Copyright © 2019 oops. All rights reserved.
//

#import "MyScence.h"

#import "PlayRullView.h"
#import "OpenResultView.h"
#import "PaiHangView.h"
#import "BetResultView.h"

@interface MyScence(){
    BOOL isChipSprite;
    CGFloat _oldChipX;
    
    NSArray *_imageNameArr;
    
    int timeCount;
}
@property (nonatomic,strong)UILabel *gameIssueLab;//游戏当前局数
@property (nonatomic,strong)UILabel *betStatusLab;//投注当前状态
@property (nonatomic,strong)UILabel *betTimeLab;//投注剩余时间

@property(nonatomic,strong)SKSpriteNode *background;
@property(nonatomic,strong)SKSpriteNode *moreSettingSprite;//更多设置
@property(nonatomic,strong)STControlSprite *onlineUser;
@property(nonatomic,strong)SKSpriteNode *chipView;//筹码
@property(nonatomic,strong)SKSpriteNode *selectedChip;//筹码
@property(nonatomic,strong)NSMutableArray<NSMutableArray<SKSpriteNode *> *> *cardArr;//牌
@property(nonatomic,strong)NSMutableArray<STControlSprite *> *deskSpriteArr;//下注的桌子
@property(nonatomic,strong)NSMutableArray<SKSpriteNode *> *chipSpriteArr;//下注可以点击的筹码
@property(nonatomic,strong)NSMutableArray<NSMutableArray<SKSpriteNode *> *> *moneySpriteArr;//洒出来的筹码
@property(nonatomic,strong)NSMutableArray<SKLabelNode *> *countLabelArr;//洒出来的筹码


@property (nonatomic,strong)YYTimer *countTimer;

/*
 将自动撒的筹码 和 用户手动投注的筹码 加入数组 命名规则:desk + i
 */

@end

@implementation MyScence

-(void)didMoveToView:(SKView *)view{
    NSLog(@"didMoveToView = %@",view);
    
    _imageNameArr = @[@"ship1",@"ship5",@"ship10",@"ship50",@"ship100",@"ship500",@"ship1000",@"ship5000",@"ship10000"];
    [self createUI];
    
    [self sendCard];
    
    timeCount = 30;
//    self.countTimer = [[YYTimer alloc] initWithFireTime:0 interval:1 target:self selector:@selector(timeCountDown) repeats:YES];
}

-(void)timeCountDown{
    
    self.betTimeLab.text = [NSString stringWithFormat:@"%i",timeCount];
    //开始下注提示
    if (timeCount == 30) {
        [self startBetAnimation];
    }
    //自动撒币到投注时间结束
    else if (timeCount > 15 && timeCount < 30){
        [self sendChipToDesk];
        //第18秒开始结束动画
        if (timeCount == 18) {
            [self countdownAnimation];
        }
    }
    //15秒开始开牌
    else if (timeCount == 14){
        self.betStatusLab.text = @"开奖中";
        [self openCard:1 andResult:@[@"1",@"2",@"3",@"4",@"5"]];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self openCard:2 andResult:@[@"1",@"2",@"3",@"4",@"5"]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self openCard:3 andResult:@[@"1",@"2",@"3",@"4",@"5"]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(3*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self openCard:0 andResult:@[@"1",@"2",@"3",@"4",@"5"]];
        });
    }else if (timeCount < 12 && timeCount > 0){
        //胜利区域出现“胜利特效”
        if (timeCount == 11) {
            [self deskShowWin:@[@1,@3,@5]];
        }
        //未压中区域筹码飞向庄位置
        else if (timeCount == 10){
            [self cleanAllChipAndsendToWinDesk:@[@1,@3,@5]];
        }
        //倒计时1s时牌恢复为关牌状态
        else if (timeCount == 1){
            [self closeAllCard];
        }
    }else if (timeCount == 0){
        timeCount = 31;
    }
    timeCount --;
    
}




-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    // Setup your scene here
    //背景
    self.background  = [SKSpriteNode spriteNodeWithImageNamed:@"图层-1021-拷贝"];
    _background.position = self.view.center;
    _background.size = self.view.frame.size;
    [self addChild:_background];
    
    CGFloat backSpriteCenterY = self.view.frame.size.height - kStatusBarHeight - 20;
    STControlSprite *backSprite = [STControlSprite spriteNodeWithImageNamed:@"返回"];
    backSprite.position = CGPointMake(40, backSpriteCenterY);
    backSprite.size = CGSizeMake(36, 36);
    backSprite.name = @"back";
    [backSprite setTouchUpInsideBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"exitgame" object:nil];
    }];
    [self addChild:backSprite];
    
    //局数
    UIButton *gameIssueView = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/5.5, kStatusBarHeight + 5, ScreenWidth/4, 26)];
    gameIssueView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    gameIssueView.layer.cornerRadius = 13;
    gameIssueView.layer.masksToBounds = YES;
    [gameIssueView addTarget:self action:@selector(showOpenResultView) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *gameIssueIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"-局-图标"]];
    [gameIssueView addSubview:gameIssueIcon];
    
    UIImageView *gameIssueUp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"矢量智能对象"]];
    gameIssueUp.frame = CGRectMake(ScreenWidth/4 - 15, 9, 10, 8);
    [gameIssueView addSubview:gameIssueUp];
    
    self.gameIssueLab = [UILabel labelWithText:@"082311" fontSize:13 frame:CGRectMake(5, 0, ScreenWidth/4, 26) color:[UIColor whiteColor] textAlignment:1];
    [gameIssueView addSubview:_gameIssueLab];
    
    [self.view addSubview:gameIssueView];
    
    //游戏状态
    UIButton *gameStatusView = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - ScreenWidth/5.5 - ScreenWidth/4, kStatusBarHeight + 5, ScreenWidth/4, 26)];
    gameStatusView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    gameStatusView.layer.cornerRadius = 13;
    gameStatusView.layer.masksToBounds = YES;
    [gameStatusView addTarget:self action:@selector(betResultView) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *gameStatusUp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"矢量智能对象"]];
    gameStatusUp.frame = CGRectMake(5, 9, 10, 8);
    [gameStatusView addSubview:gameStatusUp];
    
    self.betStatusLab = [UILabel labelWithText:@"投注中" fontSize:13 frame:CGRectMake(0, 0, ScreenWidth/4, 26) color:[UIColor whiteColor] textAlignment:1];
    [gameStatusView addSubview:_betStatusLab];
    
    UIImageView *gameStatusIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"闹钟"]];
    gameStatusIcon.frame = CGRectMake(gameStatusView.frame.origin.x + ScreenWidth/4 - 22, gameStatusView.frame.origin.y-2, 26, 30);
    self.betTimeLab = [UILabel labelWithText:@"30" fontSize:12 frame:CGRectMake(0, 0, 26, 30) color:[UIColor blackColor] textAlignment:1];
    [gameStatusIcon addSubview:_betTimeLab];
    [self.view addSubview:gameStatusView];
    [self.view addSubview:gameStatusIcon];
    
    //庄
    STControlSprite *zhuang = [STControlSprite spriteNodeWithImageNamed:@"庄"];
    zhuang.size = CGSizeMake(30, 30);
    zhuang.position = CGPointMake(ScreenWidth/2, backSpriteCenterY);
    [zhuang setTouchUpInsideBlock:^{
        [self openCard:1 andResult:@[@"1",@"2",@"3",@"4",@"5"]];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self openCard:2 andResult:@[@"1",@"2",@"3",@"4",@"5"]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self openCard:3 andResult:@[@"1",@"2",@"3",@"4",@"5"]];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(3*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self openCard:0 andResult:@[@"1",@"2",@"3",@"4",@"5"]];
        });
    }];
    [self addChild:zhuang];
    
    SKSpriteNode *moreSprite = [SKSpriteNode spriteNodeWithImageNamed:@"更多"];
    moreSprite.position = CGPointMake(ScreenWidth - 40, backSpriteCenterY);
    moreSprite.size = CGSizeMake(36, 36);
    moreSprite.name = @"more";
    [self addChild:moreSprite];
    
    //_庄
    STControlSprite *_zhuang = [STControlSprite spriteNodeWithImageNamed:@"--庄"];
    CGFloat startX = 21 + (ScreenWidth/4-20)/2;
    CGFloat spaceX = ScreenWidth/4 - 20 + 13;
    backSpriteCenterY -= 50;
    _zhuang.position = CGPointMake(startX, backSpriteCenterY);
    [self addChild:_zhuang];
    //闲1
    SKSpriteNode *_xian1 = [SKSpriteNode spriteNodeWithImageNamed:@"闲1"];
//    _xian1.size = CGSizeMake(80, 60);
    _xian1.position = CGPointMake(startX + spaceX, backSpriteCenterY);
    [self addChild:_xian1];
    //闲2
    SKSpriteNode *_xian2 = [SKSpriteNode spriteNodeWithImageNamed:@"闲2"];
//    _xian2.size = CGSizeMake(80, 60);
    _xian2.position = CGPointMake(startX + spaceX * 2, backSpriteCenterY);
    [self addChild:_xian2];
    //闲3
    SKSpriteNode *_xian3 = [SKSpriteNode spriteNodeWithImageNamed:@"闲3"];
//    _xian3.size = CGSizeMake(80, 60);
    _xian3.position = CGPointMake(startX + spaceX * 3, backSpriteCenterY);
    [self addChild:_xian3];
    
    _onlineUser = [STControlSprite spriteNodeWithImageNamed:@"组-42"];
    _onlineUser.position = CGPointMake(ScreenWidth - 40, _xian3.position.y - 130);
    WEAKSELF;
    [_onlineUser setTouchUpInsideBlock:^{
//        [weakSelf show];
        [weakSelf countdownAnimation];
    }];
    [self addChild:_onlineUser];
    
    [self createFooter];
    [self createCenter];
}

-(void)createCenter{
    //750 1334
    CGFloat startX = ScreenWidth * 120/750;
    CGFloat startY = ScreenHeight * 625/1334;
    CGFloat squreW = ScreenWidth/4;
    CGFloat squreH = squreW * 142/189;
    CGFloat spaceX = ScreenWidth/2 - 2 * startX;
    CGFloat spaceY = ScreenHeight * 20/1334;
    self.deskSpriteArr = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        int x = i%2;
        int y = i/2;
        STControlSprite *desk = [STControlSprite spriteNodeWithImageNamed:@"矩形-2"];
        desk.size = CGSizeMake(squreW, squreH);
        desk.position = CGPointMake(startX + squreW/2 + x * (squreW + spaceX), ScreenHeight - (startY + squreH/2 + y * (squreH + spaceY)));
        [desk setTouchUpInsideBlock:^{
            [self chipBet:i];
        }];
        [self addChild:desk];
        
        SKLabelNode *text = [SKLabelNode labelNodeWithText:@"0"];
        text.fontSize = 12;
        text.position = CGPointMake(0, -squreH/2 + 2);
        [desk addChild:text];
        [self.countLabelArr addObject:text];
        
        [_deskSpriteArr addObject:desk];
        if (x == 0) {
            SKSpriteNode *vs2 = [SKSpriteNode spriteNodeWithImageNamed:@"形状-1-拷贝"];
            vs2.position = CGPointMake(ScreenWidth/2, ScreenHeight - (startY + squreH/2 + y * (squreH + spaceY)));
            [self addChild:vs2];
        }
    }
}

//筹码下注效果
-(void)chipBet:(int)selectDeskIndex{
    if (self.selectedChip) {
        NSLog(@"%@",self.selectedChip.name);
        //筹码
        SKSpriteNode *chip = [SKSpriteNode spriteNodeWithImageNamed:self.selectedChip.name];
        chip.name = [NSString stringWithFormat:@"desk%i",selectDeskIndex];
        chip.position = self.selectedChip.position;
        chip.size = CGSizeMake(30, 30);
        [self addChild:chip];
        //桌子
        STControlSprite *desk = self.deskSpriteArr[selectDeskIndex];
        
        CGFloat minX = desk.position.x - desk.size.width/2 + 15;
        CGFloat maxX = desk.position.x + desk.size.width/2 - 15;
        CGFloat minY = desk.position.y - desk.size.height/2 + 25;
        CGFloat maxY = desk.position.y + desk.size.height/2 - 15;
        int spaceX = [NSString stringWithFormat:@"%f",maxX - minX].intValue;
        int spaceY = [NSString stringWithFormat:@"%f",maxY - minY].intValue;
        int arcX = arc4random()%spaceX;
        int arcY = arc4random()%spaceY;
        [chip runAction:[SKAction moveTo:CGPointMake(minX + arcX, minY + arcY) duration:0.72]];
        //将筹码添加到桌子数组里去
        [self.moneySpriteArr[selectDeskIndex] addObject:chip];
        
        //计算投注金额
        SKLabelNode *label = self.countLabelArr[selectDeskIndex];
        //已下注金额
        NSInteger total = [label.text integerValue];
        //当前选择筹码
        NSInteger chipCount = [[self.selectedChip.name substringFromIndex:4] integerValue];
        total += chipCount;
        label.text = [NSString stringWithFormat:@"%li",total];
        
    }
}

-(void)createFooter{
    //筹码
    _oldChipX = ScreenWidth/2;
    self.chipView = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(ScreenWidth, 100)];
    _chipView.position = CGPointMake(ScreenWidth/2, 80 + kBottomSafeHeight);
    _chipView.name = @"筹码";
    
    CGFloat wid = 0;
    self.chipSpriteArr = [NSMutableArray array];
    for (int i = 0; i < _imageNameArr.count; i++) {
        SKSpriteNode *chipSprite = [SKSpriteNode spriteNodeWithImageNamed:_imageNameArr[i]];
        CGFloat viewX = 50;
        wid = chipSprite.size.width;
        chipSprite.position = CGPointMake( viewX + i * (chipSprite.size.width + 10), 80 + kBottomSafeHeight);
        chipSprite.name = _imageNameArr[i];
        [self addChild:chipSprite];
        [_chipSpriteArr addObject:chipSprite];
    }
    
    
    SKSpriteNode *footer = [SKSpriteNode spriteNodeWithColor:color(56, 52, 43, 1) size:CGSizeMake(ScreenWidth, 30 + SafeAreaBottomHeight)];
    footer.position = CGPointMake(ScreenWidth/2, 15 + kBottomSafeHeight/2);
    
    [self addChild:footer];
    
    SKSpriteNode *cancel = [SKSpriteNode spriteNodeWithImageNamed:@"撤销"];
//    cancel.anchorPoint = CGPointMake(-1, 1);
    cancel.position = CGPointMake( cancel.frame.size.width/2 - ScreenWidth/2, 0);
    cancel.name = @"撤销";
    [footer addChild:cancel];
    
    SKSpriteNode *sure = [SKSpriteNode spriteNodeWithImageNamed:@"确认"];
    sure.name = @"确认";
    sure.position = CGPointMake( ScreenWidth/2 - cancel.frame.size.width/2 , 0);
    [footer addChild:sure];
    
    STControlSprite *moneySp = [STControlSprite spriteNodeWithImageNamed:@"圆角矩形-3"];
    [moneySp setTouchUpInsideBlock:^{
        NSLog(@"chongzhi");
    }];
    [footer addChild:moneySp];
    
    SKSpriteNode *goldIcon = [SKSpriteNode spriteNodeWithImageNamed:@"金币"];
    goldIcon.position = CGPointMake(-moneySp.size.width/2, -2);
    SKSpriteNode *addIcon = [SKSpriteNode spriteNodeWithImageNamed:@"加号"];
    addIcon.position = CGPointMake(moneySp.size.width/2, 0);
    SKLabelNode *moneyLab = [SKLabelNode labelNodeWithText:@"3,000"];
    moneyLab.fontSize = 15;
    moneyLab.position = CGPointMake(0, -6);
    
    [moneySp addChild:moneyLab];
    [moneySp addChild:goldIcon];
    [moneySp addChild:addIcon];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    CGPoint  position = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:position];
    
    if ([node.name isEqualToString:@"more"]) {
        SKSpriteNode *more = (SKSpriteNode *)node;
        if (more.zRotation) {
            //已旋转的状态
            SKAction *action = [SKAction rotateToAngle:0 duration:0.32 shortestUnitArc:NO];
            [more runAction:action];
            [self hideMoreSetting];
        }else{
            SKAction *action = [SKAction rotateToAngle:M_PI duration:0.32 shortestUnitArc:NO];
            [more runAction:action];
            
            [self showMoreSetting];
        }
        
    }
    
    if ([node.name isEqualToString:@"确认"]) {
        
    }
    if ([node.name isEqualToString:@"撤销"]) {
        [self cleanUserChip];
    }
    
    //筹码点击
    for (int i = 0 ; i < _imageNameArr.count; i++) {
        
        if ([node.name isEqualToString:_imageNameArr[i]]) {
//            NSLog(@"筹码点击 = %@",node.name);
            if (self.selectedChip) {
                NSLog(@"被选中 = %@",self.selectedChip.name);
                [self.selectedChip setTexture:[SKTexture textureWithImageNamed:self.selectedChip.name]];
            }
            SKSpriteNode *money = (SKSpriteNode *)node;
            [money setTexture:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@-选中",_imageNameArr[i]]]];
            self.selectedChip = money;
            
            break;
        }
    }
    
    //筹码点击事件
    if([node.name containsString:@"desk"]){
        NSString *deskName = [node.name substringFromIndex:4];
        [self chipBet:deskName.intValue];
    }
    
}

//更多设置
-(SKSpriteNode *)moreSettingSprite{
    if (!_moreSettingSprite) {
        SKSpriteNode *more = [SKSpriteNode spriteNodeWithImageNamed:@"下拉背景"];
        
        CGFloat width = more.size.width;
        CGFloat height = more.size.height;
        
        more.position = CGPointMake(ScreenWidth + more.size.width + 15, ScreenHeight - kStatusBarHeight);
        more.zRotation = M_PI_2;
        [self addChild:more];
        NSArray *imageArr = @[@"问号",@"音符",@"音乐-(1)"];
        NSArray *nameArr = @[@"玩法",@"音效",@"音乐"];
        
        for (int i = 0; i < 3; i ++) {
            STControlSprite *control = [STControlSprite spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(width, height/3)];
            control.position = CGPointMake(0, height/3 - i * height/3);
            
            
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:imageArr[i]];
            sprite.position = CGPointMake(-width/2 + width/4, 0);
            sprite.name = @"0";
            
            SKLabelNode *lab = [SKLabelNode labelNodeWithText:nameArr[i]];
            lab.fontSize = 15;
            lab.position = CGPointMake(width/6, -height/20);
            
            [control addChild:sprite];
            [control addChild:lab];
            [more addChild:control];
            
            
            [control setTouchUpInsideBlock:^{
                if (i==0) {
                    PlayRullView *playrull = [[PlayRullView alloc] initWithFrame:self.view.frame];
                    [self.view addSubview:playrull];
                }else if (i == 1){
                    //音效
                    if ([sprite.name isEqualToString:@"0"]) {
                        //取消音效
                        sprite.name = @"1";
                        [sprite setTexture:[SKTexture textureWithImageNamed:@"音符-1"]];
                    }else{
                        sprite.name = @"0";
                        [sprite setTexture:[SKTexture textureWithImageNamed:@"音符"]];
                    }
                }else{
                    //音乐
                    if ([sprite.name isEqualToString:@"0"]) {
                        //取消音乐
                        sprite.name = @"1";
                        [sprite setTexture:[SKTexture textureWithImageNamed:@"音乐-1"]];
                    }else{
                        sprite.name = @"0";
                        [sprite setTexture:[SKTexture textureWithImageNamed:@"音乐-(1)"]];
                    }
                }
            }];
        }
        _moreSettingSprite = more;
        
    }
    return _moreSettingSprite;
}

-(void)showMoreSetting{
    
    SKAction *action1 = [SKAction moveTo:CGPointMake(ScreenWidth - self.moreSettingSprite.size.width/2 - 15, ScreenHeight - kStatusBarHeight - 43 - self.moreSettingSprite.size.height/2) duration:0.32];
    SKAction *action2 = [SKAction rotateToAngle:0 duration:0.32];
    
    [self.moreSettingSprite runActionsGroup:@[action1,action2]];
    
}

-(void)hideMoreSetting{
    
    SKAction *action1 = [SKAction moveTo:CGPointMake(ScreenWidth + self.moreSettingSprite.size.width + 15, ScreenHeight - kStatusBarHeight) duration:0.32];
    SKAction *action2 = [SKAction rotateToAngle:M_PI_2 duration:0.32];
    
    [self.moreSettingSprite runActionsGroup:@[action1,action2]];
    
}

//开奖记录
-(void)showOpenResultView
{
    OpenResultView *open = [[OpenResultView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:open];
}

//投注记录
-(void)betResultView
{
    BetResultView *betresult = [[BetResultView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:betresult];
}

//清除用户投注
-(void)cleanUserChip{
    for (int i = 0; i<self.countLabelArr.count; i++) {
        self.countLabelArr[i].text = @"0";
    }
}

//清除所有筹码
-(void)cleanAllChipAndsendToWinDesk:(NSArray *)arr{
    for (int i = 0; i < self.moneySpriteArr.count; i++) {
        NSMutableArray *deskArr = self.moneySpriteArr[i];
        for (int j = 0; j < deskArr.count; j++) {
            SKSpriteNode *money = deskArr[j];
            [money runAction:[SKAction moveTo:CGPointMake(ScreenWidth/2, self.view.frame.size.height - kTopBarSafeHeight - 20) duration:0.72] completion:^{
                int desknum = arc4random()%arr.count;
                [self sendChipToWinDesk:[arr[desknum] intValue] andChip:money];
            }];
        }
    }
}

//将所有筹码发到赢的桌子上去
-(void)sendChipToWinDesk:(int)selectDeskIndex andChip:(SKSpriteNode *)chip{
//    chip = [SKSpriteNode spriteNodeWithImageNamed:self.selectedChip.name];
//    chip.name = [NSString stringWithFormat:@"desk%i",selectDeskIndex];
//    chip.position = self.selectedChip.position;
    chip.size = CGSizeMake(30, 30);
//    [self addChild:chip];
    //桌子
    STControlSprite *desk = self.deskSpriteArr[selectDeskIndex];
    
    CGFloat minX = desk.position.x - desk.size.width/2 + 15;
    CGFloat maxX = desk.position.x + desk.size.width/2 - 15;
    CGFloat minY = desk.position.y - desk.size.height/2 + 25;
    CGFloat maxY = desk.position.y + desk.size.height/2 - 15;
    int spaceX = [NSString stringWithFormat:@"%f",maxX - minX].intValue;
    int spaceY = [NSString stringWithFormat:@"%f",maxY - minY].intValue;
    int arcX = arc4random()%spaceX;
    int arcY = arc4random()%spaceY;
    [chip runAction:[SKAction moveTo:CGPointMake(minX + arcX, minY + arcY) duration:0.72] completion:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.84*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [chip runAction:[SKAction moveTo:self.onlineUser.position duration:0.72] completion:^{
                [chip removeFromParent];
                self.moneySpriteArr = nil;
            }];
        });
        
    }];
    
}


//开始下注
-(void)startBetAnimation{
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"开始下注"];
    sprite.position = CGPointMake(ScreenWidth/2, ScreenHeight/2);
    sprite.xScale = 0;
    sprite.yScale = 0;
    [self addChild:sprite];
    [sprite runAction:[SKAction scaleXTo:1 y:1 duration:0.3] completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.4*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [sprite runAction:[SKAction scaleXTo:0 y:0 duration:0.3] completion:^{
                [sprite removeFromParent];
            }];
        });
    }];
}

//发牌(显示背面)
-(void)sendCard{
    CGFloat startX = 21;
    CGFloat startY = ScreenHeight - kStatusBarHeight - 110;
    CGFloat width = (ScreenWidth - 80)/4;
    CGFloat cardW =  width/2.5;
    CGFloat cardH = cardW * 80 / 56;
    
    CGFloat resultH = cardW * 45 /86;
    CGFloat repeatX = cardW*0.4;
    self.cardArr = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        NSMutableArray<SKSpriteNode *> *arr = [NSMutableArray array];
        for (int j = 0; j < 5; j++) {
            SKSpriteNode *card = [SKSpriteNode spriteNodeWithImageNamed:@"扑克背面"];
            card.position = CGPointMake(ScreenWidth/2, self.view.frame.size.height - kStatusBarHeight - 20);
            card.size = CGSizeZero;
            [self addChild:card];
            
            SKAction *action1 = [SKAction moveTo:CGPointMake(21 + cardW/2 + j*repeatX + i * (width + 13), startY) duration:0.72 + j * 0.1];
            SKAction *action2 = [SKAction resizeToWidth:cardW height:cardH duration:0.72 + j * 0.1];
            [card runActionsGroup:@[action1,action2]];
            [arr addObject:card];
        }
        SKSpriteNode *result = [SKSpriteNode spriteNodeWithImageNamed:@"牛一"];
        result.position = CGPointMake(startX + width/2 + i * (width + 13), startY - cardH/2 + resultH/2);
        result.hidden = YES;
        [self addChild:result];
        [arr addObject:result];
        [self.cardArr addObject:arr];
    }
    
}

//随机撒币到桌子上
-(void)sendChipToDesk{
    NSArray *bargainName = _imageNameArr;
    
    int index = 0;
    for (SKSpriteNode *desk in self.deskSpriteArr) {
        CGFloat minX = desk.position.x - desk.size.width/2 + 15;
        CGFloat maxX = desk.position.x + desk.size.width/2 - 15;
        CGFloat minY = desk.position.y - desk.size.height/2 + 25;
        CGFloat maxY = desk.position.y + desk.size.height/2 - 15;
        
        int arcNum = arc4random()%5 + 3;
        
        NSMutableArray *deskArr = self.moneySpriteArr[index];
        for (int i = 0; i < arcNum; i ++ ) {
            int arcName = arc4random()%5;
            SKSpriteNode *money = [SKSpriteNode spriteNodeWithImageNamed:bargainName[arcName]];
            money.name = [NSString stringWithFormat:@"desk%i",index];
            money.size = CGSizeMake(30, 30);
            money.position = _onlineUser.position;
            [self addChild:money];
            int spaceX = [NSString stringWithFormat:@"%f",maxX - minX].intValue;
            int spaceY = [NSString stringWithFormat:@"%f",maxY - minY].intValue;
            int arcX = arc4random()%spaceX;
            int arcY = arc4random()%spaceY;
            SKAction *action = [SKAction moveTo:CGPointMake(minX + arcX, minY + arcY) duration:0.72];
            [money runAction:action];
            //将撒下来的筹码加入deskArr中
            [deskArr addObject:money];
        }
        index ++ ;
    }
}

//开牌
-(void)openCard:(int)desknum andResult:(NSArray *)numberArr{
    NSMutableArray *arr = self.cardArr[desknum];
    
    for (int i = 0; i<arr.count - 1; i++) {
        SKSpriteNode *card = arr[i];
        SKAction *action = [SKAction scaleXTo:0.2 duration:0.36];
        SKAction *action2 = [SKAction scaleXTo:1 duration:0.36];
        [card runAction:action completion:^{
            [card setTexture:[SKTexture textureWithImageNamed:numberArr[i]]];
            [card runAction:action2];
        }];
    }
    
    SKSpriteNode *result = arr[5];
    [result setTexture:[SKTexture textureWithImageNamed:@"牛牛"]];
    result.hidden = NO;
    
}

//关牌
-(void)closeAllCard{
    
    for (int index = 0 ; index < 4; index ++) {
        
        NSMutableArray *arr = self.cardArr[index];
        for (int i = 0; i<arr.count - 1; i++) {
            SKSpriteNode *card = arr[i];
            SKAction *action = [SKAction scaleXTo:0.2 duration:0.36];
            SKAction *action2 = [SKAction scaleXTo:1 duration:0.36];
            [card runAction:action completion:^{
                [card setTexture:[SKTexture textureWithImageNamed:@"扑克背面"]];
                [card runAction:action2];
            }];
        }
        
        SKSpriteNode *result = arr[5];
//        [result setTexture:[SKTexture textureWithImageNamed:@"牛牛"]];
        result.hidden = YES;
    }
    
    
}

//倒计时动画
-(void)countdownAnimation{
//    SKTexture *num1 = [SKTexture textureWithImageNamed:@"num1"];
//    SKEmitterNode *emitter = [SKEmitterNode new];
//    emitter.particleTexture = num1;
//    emitter.particleBirthRate = 10;
//    emitter.particleColor = [UIColor whiteColor];
//    emitter.particleSpeed = -450;
//    emitter.particleScaleRange = 150;
//    emitter.particleLifetime = 2;
//
//    emitter.particleScale = 0.2;
//    emitter.particleScaleRange = 0.5;
//    emitter.particleAlpha = 0.7;
//    emitter.particleAlphaRange = 0.5;
//
//    emitter.emissionAngle = 0;
//    emitter.emissionAngleRange = M_PI * 2;
//
//    emitter.particleColorBlendFactor = 1;
//    emitter.position = CGPointMake(ScreenWidth/2, ScreenHeight/2);
//    [self addChild:emitter];
    
    
    NSArray *namearr = @[@"countdown3",@"countdown2",@"countdown1",@"停止下注"];
    for (int i = 0; i < 4; i++) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(i*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            SKSpriteNode *sprite2 = [SKSpriteNode spriteNodeWithImageNamed:@"-光效"];
            sprite2.position = CGPointMake(ScreenWidth/2, ScreenHeight/2);
            sprite2.xScale = 0;
            sprite2.yScale = 0;
            [self addChild:sprite2];
            
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:namearr[i]];
            sprite.position = CGPointMake(ScreenWidth/2, ScreenHeight/2);
            sprite.xScale = 0;
            sprite.yScale = 0;
            [self addChild:sprite];
            
            
            [sprite runAction:[SKAction scaleXTo:1 y:1 duration:0.2] completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.6*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [sprite runAction:[SKAction scaleXTo:0 y:0 duration:0.2] completion:^{
                        [sprite removeFromParent];
                    }];
                });
            }];
            
            [sprite2 runAction:[SKAction scaleXTo:1 y:1 duration:0.2] completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.6*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [sprite2 runAction:[SKAction scaleXTo:0 y:0 duration:0.2] completion:^{
                        [sprite2 removeFromParent];
                    }];
                });
            }];
        });
        
    }
    
}

//胜利区域出现“胜利特效”
-(void)deskShowWin:(NSArray *)arr{
    
    for (NSNumber *num in arr) {
        SKSpriteNode *winSp = [SKSpriteNode spriteNodeWithImageNamed:@"胜利"];
        winSp.position = self.deskSpriteArr[num.intValue].position;
        [self addChild:winSp];
        //一轮游戏结束后隐藏
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(10*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [winSp runAction:[SKAction scaleXBy:0 y:0 duration:0.5] completion:^{
                [winSp removeFromParent];
            }];
        });
    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    CGPoint position = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:position];
    SKSpriteNode *moneyNode = (SKSpriteNode *)node;
    
    for (int i = 0 ; i < _imageNameArr.count; i++) {
        
        if ([moneyNode.name isEqualToString:_imageNameArr[i]]) {
            for (int j = 0; j < self.chipSpriteArr.count; j++) {
                SKSpriteNode *money = self.chipSpriteArr[j];
                CGFloat startX = position.x + (j - i)*(money.size.width + 10);
                money.position = CGPointMake(startX, money.position.y);
            }
            break;
        }
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    SKSpriteNode *first = self.chipSpriteArr[0];
    if (first.position.x > 50) {
        for (int i = 0; i < _chipSpriteArr.count; i++) {
            SKSpriteNode *chipSprite = _chipSpriteArr[i];
            [chipSprite runAction:[SKAction moveToX:50 + i * (chipSprite.size.width + 10) duration:0.32]];
        }
    }else if ([self.chipSpriteArr lastObject].position.x < ScreenWidth - 50){
        
        for (NSInteger i = self.chipSpriteArr.count - 1; i > 0; i--) {
            
            SKSpriteNode *chipSprite = _chipSpriteArr[i];
            [chipSprite runAction:[SKAction moveToX:ScreenWidth - 50 - (self.chipSpriteArr.count - 1 - i) * (chipSprite.size.width + 10) duration:0.32]];
//            NSLog(@"%ld -- %f",i,ScreenWidth - 50 - (self.chipSpriteArr.count - 1 - i) * (chipSprite.size.width + 10));
        }
    }
}

-(NSMutableArray<NSMutableArray<SKSpriteNode *> *> *)moneySpriteArr{
    if (!_moneySpriteArr) {
        _moneySpriteArr = [NSMutableArray array];
        for (int i = 0; i<6; i++) {
            [_moneySpriteArr addObject:[NSMutableArray array]];
        }
    }return _moneySpriteArr;
}

-(NSMutableArray<SKLabelNode *> *)countLabelArr{
    if (!_countLabelArr) {
        _countLabelArr = [NSMutableArray array];
    }
    return _countLabelArr;
}

@end
