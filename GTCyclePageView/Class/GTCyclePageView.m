//
//  GTCyclePageView.m
//  GTCyclePageView
//
//  Created by 龚涛 on 11/14/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import "GTCyclePageView.h"

@interface GTCyclePageView (Private)

- (void)_clearData;

- (void)_layoutCells;

- (void)_updatePageChange;

- (void)_enqueueReusableCell:(GTCyclePageViewCell *)cell;

@end

@implementation GTCyclePageView

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        _currentPage = 0;
        
        _reuseDic = [[NSDictionary alloc] init];
        _usingArray = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self _layoutCells];
}

#pragma mark - private

- (void)_clearData
{
    _scrollView.contentSize = _scrollView.bounds.size;
    
    [[_scrollView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        if ([obj isKindOfClass:[GTCyclePageViewCell class]]) {
            [self _enqueueReusableCell:obj];
        }
    }];
}

- (void)_layoutCells
{
    __block CGRect frame = self.bounds;
    _scrollView.frame = frame;
    
    int pageNum = [self numberOfPages];
    if (pageNum < 2) {
        _scrollView.contentSize = self.bounds.size;
        _scrollView.contentOffset = CGPointZero;
    }
    else {
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width*3, self.bounds.size.height);
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0.0);
    }
    
    [_usingArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        GTCyclePageViewCell *cell = obj;
        cell.frame = frame;
        frame.origin.x += frame.size.width;
    }];
}

- (void)_updatePageChange
{
    if (_scrollView.contentOffset.x < 10.0) {
        int pageNum = [self numberOfPages];
        [self _enqueueReusableCell:[_usingArray lastObject]];
        _currentPage = (_currentPage-1+pageNum)%pageNum;
        int lastPage = (_currentPage-1+pageNum)%pageNum;
        GTCyclePageViewCell *cell = [self.dataSource cyclePageView:self index:lastPage];
        [_usingArray insertObject:cell atIndex:0];
        [_scrollView addSubview:cell];
        [self _layoutCells];
    }
    else if (_scrollView.contentOffset.x > 2*self.bounds.size.width-10.0) {
        int pageNum = [self numberOfPages];
        [self _enqueueReusableCell:[_usingArray objectAtIndex:0]];
        _currentPage = (_currentPage+1)%pageNum;
        int nextPage = (_currentPage+1)%pageNum;
        GTCyclePageViewCell *cell = [self.dataSource cyclePageView:self index:nextPage];
        [_usingArray addObject:cell];
        [_scrollView addSubview:cell];
        [self _layoutCells];
    }
}

- (void)_enqueueReusableCell:(GTCyclePageViewCell *)cell
{
    [_usingArray removeObject:cell];
    [cell removeFromSuperview];
    NSMutableArray *array = _reuseDic[cell.cellIdentifier];
    [array addObject:cell];
}

#pragma mark - public

- (void)reloadData
{
    [self _clearData];
    
    int pageNum = [self numberOfPages];
    if (pageNum == 0) {
        _currentPage = 0;
        return;
    }
    else if (pageNum == 1) {
        GTCyclePageViewCell *cell = [self.dataSource cyclePageView:self index:_currentPage];
        [_scrollView addSubview:cell];
        [_usingArray addObject:cell];
    }
    else {
        if (_currentPage >= pageNum) {
            _currentPage = pageNum-1;
        }
        //last page
        int lastPage = (_currentPage-1+pageNum)%pageNum;
        GTCyclePageViewCell *cell = [self.dataSource cyclePageView:self index:lastPage];
        [_usingArray addObject:cell];
        [_scrollView addSubview:cell];
        
        //current page
        cell = [self.dataSource cyclePageView:self index:_currentPage];
        [_usingArray addObject:cell];
        [_scrollView addSubview:cell];
        
        //next page
        int nextPage = (_currentPage+1)%pageNum;
        cell = [self.dataSource cyclePageView:self index:nextPage];
        [_usingArray addObject:cell];
        [_scrollView addSubview:cell];
    }
    
    [self _layoutCells];
}

- (NSUInteger)numberOfPages
{
    if (self.dataSource) {
        return [self.dataSource numberOfPagesInCyclePageView:self];
    }
    return 0;
}

- (GTCyclePageViewCell *)dequeueReusableCellWithIdentifier:(NSString *)cellIdentifier
{
    NSMutableArray *array = _reuseDic[cellIdentifier];
    if (array && array.count>0) {
        id obj = [array lastObject];
        [array removeObject:obj];
        return obj;
    }
    return nil;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self _updatePageChange];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self _updatePageChange];
    }
}

@end
