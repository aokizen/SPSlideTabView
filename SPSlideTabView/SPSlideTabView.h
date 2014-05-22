//
//  SPSlideTabView.h
//  SPSlideTabView
//
//  Created by Spring on 14-5-22.
//  Copyright (c) 2014年 aokizen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPSlideTabBar;

@interface SPSlideTabView : UIView

@property (assign, nonatomic) NSUInteger selectedPageIndex;

@property (strong, nonatomic) NSArray *pageViews;


- (void)addPageForTitle:(NSString *)title;

@end
