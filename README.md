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
