//
//  UITabBar+badge.h
//  yicai
//
//  Created by oops on 2019/4/12.
//  Copyright © 2019 defuya. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar(badge)
- (void)showBadgeOnItemIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;
@end

NS_ASSUME_NONNULL_END
