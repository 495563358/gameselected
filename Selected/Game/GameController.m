//
//  GameController.m
//  Selected
//
//  Created by oops on 2019/4/20.
//  Copyright © 2019 oops. All rights reserved.
//

#import "GameController.h"
#import "MyScence.h"

@interface GameController ()

@end

@implementation GameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[SKView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    MyScence *scene = [[MyScence alloc] initWithSize:self.view.frame.size];
//    scene.anchorPoint = CGPointMake(0.5, 0.5);
    scene.scaleMode = SKSceneScaleModeAspectFit;
    
    SKView *skview = (SKView *)self.view;
    skview.showsFPS = YES;
    skview.showsNodeCount = YES;
    skview.backgroundColor = [UIColor whiteColor];
    [skview presentScene:scene];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    [self addNotification];
}

-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitGame) name:@"exitgame" object:nil];
    
}

-(void)exitGame{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    NSLog(@"game delloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
