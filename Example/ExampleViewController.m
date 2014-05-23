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
    
    
    [self.slideTabView addPageForTitle:@"通知"];
    [self.slideTabView addPageForTitle:@"消息"];
    [self.slideTabView addPageForTitle:@"反馈"];
    [self.slideTabView addPageForTitle:@"广播"];
    //[self.slideTabView addPageForTitle:@"other title"];
    
    
    [self.slideTabView setSelectedPageIndex:0];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%@", self.slideTabView);
    
    [self.slideTabView.tabBar setBarButtonMinWidth:80];
}


@end
