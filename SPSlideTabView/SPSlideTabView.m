//
//  SPSlideTabView.m
//  SPSlideTabView
//
//  Created by Spring on 14-5-22.
//  Copyright (c) 2014年 aokizen. All rights reserved.
//

#import "SPSlideTabView.h"

#import "SPSlideTabButton.h"

#define DEBUG 1

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

#define KVO_CONTEXT_SCROLL_CONTENT_OFFSET @"KVO_CONTEXT_SCROLL_CONTENT_OFFSET"

#define kSlideVelocity 1500.0

@interface SPSlideTabView () <UIScrollViewDelegate, SPSlideTabBarDelegate> {
    CGPoint _locationBeforePan;
    CGPoint _locationAfterPan;
}

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation SPSlideTabView

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

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
    
    self.pageViewContainerPanels = [NSMutableArray array];
    
    self.tabBar = [[SPSlideTabBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 49)];
    [self.tabBar setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth];
    [self.tabBar setSlideDelegate:self];
    [self addSubview:self.tabBar];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.tabBar.frame.size.height, self.frame.size.width, self.frame.size.height - self.tabBar.frame.size.height)];
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [self.scrollView setContentInset:UIEdgeInsetsZero];
    [self.scrollView setBackgroundColor:[UIColor clearColor]];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setBounces:YES];
    [self.scrollView setAlwaysBounceVertical:NO];
    [self.scrollView setAlwaysBounceHorizontal:YES];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setClipsToBounds:NO];
    [self addSubview:self.scrollView];
    
    [self.scrollView setDelegate:self];
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:KVO_CONTEXT_SCROLL_CONTENT_OFFSET];
    
}

#pragma mark - public
- (void)addPageView:(UIView *)pageView ForTitle:(NSString *)title {
    [self.tabBar addTabForTitle:title];
    
    UIView *containerPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    
    
    if (self.pageViewContainerPanels.count > 0) {
        UIView *lastPanel = [self.pageViewContainerPanels lastObject];
        [containerPanel setFrame:CGRectMake(CGRectGetMaxX(lastPanel.frame), containerPanel.frame.origin.y, containerPanel.frame.size.width, containerPanel.frame.size.height)];
    }
    
    CGRect frame = pageView.frame;
    frame.origin = CGPointZero;
    frame.size = containerPanel.frame.size;
    pageView.frame = frame;
    [pageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    
    [self styleContainerPanel:containerPanel];
    
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.pageViewContainerPanels];
    [array addObject:containerPanel];
    self.pageViewContainerPanels = array;
    
    
    [containerPanel addSubview:pageView];
    [self.scrollView addSubview:containerPanel];
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetMaxX(containerPanel.frame), self.scrollView.frame.size.height)];
    
}

#pragma mark - style
- (void)styleContainerPanel:(UIView *)containerPanel {
    
    [containerPanel setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    [containerPanel setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - setter / getter

- (void)setSelectedPageIndex:(NSUInteger)selectedPageIndex {
    _selectedPageIndex = selectedPageIndex;
}

- (UIView *)selectedPageView {
    UIView *selectedPageView = [self.pageViewContainerPanels objectAtIndex:self.selectedPageIndex];
    return selectedPageView;
}

- (UIView *)previousPageView {
    if (self.selectedPageIndex > 0) {
        return [self.pageViewContainerPanels objectAtIndex:self.selectedPageIndex - 1];
    }
    
    return nil;
}

- (UIView *)nextPageView {
    if (self.selectedPageIndex + 1 < self.pageViewContainerPanels.count) {
        return [self.pageViewContainerPanels objectAtIndex:self.selectedPageIndex + 1];
    }
    
    return nil;
}

- (void)scrollToPage:(NSUInteger)page {

    CGFloat targetOffsetX = self.frame.size.width * page;
    float seconds = fabs(targetOffsetX - self.scrollView.contentOffset.x) / kSlideVelocity;
    
    NSLog(@"%f", seconds);
    
    [UIView animateWithDuration:seconds animations:^(void) {
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * page, 0) animated:NO];
    }completion:^(BOOL finished) {
        [self.tabBar setSelectedIndex:page];
        [self setSelectedPageIndex:page];
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView  {

    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;

    if (page != self.selectedPageIndex) {
        [self scrollToPage:page];
    }
}

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.scrollView) {
        if (context == KVO_CONTEXT_SCROLL_CONTENT_OFFSET) {

            [self.tabBar setScrollOffsetPercentage:self.scrollView.contentOffset.x / (CGFloat)self.scrollView.frame.size.width - self.selectedPageIndex];
        }
    }
}

#pragma mark - SPSlideTabBarDelegate
- (void)barButtonClicked:(SPSlideTabButton *)button {
    [self scrollToPage:button.tag];
}

@end
