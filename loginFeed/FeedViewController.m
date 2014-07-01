//
//  FeedViewController.m
//  loginFeed
//
//  Created by Natalia Fisher on 6/29/14.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *feedScroll;
@property (weak, nonatomic) IBOutlet UIImageView *feedImage;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *feedActivity;


@end

@implementation FeedViewController


// Navigation bar should have the search button and messages button.
// TO DO: Add icons for buttons
// TO DO: Add tab bar (fake for now)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.feedScroll.contentSize=CGSizeMake(320,1025);
    

    
    // Make sure image in scrollview is initiall hidden
    self.feedImage.hidden = YES;
    
    // Show the loading indicator in the button
    [self.feedActivity startAnimating];
    
    // After a 2 second delay, show the scrollview
    [self performSelector:@selector(feedLoad) withObject:nil afterDelay:2];

  
}

- (void)feedLoad {
    // Stop the activity indicator
    self.feedActivity.hidden = YES;

    // show the feed
    self.feedImage.hidden = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
