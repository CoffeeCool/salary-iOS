//
//  ThirdViewController.h
//  Example
//
//  Created by Coffee on 15/6/15.
//  Copyright (c) 2015年 Yalantis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YALTabBarInteracting.h"
@interface ThirdViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, YALTabBarInteracting>
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;

@end
