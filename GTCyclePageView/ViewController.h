//
//  ViewController.h
//  GTCyclePageView
//
//  Created by 龚涛 on 11/14/13.
//  Copyright (c) 2013 龚涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTCyclePageView.h"

@interface ViewController : UIViewController <GTCyclePageViewDataSource, GTCyclePageViewDelegate>
{
    GTCyclePageView *_cyclePageView;
}

@end
