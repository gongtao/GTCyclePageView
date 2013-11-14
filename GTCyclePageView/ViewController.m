//
//  ViewController.m
//  GTCyclePageView
//
//  Created by 龚涛 on 11/14/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _cyclePageView = [[GTCyclePageView alloc] initWithFrame:self.view.bounds];
    _cyclePageView.dataSource = self;
    [self.view addSubview:_cyclePageView];
    
    [_cyclePageView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GTCyclePageViewDataSource

- (NSUInteger)numberOfPagesInCyclePageView:(GTCyclePageView *)cyclePageView
{
    return 5;
}

- (GTCyclePageViewCell *)cyclePageView:(GTCyclePageView *)cyclePageView index:(NSUInteger)page
{
    static NSString *cellIdentifier = @"cellIdentifier";
    GTCyclePageViewCell *cell = [cyclePageView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[GTCyclePageViewCell alloc] initWithReuseIdentifier:cellIdentifier];
    }
    
    switch (page) {
        case 0: {
            cell.backgroundColor = [UIColor purpleColor];
            break;
        }
        case 1: {
            cell.backgroundColor = [UIColor redColor];
            break;
        }
        case 2: {
            cell.backgroundColor = [UIColor blueColor];
            break;
        }
        case 3: {
            cell.backgroundColor = [UIColor yellowColor];
            break;
        }
        case 4: {
            cell.backgroundColor = [UIColor greenColor];
            break;
        }
        default:
            break;
    }
    
    return cell;
}

@end
