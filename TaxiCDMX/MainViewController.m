//
//  MainViewController.m
//  TaxiCDMX
//
// Carlos Castellanos
// rockarlos@me.com
// @rockarloz
//

#import "MainViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

@synthesize menuBtn,scrollView,pageControl;

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
    if (delegate.marca!=nil && delegate.submarca!=nil && delegate.anio!=nil) {
        _marca.text=delegate.marca;
        _submarca.text=delegate.submarca;
        _modelo.text=delegate.anio;
    }
    
    _top.backgroundColor=[UIColor colorWithRed:0.573 green:0.467 blue:0.282 alpha:1];
    _bottom.backgroundColor=[UIColor colorWithRed:0.573 green:0.467 blue:0.282 alpha:1];
    
    self.view.backgroundColor=[UIColor colorWithRed:0.937 green:0.204 blue:0.082 alpha:1]; /*#ef3415*/
    
    [super viewDidLoad];
	
    // Do any additional setup after loading the view.
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
  
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    
    self.menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(8, 21, 34, 24);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.menuBtn];
    
   
    //[self llamada_asincrona];
    [self cargar_contenido];
   }

-(void)cargar_contenido{

    //inicia pagecontroller
 
    paginas=[[NSArray alloc]initWithObjects:@"1",@"2",@"3", nil];
    for (int i = 0; i < [paginas count]; i++) {
        if (i==0) {
           
            CGRect frame;
            frame.origin.x = (self.scrollView.frame.size.width * i)+38;
            frame.origin.y = 0;
            frame.size.height =140;
            frame.size.width=162;//self.scrollView.frame.size;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            //label
            
            CGRect frame2;
            frame2.origin.x = (self.scrollView.frame.size.width * i)+38;
            frame2.origin.y = 100;
            frame2.size.height =140;
            frame2.size.width=162;//self.scrollView.frame.size;
            UILabel *registro=[[UILabel alloc]initWithFrame:frame2];
            [registro setFont:[UIFont systemFontOfSize:12]];
            
            if ([delegate.registrado isEqualToString:@"true"]) {
                imageView.image = [UIImage imageNamed:@"registrado.png"];
                registro.text=@"Taxi Registrado en SETRAVI";
            }
            else{
                imageView.image = [UIImage imageNamed:@"noregistrado.png"];
                registro.text=@"Taxi No Registrado en SETRAVI";
            }
            [registro adjustsFontSizeToFitWidth];
            
            [self.scrollView addSubview:registro];
            [self.scrollView addSubview:imageView];
                   }
        else if (i==1){
            CGRect frame;
            frame.origin.x = (self.scrollView.frame.size.width * i)+38;
            frame.origin.y = 0;
            frame.size.height =140;
            frame.size.width=162;//self.scrollView.frame.size;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
            //label
            
            CGRect frame2;
            frame2.origin.x = (self.scrollView.frame.size.width * i)+38;
            frame2.origin.y = 100;
            frame2.size.height =140;
            frame2.size.width=162;//self.scrollView.frame.size;
            UILabel *registro=[[UILabel alloc]initWithFrame:frame2];
            [registro setFont:[UIFont systemFontOfSize:12]];
            
            
            //Guardamos la fecha actual en la variable hoy
            NSDate *hoy = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSString *fecha_actual = [dateFormatter stringFromDate: hoy];
            
            NSDateFormatter *df= [[NSDateFormatter alloc] init];
            
            [df setDateFormat:@"yyyy-MM-dd"];
            NSDate *dt1 = [[NSDate alloc] init];
            
            NSDate *dt2 = [[NSDate alloc] init];
            
            dt1=[df dateFromString:fecha_actual];
            
            dt2=[df dateFromString:[[delegate.verificaciones objectAtIndex:0] objectForKey:@"vigencia"]];
            
            NSComparisonResult result;
            //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
            
            result = [dt1 compare:dt2]; // comparing two dates
            
            if(result==NSOrderedAscending){
                
                imageView.image = [UIImage imageNamed:@"green_taxi.png"];
            registro.text=[[delegate.verificaciones objectAtIndex:0] objectForKey:@"vigencia"];
            }
            else if(result==NSOrderedDescending)
            {
            imageView.image = [UIImage imageNamed:@"pollution_taxi.png"];
            registro.text=[[delegate.verificaciones objectAtIndex:0] objectForKey:@"vigencia"];
             }
            else
            {
                imageView.image = [UIImage imageNamed:@"green_taxi.png"];
                registro.text=[[delegate.verificaciones objectAtIndex:0] objectForKey:@"vigencia"];
   
            }
            [self.scrollView addSubview:registro];
            [self.scrollView addSubview:imageView];
        
            
        }
        else{
            CGRect frame;
            frame.origin.x = (self.scrollView.frame.size.width * i)+20;
            frame.origin.y = 0;
            frame.size = self.scrollView.frame.size;
            
            CGRect frame2;
            frame2.origin.x = (self.scrollView.frame.size.width * i)+20;
            frame2.origin.y = -20;
            frame2.size = self.scrollView.frame.size;
            UILabel *pagina=[[UILabel alloc] init];
            UILabel *infracciones=[[UILabel alloc] init];
            if([delegate.infracciones count]==0){
              infracciones.text=[NSString stringWithFormat:@"Nunca ha sido infraccionado"];
            }
            else{
                infracciones.text=[NSString stringWithFormat:@"%i",[delegate.infracciones count]];
            }
            infracciones.frame=frame2;
            pagina.frame=frame;
            if ([delegate.tenencias objectForKey:@"adeudos"]==NULL) {
                pagina.text=@"no tiene adeudos";
            }
            else{
            pagina.text=[delegate.tenencias objectForKey:@"adeudos"];
            }
            [self.scrollView addSubview:infracciones];
            [self.scrollView addSubview:pagina];
            
        }
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [paginas count], scrollView.frame.size.height);
}
-(IBAction)volver:(id)sender
{
    ViewController *volver = [[self storyboard] instantiateViewControllerWithIdentifier:@"inicio"];
    
    volver.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:volver animated:YES completion:NULL];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

@end
