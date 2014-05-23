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
    
    
    [self.slideTabView addPageForTitle:@"One"];
    [self.slideTabView addPageForTitle:@"Two"];
    [self.slideTabView addPageForTitle:@"This is a long title"];
    [self.slideTabView addPageForTitle:@"Three"];
    [self.slideTabView addPageForTitle:@"other title"];
    
    
    [self.slideTabView setSelectedPageIndex:2];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%@", self.slideTabView);
}


@end
