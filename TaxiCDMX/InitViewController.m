//
//  InitViewController.m
//  TaxiCDMX
//
// Carlos Castellanos
// rockarlos@me.com
// @rockarloz
//

#import "InitViewController.h"
#import "AppDelegate.h"
@interface InitViewController ()

@end

@implementation InitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    //self.view.backgroundColor=[UIColor colorWithRed:0.573 green:0.467 blue:0.282 alpha:1]; /*#927748*/
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    AppDelegate *delegate;
    delegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ( [delegate.alto intValue] < 568) {
        
        NSLog(@"iphone 3.5");
        self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Taxi1"];
    }
    else{
        self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Taxi"];
        NSLog(@"iphone 4");
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
