//
//  InformacionViewController.m
//  TaxiCDMX
//
//  Created by Carlos Castellanos on 07/03/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "InformacionViewController.h"
#import "InitViewController.h"
#import "AppDelegate.h"
#import "MenuViewController.h"
@interface InformacionViewController ()

@end

@implementation InformacionViewController
{
    AppDelegate * delegate;
}
@synthesize menuBtn;
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
    delegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    
    self.menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(8, 30, 34, 24);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.menuBtn];

	// Do any additional setup after loading the view.
}


- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
