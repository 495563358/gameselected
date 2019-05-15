//
//  ViewController.m
//  Selected
//
//  Created by oops on 2019/4/20.
//  Copyright © 2019 oops. All rights reserved.
//

#import "ViewController.h"
#import "GameController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blueColor];
    GameController *vc = [GameController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    GameController *vc = [GameController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
