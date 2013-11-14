//
//  GTCyclePageViewCell.m
//  GTCyclePageView
//
//  Created by 龚涛 on 11/14/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import "GTCyclePageViewCell.h"

@implementation GTCyclePageViewCell

- (id)initWithReuseIdentifier:(NSString *)cellIdentifier
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _cellIdentifier = cellIdentifier;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
