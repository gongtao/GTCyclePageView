//
//  GTCyclePageViewCell.h
//  GTCyclePageView
//
//  Created by 龚涛 on 11/14/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTCyclePageViewCell : UIView

@property (nonatomic, retain) NSString *cellIdentifier;

- (id)initWithReuseIdentifier:(NSString *)cellIdentifier;

@end
