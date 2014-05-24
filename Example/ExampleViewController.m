//
//  ExampleViewController.m
//  SPSlideTabView
//
//  Created by Spring on 14-5-22.
//  Copyright (c) 2014年 aokizen. All rights reserved.
//

#import "ExampleViewController.h"

#import "SPSlideTabView.h"

@interface ExampleViewController ()

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
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
       // self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
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
    
    
    
    //[self.slideTabView addPageForTitle:@"other title"];
    
    
    [self.slideTabView setSelectedPageIndex:0];
    
    [self.slideTabView.tabBar setSeparatorLineInsetTop:8];
    [self.slideTabView.tabBar setSeparatorColor:[UIColor cyanColor]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%@", self.slideTabView);
    
    [self.slideTabView.tabBar setBarButtonMinWidth:80];
}


@end
