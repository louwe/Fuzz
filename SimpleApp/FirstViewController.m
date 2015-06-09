//
//  FirstViewController.m
//  SimpleApp
//
//  Created by Edward Louw on 6/8/15.
//  Copyright (c) 2015 Edward Louw. All rights reserved.
//

#import "FirstViewController.h"
#import "SimpleJsonObject.h"
#import "DetailViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) SimpleJsonObjectContainer* objectContainer;

@end

@implementation FirstViewController

// This function queries the data store for the object we need to display at the specified index path.
// The object returned will depend on the current mode of the table display.
- (SimpleJsonObject*)itemAtIndex:(NSIndexPath*) indexPath {
    SimpleJsonObject* retVal = nil;
    if(self.controllerType == TableTypeText) {
        retVal = [self.objectContainer textObjectAtIndex:indexPath.row];
    } else if(self.controllerType == TableTypeImage) {
        retVal = [self.objectContainer imageObjectAtIndex:indexPath.row];
    } else {
        retVal = [self.objectContainer objectAtIndex:indexPath.row];
    }
    return retVal;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize button titles.
    self.controllerType = TableTypeAll;
    [(UIViewController*) (self.tabBarController.viewControllers[0]) setTitle:@"All"];
    [(UIViewController*) (self.tabBarController.viewControllers[1]) setTitle:@"Text"];
    [(UIViewController*) (self.tabBarController.viewControllers[2]) setTitle:@"Image"];
    NSURLSession* sharedSession = [NSURLSession sharedSession];
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://quizzes.fuzzstaging.com/quizzes/mobile/1/data.json"]];
    
    // Parse to container and reload table data when finished.
    FirstViewController* __block blockSelf = self;
    NSURLSessionDataTask* task = [sharedSession dataTaskWithRequest:urlRequest completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        blockSelf.objectContainer = [[SimpleJsonObjectContainer alloc] initWithJSON:data];
        [blockSelf.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        blockSelf = nil;
    }];
    
    // Fetch the JSON object.
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.tableView removeFromSuperview];
    self.objectContainer = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.objectContainer count:self.controllerType];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* retVal = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!retVal) {
        retVal = [[UITableViewCell alloc] init];
    }
    
    SimpleJsonObject* item = [self itemAtIndex:indexPath];
    NSMutableString* itemText = [NSMutableString string];
    if(item.type == SimpleTypeText) {
        [itemText appendString:@"Text: "];
    } else if(item.type == SimpleTypeImage) {
        [itemText appendString:@"Image: "];
    } else {
        [itemText appendString:@"Other: "];
    }
    [itemText appendFormat:@"%@ Date: %@ Data: %@", item.identification, item.date, item.data];
    retVal.textLabel.text = itemText;
    
    return retVal;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SimpleJsonObject* item = [self itemAtIndex:[self.tableView indexPathForSelectedRow]];
    DetailViewController* destinationVC = segue.destinationViewController;
    if(item.type == SimpleTypeImage) {
        destinationVC.url = [NSURL URLWithString:item.data];
    } else {
        destinationVC.url = nil;
    }
}

@end
