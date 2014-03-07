//
//  MainViewController.h
//  TaxiCDMX
//
// Carlos Castellanos
// rockarlos@me.com
// @rockarloz
//


#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ViewController.h"


@interface MainViewController : UIViewController  <UIScrollViewDelegate>
{
    AppDelegate *delegate;
    //paginas para el pagecontroller
    NSArray *paginas;
   

}
@property (weak, nonatomic) IBOutlet UIView *top;
@property (weak, nonatomic) IBOutlet UIView *bottom;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;


@property (strong, nonatomic) UIButton *menuBtn;

@property (weak, nonatomic) IBOutlet UILabel *marca;
@property (weak, nonatomic) IBOutlet UILabel *submarca;
@property (weak, nonatomic) IBOutlet UILabel *modelo;
-(IBAction)volver:(id)sender;
-(IBAction)comentar:(id)sender;
@end
