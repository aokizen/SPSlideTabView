//
//  SPSlideTabBar.h
//  SPSlideTabView
//
//  Created by Spring on 14-5-22.
//  Copyright (c) 2014年 aokizen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SPSlideTabBarSeparatorStyleNone,
    SPSlideTabBarSeparatorStyleSingleLine,
    SPSlideTabBarSeparatorStyleDottedLine,
}SPSlideTabBarSeparatorStyle;

@class SPSlideTabButton;

@protocol SPSlideTabBarDelegate <NSObject>

- (void)barButtonClicked:(SPSlideTabButton *)button;

@end

@interface SPSlideTabBar : UIView

@property (strong, nonatomic) NSArray *barButtons;

@property (strong, nonatomic) SPSlideTabButton *selectedButton;
@property (assign, nonatomic) NSUInteger selectedIndex;
@property (assign, nonatomic) CGFloat barButtonMinWidth;


@property (strong, nonatomic) UIColor *selectedViewColor;

@property (assign, nonatomic) SPSlideTabBarSeparatorStyle *separatorStyle;
@property (strong, nonatomic) UIColor *separatorColor;

@property (weak, nonatomic) id<SPSlideTabBarDelegate> delegate;

- (void)addTabForTitle:(NSString *)title;
- (void)setScrollOffsetPercentage:(CGFloat)percentage;

@end
