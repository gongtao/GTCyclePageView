## GTCyclePageView

GTCyclePageView is a view that can circularly scroll pages. The way that GTCyclePageView uses datasource to load each page view is almost the same way as `UITableView`.

It's based on `UIScrollView`, and its delegate inherit from `UIScrollViewDelegate`.

## How to get started?

- [Download GTCyclePageView](https://github.com/gongtao/GTCyclePageView/archive/master.zip) and add files under the Class folder into your project.

### GTCyclePageViewDataSource

Use GTCyclePageViewDataSource to load page contents:

```objective-c
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
    
    //Customize cell here...
    
    return cell;
}
```

### GTCyclePageViewDelegate

GTCyclePageViewDelegate inherit from `UIScrollViewDelegate`. The below method is called when the page changes.

```objective-c
- (void)didPageChangedCyclePageView:(GTCyclePageView *)cyclePageView
```

The below method is called when a displayed cell is tapped.

```objective-c
- (void)cyclePageView:(GTCyclePageView *)cyclePageView didTouchCellAtIndex:(NSUInteger)index
```

### Others

Return the GTCyclePageViewCell object from unusable array by cellIdentifier.

```objective-c
- (GTCyclePageViewCell *)dequeueReusableCellWithIdentifier:(NSString *)cellIdentifier;
```

Scroll to next or pre page.

```objective-c
- (void)scrollToNextPage:(BOOL)animated;

- (void)scrollToPrePage:(BOOL)animated;
```

The current page of GTCyclePageViewCell object. Set it to change page.

```objective-c
@property (nonatomic, assign) NSUInteger currentPage;
```

## Contact

龚涛    Gong Tao    mail: gongtaoatbupt@gmail.com


