//
//  GTCyclePageView.h
//  GTCyclePageView
//
//  Created by 龚涛 on 11/14/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTCyclePageViewCell.h"

@protocol GTCyclePageViewDataSource;

@interface GTCyclePageView : UIView <UIScrollViewDelegate>
{
    NSDictionary *_reuseDic;
    
    NSMutableArray *_usingArray;
}

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, assign) id<GTCyclePageViewDataSource> dataSource;

- (void)reloadData;

- (NSUInteger)numberOfPages;

- (GTCyclePageViewCell *)dequeueReusableCellWithIdentifier:(NSString *)cellIdentifier;

@end


@protocol GTCyclePageViewDataSource <NSObject>

@required

- (NSUInteger)numberOfPagesInCyclePageView:(GTCyclePageView *)cyclePageView;

- (GTCyclePageViewCell *)cyclePageView:(GTCyclePageView *)cyclePageView index:(NSUInteger)page;

@end
