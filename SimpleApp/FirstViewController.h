//
//  FirstViewController.h
//  SimpleApp
//
//  Created by Edward Louw on 6/8/15.
//  Copyright (c) 2015 Edward Louw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleJsonObject.h"

@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) TableTypes controllerType;

@end

