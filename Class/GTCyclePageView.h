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

@protocol GTCyclePageViewDelegate;

@interface GTCyclePageView : UIView <UIScrollViewDelegate>
{
    //Store unusable cell array by cellIdentifier.
    NSDictionary *_reuseDic;
    
    //Store displayed cells.
    NSMutableArray *_usingArray;
}

/* The current page of GTCyclePageViewCell object.
 Set it to change page;
 */
@property (nonatomic, assign) NSUInteger currentPage;

/* The page number of GTCyclePageViewCell object.
 */
@property (nonatomic, readonly) NSUInteger numberOfPages;

/* Return the GTCyclePageViewCell object from unusable array by cellIdentifier.
 */
@property (nonatomic, retain) UIScrollView *scrollView;

@property (nonatomic, assign) id<GTCyclePageViewDataSource> dataSource;

@property (nonatomic, assign) id<GTCyclePageViewDelegate> delegate;

- (void)reloadData;

/* Return the GTCyclePageViewCell object by index.
 If cell is not displayed, return nil.
 */
- (GTCyclePageViewCell *)cyclePageViewCellAtIndex:(NSUInteger)index;

/* Return the GTCyclePageViewCell object from unusable array by cellIdentifier.
 */
- (GTCyclePageViewCell *)dequeueReusableCellWithIdentifier:(NSString *)cellIdentifier;

- (void)scrollToNextPage:(BOOL)animated;

- (void)scrollToPrePage:(BOOL)animated;

@end


@protocol GTCyclePageViewDataSource <NSObject>

@required

/* Return the number of pages.
 */
- (NSUInteger)numberOfPagesInCyclePageView:(GTCyclePageView *)cyclePageView;

/* Return the GTCyclePageViewCell object by index.
 */
- (GTCyclePageViewCell *)cyclePageView:(GTCyclePageView *)cyclePageView index:(NSUInteger)index;

@end

@protocol GTCyclePageViewDelegate <UIScrollViewDelegate>

@optional

- (void)didPageChangedCyclePageView:(GTCyclePageView *)cyclePageView;

- (void)cyclePageView:(GTCyclePageView *)cyclePageView didTouchCellAtIndex:(NSUInteger)index;

@end
