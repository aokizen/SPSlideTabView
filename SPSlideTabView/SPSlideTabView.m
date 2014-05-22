//
//  SPSlideTabView.m
//  SPSlideTabView
//
//  Created by Spring on 14-5-22.
//  Copyright (c) 2014年 aokizen. All rights reserved.
//

#import "SPSlideTabView.h"

#import "SPSlideTabBar.h"
#import "SPSlideTabButton.h"

@interface SPSlideTabView ()

@property (strong, nonatomic) SPSlideTabBar *tabBar;

@end

@implementation SPSlideTabView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    SPSlideTabBar *slideTabBar = [[SPSlideTabBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 49)];
    [slideTabBar setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth];
    [self addSubview:slideTabBar];
    self.tabBar = slideTabBar;
    
}

- (void)addPageForTitle:(NSString *)title {
    [self.tabBar addTabForTitle:title];
}

- (void)setSelectedPageIndex:(NSUInteger)selectedPageIndex {
    _selectedPageIndex = selectedPageIndex;
    
    [self.tabBar setSelectedIndex:selectedPageIndex];
}



@end
