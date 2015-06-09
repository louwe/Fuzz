//
//  RootViewController.m
//  SimpleApp
//
//  Created by Edward Louw on 6/9/15.
//  Copyright (c) 2015 Edward Louw. All rights reserved.
//

#import "RootViewController.h"
#import "FirstViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    // Tell the next controller the type of information to display.
    FirstViewController* destinationVC = (FirstViewController*)viewController;
    destinationVC.controllerType = self.selectedIndex;
}

@end
