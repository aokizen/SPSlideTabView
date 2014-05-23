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
@property (strong, nonatomic) UIScrollView *scrollView;


@end

@implementation SPSlideTabBar

@synthesize selectedIndex = _selectedIndex;
@synthesize selectedViewColor = _selectedViewColor;

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
    
    self.scrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:self.scrollView];
    
    self.selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
    [self.scrollView addSubview:self.selectedView];
    
    [self reset];
}

- (void)reset {
    
    [self.scrollView setContentInset:UIEdgeInsetsZero];
    [self.scrollView setBackgroundColor:[UIColor clearColor]];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    
    
    [self.selectedView setBackgroundColor:[self selectedViewColor]];
    
    
    [self setBackgroundColor:[UIColor clearColor]];
    
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self reset];
}

#pragma mark - Public
- (void)addTabForTitle:(NSString *)title {
    SPSlideTabButton *button = [[SPSlideTabButton alloc] initWithTitle:title WithHeight:self.scrollView.frame.size.height];
    
    if ([self barButtons].count > 0) {
        
        SPSlideTabButton *lastButton = [[self barButtons] lastObject];
        CGRect frame = button.frame;
        frame.origin.x = CGRectGetMaxX(lastButton.frame);
        button.frame = frame;
    }
    
    [button addTarget:self action:@selector(barButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:[self barButtons].count];
    
    
    [self.buttons addObject:button];
    
    [self.scrollView addSubview:button];
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetMaxX(button.frame), self.scrollView.frame.size.height)];
}


#pragma mark - Action
- (IBAction)barButtonClicked:(SPSlideTabButton *)sender {
    [self setSelectedIndex:sender.tag];
}

#pragma mark - getter / setter
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    
    _selectedIndex = selectedIndex;
    
    [UIView animateWithDuration:0.25 animations:^(void) {
        
        CGRect frame = self.selectedView.frame;
        frame.size.width = [[self selectedButton] widthToFit];
        frame.origin.y = self.frame.size.height - frame.size.height;
        frame.origin.x = CGRectGetMidX( [self selectedButton].frame) - frame.size.width / 2;
        self.selectedView.frame = frame;
    } completion:^(BOOL finished) {
        [self.scrollView scrollRectToVisible:[self selectedButton].frame animated:YES];
    }];
}

#pragma mark - Property
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
    
    return [UIColor colorWithRed:62.0f / 255.0f green:158.0f / 255.0f blue:133.0f / 255.0f alpha:1.0f];
}


- (void)setSelectedViewColor:(UIColor *)selectedViewColor {
    _selectedViewColor = selectedViewColor;
    
    [self.selectedView setBackgroundColor:_selectedViewColor];
}

@end
