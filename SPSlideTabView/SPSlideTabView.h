//
//  SPSlideTabView.h
//  SPSlideTabView
//
//  Created by Spring on 14-5-22.
//  Copyright (c) 2014年 aokizen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SPSlideTabBar.h"

@interface SPSlideTabView : UIView

@property (assign, nonatomic) NSUInteger selectedPageIndex;

@property (strong, nonatomic) NSArray *pageViewContainerPanels;

@property (strong, nonatomic) SPSlideTabBar *tabBar;


- (void)addPageView:(UIView *)pageView ForTitle:(NSString *)title;

@end
