//
//  ViewController.m
//  GTCyclePageView
//
//  Created by 龚涛 on 11/14/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (void)buttonPressed:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _cyclePageView = [[GTCyclePageView alloc] initWithFrame:self.view.bounds];
    _cyclePageView.dataSource = self;
    _cyclePageView.delegate = self;
    [self.view addSubview:_cyclePageView];
    
    [_cyclePageView reloadData];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10.0, 100.0, 100.0, 100.0)];
    [button setTitle:@"PrePage" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 0;
    [self.view addSubview:button];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(210.0, 100.0, 100.0, 100.0)];
    [button setTitle:@"NextPage" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1;
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    _cyclePageView.frame = self.view.bounds;
}

#pragma mark - Private

- (void)buttonPressed:(id)sender
{
    if ([sender tag] == 0) {
        [_cyclePageView scrollToPrePage:YES];
    }
    else if ([sender tag] == 1) {
        [_cyclePageView scrollToNextPage:YES];
    }
}

#pragma mark - GTCyclePageViewDataSource

- (NSUInteger)numberOfPagesInCyclePageView:(GTCyclePageView *)cyclePageView
{
    return 5;
}

- (GTCyclePageViewCell *)cyclePageView:(GTCyclePageView *)cyclePageView index:(NSUInteger)index
{
    static NSString *cellIdentifier = @"cellIdentifier";
    GTCyclePageViewCell *cell = [cyclePageView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[GTCyclePageViewCell alloc] initWithReuseIdentifier:cellIdentifier];
    }
    
    switch (index) {
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

#pragma mark - GTCyclePageViewDelegate

- (void)cyclePageView:(GTCyclePageView *)cyclePageView didTouchCellAtIndex:(NSUInteger)index
{
    NSLog(@"tap: %i", index);
}

@end
