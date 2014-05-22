//
//  SPSlideTabBar.h
//  SPSlideTabView
//
//  Created by Spring on 14-5-22.
//  Copyright (c) 2014年 aokizen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPSlideTabButton;

@interface SPSlideTabBar : UIToolbar

@property (strong, nonatomic) NSArray *barButtons;

@property (strong, nonatomic) SPSlideTabButton *selectedButton;
@property (assign, nonatomic) NSUInteger selectedIndex;


@property (strong, nonatomic) UIColor *selectedViewColor;



- (void)addTabForTitle:(NSString *)title;

@end
