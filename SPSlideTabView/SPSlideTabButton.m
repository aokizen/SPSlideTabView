//
//  SPSlideTabButton.m
//  SPSlideTabView
//
//  Created by Spring on 14-5-23.
//  Copyright (c) 2014年 aokizen. All rights reserved.
//

#import "SPSlideTabButton.h"

#define kSlideTabButtonMinWidth 80
#define kContenPadding 8

@implementation SPSlideTabButton

- (id)initWithTitle:(NSString *)title WithHeight:(CGFloat)height {
    
    self = [SPSlideTabButton buttonWithType:UIButtonTypeCustom];
    if (self) {
    
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];

        CGSize size = [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, height)];
        size.width += kContenPadding * 2;
        if (size.width < kSlideTabButtonMinWidth) {
            size.width = kSlideTabButtonMinWidth;
        }
        
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, height)];
    }
    
    return self;
}

- (CGFloat)widthToFit {
    CGSize size = [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, self.frame.size.height)];
    return size.width;
}

@end
