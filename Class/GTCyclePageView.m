//
//  GTCyclePageView.m
//  GTCyclePageView
//
//  Created by 龚涛 on 11/14/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import "GTCyclePageView.h"

@interface GTCyclePageView (Private)

/* Remove all displayed cells into unusable dictionary.
 */
- (void)_clearData;

/* Update all displayed cells' frames.
 */
- (void)_layoutCells;

/* Change the current page, relayout displayed cells.
 */
- (void)_updatePageChange;

/* Remove a displayed cell into unusable dictionary.
 */
- (void)_enqueueReusableCell:(GTCyclePageViewCell *)cell;

/* Return a GTCyclePageViewCell object from DataSource.
 */
- (GTCyclePageViewCell *)_cyclePageViewWithIndex:(NSUInteger)index;

- (void)_touchCell:(UITapGestureRecognizer *)gesture;

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
    
    int pageNum = self.numberOfPages;
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
        int pageNum = self.numberOfPages;
        [self _enqueueReusableCell:[_usingArray lastObject]];
        _currentPage = (_currentPage-1+pageNum)%pageNum;
        int lastPage = (_currentPage-1+pageNum)%pageNum;
        GTCyclePageViewCell *cell = [self _cyclePageViewWithIndex:lastPage];
        [_usingArray insertObject:cell atIndex:0];
        [_scrollView addSubview:cell];
        [self _layoutCells];
    }
    else if (_scrollView.contentOffset.x > 2*self.bounds.size.width-10.0) {
        int pageNum = self.numberOfPages;
        [self _enqueueReusableCell:[_usingArray objectAtIndex:0]];
        _currentPage = (_currentPage+1)%pageNum;
        int nextPage = (_currentPage+1)%pageNum;
        GTCyclePageViewCell *cell = [self _cyclePageViewWithIndex:nextPage];
        [_usingArray addObject:cell];
        [_scrollView addSubview:cell];
        [self _layoutCells];
    }
    
    if ([self.delegate respondsToSelector:@selector(didPageChangedCyclePageView:)]) {
        [self.delegate didPageChangedCyclePageView:self];
    }
}

- (void)_enqueueReusableCell:(GTCyclePageViewCell *)cell
{
    [_usingArray removeObject:cell];
    [cell removeFromSuperview];
    NSMutableArray *array = _reuseDic[cell.cellIdentifier];
    [array addObject:cell];
}

- (GTCyclePageViewCell *)_cyclePageViewWithIndex:(NSUInteger)index
{
    GTCyclePageViewCell * cell = [self.dataSource cyclePageView:self index:index];
    cell.page = index;
    if ([[cell gestureRecognizers] count] == 0) {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_touchCell:)];
        [gesture setNumberOfTouchesRequired:1];
        [gesture setNumberOfTapsRequired:1];
        [cell addGestureRecognizer:gesture];
    }
    return cell;
}

- (void)_touchCell:(UITapGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(cyclePageView:didTouchCellAtIndex:)]) {
        int index = [_usingArray indexOfObject:gesture.view];
        int pageNum = self.numberOfPages;
        index = (_currentPage+index-1+pageNum)%pageNum;
        [self.delegate cyclePageView:self didTouchCellAtIndex:index];
    }
}

#pragma mark - public

- (void)reloadData
{
    [self _clearData];
    
    int pageNum = self.numberOfPages;
    if (pageNum == 0) {
        _currentPage = 0;
        return;
    }
    else if (pageNum == 1) {
        GTCyclePageViewCell *cell = [self _cyclePageViewWithIndex:_currentPage];
        [_scrollView addSubview:cell];
        [_usingArray addObject:cell];
    }
    else {
        if (_currentPage >= pageNum) {
            _currentPage = pageNum-1;
        }
        //last page init
        int lastPage = (_currentPage-1+pageNum)%pageNum;
        GTCyclePageViewCell *cell = [self _cyclePageViewWithIndex:lastPage];
        [_usingArray addObject:cell];
        [_scrollView addSubview:cell];
        
        //current page init
        cell = [self _cyclePageViewWithIndex:_currentPage];
        [_usingArray addObject:cell];
        [_scrollView addSubview:cell];
        
        //next page init
        int nextPage = (_currentPage+1)%pageNum;
        cell = [self _cyclePageViewWithIndex:nextPage];
        [_usingArray addObject:cell];
        [_scrollView addSubview:cell];
    }
    
    [self _layoutCells];
}

- (GTCyclePageViewCell *)cyclePageViewCellAtIndex:(NSUInteger)index
{
    __block GTCyclePageViewCell *cell = nil;
    [_usingArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        if (index == ((GTCyclePageViewCell *)obj).page) {
            cell = obj;
            return;
        }
    }];
    return cell;
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

- (void)scrollToNextPage:(BOOL)animated
{
    if (self.numberOfPages < 2) {
        return;
    }
    CGRect frame = self.scrollView.bounds;
    frame.origin.x = 2*frame.size.width;
    [_scrollView scrollRectToVisible:frame animated:animated];
}

- (void)scrollToPrePage:(BOOL)animated
{
    if (self.numberOfPages < 2) {
        return;
    }
    CGRect frame = self.scrollView.bounds;
    frame.origin.x = 0.0;
    [_scrollView scrollRectToVisible:frame animated:animated];
}

#pragma mark - Property

- (NSUInteger)numberOfPages
{
    if (self.dataSource) {
        return [self.dataSource numberOfPagesInCyclePageView:self];
    }
    return 0;
}

- (void)setCurrentPage:(NSUInteger)currentPage
{
    if (_currentPage != currentPage && currentPage < self.numberOfPages) {
        _currentPage = currentPage;
        [self reloadData];
        
        if ([self.delegate respondsToSelector:@selector(didPageChangedCyclePageView:)]) {
            [self.delegate didPageChangedCyclePageView:self];
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self _updatePageChange];
    
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.delegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self _updatePageChange];
    }
    
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self _updatePageChange];
    
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.delegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.delegate scrollViewDidScrollToTop:scrollView];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.delegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.delegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if ([self.delegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.delegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

@end
