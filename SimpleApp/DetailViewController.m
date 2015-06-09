//
//  DetailViewController.m
//  SimpleApp
//
//  Created by Edward Louw on 6/9/15.
//  Copyright (c) 2015 Edward Louw. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // Load image.
    if(self.url) {
        dispatch_queue_t queue = dispatch_queue_create("imageLoaderQueue", DISPATCH_QUEUE_SERIAL);
        UIImage* __block imageToLoad = nil;
        DetailViewController* __block blockSelf = self;
        dispatch_async(queue, ^{
            imageToLoad = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.url]];
            [blockSelf.detailImageView performSelectorOnMainThread:@selector(setImage:) withObject:imageToLoad waitUntilDone:YES];
            blockSelf = nil;
        });
        self.detailWebView.hidden = YES;
        self.detailImageView.hidden = NO;
    } else { // Load web site.
        self.url = [NSURL URLWithString:DEFAULT_ADDRESS];
        [self.detailWebView loadRequest:[NSURLRequest requestWithURL:self.url]];
        self.detailWebView.hidden = NO;
        self.detailImageView.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonDidPush:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
