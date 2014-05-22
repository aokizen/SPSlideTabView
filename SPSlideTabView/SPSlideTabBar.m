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
    
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
    [selectedView setBackgroundColor:[self selectedViewColor]];
    [self addSubview:selectedView];
    self.selectedView = selectedView;
    
}

#pragma mark - Public
- (void)addTabForTitle:(NSString *)title {
    SPSlideTabButton *button = [[SPSlideTabButton alloc] initWithTitle:title WithHeight:self.frame.size.height];
    
    if ([self barButtons].count > 0) {
        
        SPSlideTabButton *lastButton = [[self barButtons] lastObject];
        CGRect frame = button.frame;
        frame.origin.x = CGRectGetMaxX(lastButton.frame);
        button.frame = frame;
    }
    
    [button addTarget:self action:@selector(barButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:[self barButtons].count];
    
    [self addSubview:button];
    
    [self.buttons addObject:button];
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
        self.selectedView.frame = frame;
        
        self.selectedView.center = CGPointMake([self selectedButton].center.x, self.selectedView.center.y);
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
