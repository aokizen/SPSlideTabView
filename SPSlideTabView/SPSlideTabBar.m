//
//  SPSlideTabBar.m
//  SPSlideTabView
//
//  Created by Spring on 14-5-22.
//  Copyright (c) 2014年 aokizen. All rights reserved.
//

#import "SPSlideTabBar.h"

#import "SPSlideTabButton.h"

@interface SPSlideTabBar ()

@property (strong, nonatomic) NSMutableArray *buttons;

@property (strong, nonatomic) UIView *selectedView;

@property (strong, nonatomic) NSMutableArray *lineViews;

@end

@implementation SPSlideTabBar

@synthesize selectedIndex = _selectedIndex;
@synthesize selectedViewColor = _selectedViewColor;
@synthesize barButtonMinWidth = _barButtonMinWidth;
@synthesize separatorStyle = _separatorStyle;
@synthesize separatorColor = _separatorColor;
@synthesize separatorLineInsetTop = _separatorLineInsetTop;

- (void)dealloc {
    self.delegate = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    self.buttons = [NSMutableArray array];
    self.lineViews = [NSMutableArray array];

    self.selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 2, 0, 2)];
    [self addSubview:self.selectedView];
    
    [self reset];
}

- (void)reset {
    
    [self setContentInset:UIEdgeInsetsZero];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setShowsVerticalScrollIndicator:NO];
    
    
    [self.selectedView setBackgroundColor:[self selectedViewColor]];
    
    [self.lineViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.lineViews removeAllObjects];
    
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self reset];
    
    if (self.separatorStyle != SPSlideTabBarSeparatorStyleNone) {
        
        if ([self barButtons].count > 1) {
            
            for (int i = 1; i < [self barButtons].count; i++) {
                SPSlideTabButton *button = [[self barButtons] objectAtIndex:i];
                
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(button.frame.origin.x - 0.5, [self separatorLineInsetTop], 1, button.frame.size.height - [self separatorLineInsetTop] * 2)];
                [line setBackgroundColor:[self separatorColor]];
                [line setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight];
                [self.lineViews addObject:line];
                [self addSubview:line];
                
            }
        }
        
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat originX = 0;
    for (int i = 0; i < [self barButtons].count; i ++) {
        SPSlideTabButton *button = [[self barButtons] objectAtIndex:i];
        [button setMinWidth:self.barButtonMinWidth];
        [button fitSize];
        
        CGRect frame = button.frame;
        frame.origin.x = originX;
        button.frame = frame;
        
        originX += frame.size.width;
    }
    
    [self setContentSize:CGSizeMake(originX, self.frame.size.height)];
    
    [self fixSelectedView];
}

#pragma mark - Action
- (IBAction)barButtonClicked:(SPSlideTabButton *)sender {
    if (self.slideDelegate) {
        [self.slideDelegate barButtonClicked:sender];
    }
    
    [UIView animateWithDuration:0.2 animations:^(void) {
        
        [self scrollRectToVisible:[self selectedButton].frame animated:NO];
    }];
}

#pragma mark - Public
- (void)addTabForTitle:(NSString *)title {
    SPSlideTabButton *button = [[SPSlideTabButton alloc] initWithTitle:title WithHeight:self.frame.size.height];
    if (button.frame.size.width < [self barButtonMinWidth])
    
    if ([self barButtons].count > 0) {
        
        SPSlideTabButton *lastButton = [[self barButtons] lastObject];
        CGRect frame = button.frame;
        frame.origin.x = CGRectGetMaxX(lastButton.frame);
        button.frame = frame;
    }
    
    [button addTarget:self action:@selector(barButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:[self barButtons].count];
    
    
    [self.buttons addObject:button];
    
    [self addSubview:button];
    
    [self setContentSize:CGSizeMake(CGRectGetMaxX(button.frame), self.frame.size.height)];
    
    [self setNeedsDisplay];
}

- (void)setScrollOffsetPercentage:(CGFloat)percentage {

    SPSlideTabButton *targetButton;
    
    if (percentage > 0.0) {
        NSInteger targetIndex = self.selectedIndex + 1;
        if (targetIndex < [self barButtons].count) {
            targetButton = [self nextButton];
        }
    }
    else if (percentage < 0.0){
        NSInteger targetIndex = self.selectedIndex - 1;
        if (targetIndex >= 0) {
            targetButton = [self previousButton];
        }
    }
    else {
        targetButton = [self selectedButton];
    }
    
    if(targetButton) {
        
        SPSlideTabButton *originButton = [self selectedButton];
        
        CGFloat originOriginX = CGRectGetMidX(originButton.frame) - [originButton widthToFit] / 2;
        CGFloat originFrameWidth = [originButton widthToFit];

        CGFloat targetOriginX = CGRectGetMidX(targetButton.frame) - [targetButton widthToFit] / 2;
        CGFloat targetFrameWidth = [targetButton widthToFit];
        
        CGRect frame = self.selectedView.frame;
        frame.origin.y = self.frame.size.height - frame.size.height;
        frame.origin.x = originOriginX + (targetOriginX - originOriginX) * fabs(percentage);
        frame.size.width = originFrameWidth + (targetFrameWidth - originFrameWidth) * fabs(percentage);
        self.selectedView.frame = frame;

    }
}

#pragma private
- (void)fixSelectedView {
    [UIView animateWithDuration:0.2 animations:^(void) {
        
        CGRect frame = self.selectedView.frame;
        frame.size.width = [[self selectedButton] widthToFit];
        frame.origin.y = self.frame.size.height - frame.size.height;
        frame.origin.x = CGRectGetMidX( [self selectedButton].frame) - frame.size.width / 2;
        self.selectedView.frame = frame;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^(void) {
        
            [self scrollRectToVisible:[self selectedButton].frame animated:NO];
        }];
    }];
}

#pragma mark - getter / setter
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    _selectedIndex = selectedIndex;
    
    [self fixSelectedView];
}

- (NSArray *)barButtons {
    return self.buttons;
}

- (SPSlideTabButton *)previousButton {
    if (self.selectedIndex > 0) {
        return [[self barButtons] objectAtIndex:self.selectedIndex - 1];
    }
    else {
        return nil;
    }
}

- (SPSlideTabButton *)nextButton {
    if (self.selectedIndex < [self barButtons].count) {
        return [[self barButtons] objectAtIndex:self.selectedIndex + 1];
    }
    else {
        return nil;
    }
}

- (SPSlideTabButton *)selectedButton {
    return [[self barButtons] objectAtIndex:self.selectedIndex];
}


- (UIColor *)selectedViewColor {
    if (_selectedViewColor) {
        return _selectedViewColor;
    }
    
    return [UIColor magentaColor];
}


- (void)setSelectedViewColor:(UIColor *)selectedViewColor {
    _selectedViewColor = selectedViewColor;
    
    [self.selectedView setBackgroundColor:_selectedViewColor];
}

- (CGFloat)barButtonMinWidth {
    if (_barButtonMinWidth) {
        return _barButtonMinWidth;
    }
    
    return kSlideTabButtonMinWidth;
}

- (void)setBarButtonMinWidth:(CGFloat)barButtonMinWidth {
    
    _barButtonMinWidth = barButtonMinWidth;
    
    [self setNeedsLayout];
}


- (SPSlideTabBarSeparatorStyle)separatorStyle {
    if (_separatorStyle) {
        return _separatorStyle;
    }
    
    return SPSlideTabBarSeparatorStyleSingleLine;
}

- (void)setSeparatorStyle:(SPSlideTabBarSeparatorStyle)separatorStyle {
    _separatorStyle = separatorStyle;
    
    [self setNeedsDisplay];
}

- (UIColor *)separatorColor {
    if (_separatorColor) {
        return _separatorColor;
    }
    
    return [UIColor clearColor];
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    
    [self setNeedsDisplay];
}

- (void)setSeparatorLineInsetTop:(CGFloat)separatorLineInsetTop {
    _separatorLineInsetTop = separatorLineInsetTop;
    
    [self setNeedsDisplay];
}

@end
