//
//  ExampleViewController.m
//  SPSlideTabView
//
//  Created by Spring on 14-5-22.
//  Copyright (c) 2014年 aokizen. All rights reserved.
//

#import "ExampleViewController.h"

#import "SPSlideTabView.h"

@interface ExampleViewController () {
    BOOL isFirstLoading;
}

@property (strong, nonatomic) IBOutlet SPSlideTabView *slideTabView;

@end

@implementation ExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isFirstLoading = YES;
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
       // self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (isFirstLoading) {
        [self customSlideTabView];
        [self addPages];
        
        [self.slideTabView setSelectedPageIndex:0];
        [self.slideTabView setNeedsRender];
    }
    
    isFirstLoading = NO;
}

- (void)customSlideTabView {
    
    [self.slideTabView setBackgroundColor:[UIColor clearColor]];
    
    [self.slideTabView setTabBarHeight:40];
    [self.slideTabView setTabBarBackgroundColor:[UIColor lightGrayColor]];
    
    [self.slideTabView setSelectedViewColor:[UIColor whiteColor]];
    
    /**
     * custom the selectedView's width 
     * (fit to the text of the selected button or equals to the width of the selected button)
     */
    [self.slideTabView setSelectedViewSizeToFit:YES];
    
    [self.slideTabView setSeparatorStyle:SPSlideTabBarSeparatorStyleSingleLine];
    [self.slideTabView setSeparatorLineInsetTop:8];
    [self.slideTabView setSeparatorColor:[UIColor darkGrayColor]];
    
    [self.slideTabView setBarButtonMinWidth:self.view.frame.size.width / 6];
    [self.slideTabView setBarButtonTitleColor:[UIColor blackColor]];
    [self.slideTabView setBarButtonTitleFont:[UIFont systemFontOfSize:15]];
}


- (void)addPages {
    UIView *first = [[UIView alloc] initWithFrame:CGRectZero];
    [first setBackgroundColor:[UIColor yellowColor]];
    
    UIView *second = [[UIView alloc] initWithFrame:CGRectZero];
    [second setBackgroundColor:[UIColor blueColor]];
    
    UIView *third = [[UIView alloc] initWithFrame:CGRectZero];
    [third setBackgroundColor:[UIColor orangeColor]];
    
    UIView *fourth = [[UIView alloc] initWithFrame:CGRectZero];
    [fourth setBackgroundColor:[UIColor purpleColor]];
    
    UIView *fifth = [[UIView alloc] initWithFrame:CGRectZero];
    [fifth setBackgroundColor:[UIColor redColor]];
    
    [self.slideTabView addPageView:first ForTitle:@"One"];
    [self.slideTabView addPageView:second ForTitle:@"Two"];
    
    [self.slideTabView addPageView:third ForTitle:@"Three"];
    [self.slideTabView addPageView:fifth ForTitle:@"this is a long title"];
    [self.slideTabView addPageView:fourth ForTitle:@"Four"];
}


@end
