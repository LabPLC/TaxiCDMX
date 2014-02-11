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
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface MainViewController : UIViewController  <UIScrollViewDelegate>
{
    AppDelegate *delegate;
    NSURLConnection *postConnection;
    NSArray *paginas;
    BOOL registrado;
    BOOL verificado;
    NSString *vigencia_verificacion;
    UIView *loading;
    UIActivityIndicatorView *spinner;
}
@property (weak, nonatomic) IBOutlet UIView *top;
@property (weak, nonatomic) IBOutlet UIView *bottom;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIButton *btn_tenencias;
@property (weak, nonatomic) IBOutlet UIButton *btn_verificaciones;
@property (weak, nonatomic) IBOutlet UIButton *btn_infracciones;
@property (strong, nonatomic) UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UILabel *resultado;
@property (weak, nonatomic) IBOutlet UILabel *marca;
@property (weak, nonatomic) IBOutlet UILabel *submarca;
@property (weak, nonatomic) IBOutlet UILabel *modelo;
-(IBAction)volver:(id)sender;
@end
