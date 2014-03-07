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
#import "ComentarViewController.h"
#import "InfraccionesViewController.h"

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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    delegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (delegate.marca!=nil && delegate.submarca!=nil && delegate.anio!=nil) {
        _marca.text=delegate.marca;
        _submarca.text=delegate.submarca;
        _modelo.text=delegate.anio;
    }
    
    
    
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
    menuBtn.frame = CGRectMake(8, 30, 34, 24);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.menuBtn];
    
    [self cargar_contenido];
}

-(void)cargar_contenido{
    
    //inicia pagecontroller
    
    paginas=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4", nil];
    for (int i = 0; i < [paginas count]; i++) {
        
        if (i==0) {
            
            UIImageView *imageView;
            UILabel *registro;
            UILabel *argumento;
            CGRect frame;
            CGRect frame2;
            CGRect frame_argumento;
            
            if ( [delegate.alto intValue] < 568) {
                
                
                frame.origin.x = (self.scrollView.frame.size.width * i)+65;
                frame.origin.y = 15;
                frame.size.height =150;
                frame.size.width=150;
                imageView = [[UIImageView alloc] initWithFrame:frame];
                
                
                frame2.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame2.origin.y = frame.size.height+10;
                frame2.size.height =60;
                frame2.size.width=250;//self.scrollView.frame.size; ancho
                registro=[[UILabel alloc]initWithFrame:frame2];
                [registro setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
                
                registro.numberOfLines = 2;
                registro.textAlignment = NSTextAlignmentCenter;
                
                
                frame_argumento.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame_argumento.origin.y = frame.size.height+60;
                frame_argumento.size.height =83;
                frame_argumento.size.width=240;//self.scrollView.frame.size; ancho
                argumento=[[UILabel alloc]initWithFrame:frame_argumento];
                [argumento setFont:[UIFont systemFontOfSize:12]];
                argumento.numberOfLines = 6;
                argumento.textAlignment = NSTextAlignmentCenter;
            }
            
            else{
                
                frame.origin.x = (self.scrollView.frame.size.width * i)+30;
                frame.origin.y = 15;
                frame.size.height =220;
                frame.size.width=220;//self.scrollView.frame.size;
                imageView = [[UIImageView alloc] initWithFrame:frame];
                //label
                
                
                frame2.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame2.origin.y = frame.size.height+5;
                frame2.size.height =140;
                frame2.size.width=240;//self.scrollView.frame.size; ancho
                registro=[[UILabel alloc]initWithFrame:frame2];
                [registro setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
                //[registro setFont:[UIFont systemFontOfSize:12]];
                registro.numberOfLines = 2;
                registro.textAlignment = NSTextAlignmentCenter;
                
                
                frame_argumento.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame_argumento.origin.y = frame.size.height+50;
                frame_argumento.size.height =140;
                frame_argumento.size.width=240;//self.scrollView.frame.size; ancho
                argumento=[[UILabel alloc]initWithFrame:frame_argumento];
                [argumento setFont:[UIFont systemFontOfSize:12]];
                argumento.numberOfLines = 6;
                argumento.textAlignment = NSTextAlignmentCenter;
            }
            
            
            
            
            if ([delegate.registrado isEqualToString:@"true"]) {
                imageView.image = [UIImage imageNamed:@"Taxi_Si.png"];
                registro.text=@"Esta placa SI se encuentra registrada como taxi con SETRAVI";
                registro.textColor=[UIColor colorWithRed:0.784f green:0.718f blue:0.588f alpha:1.0f];
                argumento.text=@"Esto significa que este vehículo está al día en trámites como: revista vehicular, verificación de taxímetro y regularidad en el estado de concesión de servicio de taxi.";
                
                
            }
            else{
                imageView.image = [UIImage imageNamed:@"Taxi_No.png"];
                registro.text=@"Esta placa NO se encuentra registrada como taxi con SETRAVI";
                registro.textColor=[UIColor colorWithRed:0.557f green:0.031f blue:0.051f alpha:1.0f];
                argumento.text=@"Si abordas este vehículo, sugerimos que lo hagas con precaución. Es posible que este vehículo tenga algún trámite pendiente o esté operando de manera ilegal.";
                
            }
            
            [argumento adjustsFontSizeToFitWidth];
            [registro adjustsFontSizeToFitWidth];
            [self.scrollView addSubview:argumento];
            [self.scrollView addSubview:registro];
            [self.scrollView addSubview:imageView];
            
        }
        
        else if (i==1){
            UIImageView *imageView;
            UILabel *registro;
            UILabel *argumento;
            CGRect frame;
            CGRect frame2;
            CGRect frame_argumento;
            if ( [delegate.alto intValue] < 568) {
                
                
                frame.origin.x = (self.scrollView.frame.size.width * i)+65;
                frame.origin.y = 15;
                frame.size.height =150;
                frame.size.width=150;
                imageView = [[UIImageView alloc] initWithFrame:frame];
                
                
                frame2.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame2.origin.y = frame.size.height+10;
                frame2.size.height =60;
                frame2.size.width=250;//self.scrollView.frame.size; ancho
                registro=[[UILabel alloc]initWithFrame:frame2];
                [registro setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
                
                registro.numberOfLines = 3;
                registro.textAlignment = NSTextAlignmentCenter;
                
                
                frame_argumento.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame_argumento.origin.y = frame.size.height+60;
                frame_argumento.size.height =83;
                frame_argumento.size.width=240;//self.scrollView.frame.size; ancho
                argumento=[[UILabel alloc]initWithFrame:frame_argumento];
                [argumento setFont:[UIFont systemFontOfSize:12]];
                argumento.numberOfLines = 6;
                argumento.textAlignment = NSTextAlignmentCenter;
            }
            else{
                
                frame.origin.x = (self.scrollView.frame.size.width * i)+30;
                frame.origin.y = 15;
                frame.size.height =220;
                frame.size.width=220;//self.scrollView.frame.size;
                imageView = [[UIImageView alloc] initWithFrame:frame];
                //label
                
                
                frame2.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame2.origin.y = frame.size.height+5;
                frame2.size.height =140;
                frame2.size.width=240;//self.scrollView.frame.size; ancho
                registro=[[UILabel alloc]initWithFrame:frame2];
                [registro setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
                //[registro setFont:[UIFont systemFontOfSize:12]];
                registro.numberOfLines = 3;
                registro.textAlignment = NSTextAlignmentCenter;
                
                
                frame_argumento.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame_argumento.origin.y = frame.size.height+60;
                frame_argumento.size.height =140;
                frame_argumento.size.width=240;//self.scrollView.frame.size; ancho
                argumento=[[UILabel alloc]initWithFrame:frame_argumento];
                [argumento setFont:[UIFont systemFontOfSize:12]];
                argumento.numberOfLines = 6;
                argumento.textAlignment = NSTextAlignmentCenter;
            }
            
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
            NSMutableArray *nada=@"placa_no_localizada";
            
            if([delegate.verificaciones isEqual:nada]){
                imageView.image = [UIImage imageNamed:@"Verificado_no.png"];
                registro.text=@"No se encontro registro alguno de este taxi.";
                registro.textColor=[UIColor colorWithRed:0.557f green:0.031f blue:0.051f alpha:1.0f];
                argumento.text=@"No se encontro resgistro de verificaciones en SEDEMA.";
            }
            
            else{
                dt2=[df dateFromString:[[delegate.verificaciones objectAtIndex:0] objectForKey:@"vigencia"]];
                
                NSComparisonResult result;
                result = [dt1 compare:dt2];
                //comparamos las fechas
                if(result==NSOrderedAscending){
                    
                    imageView.image = [UIImage imageNamed:@"Verificado_si.png"];
                    registro.text=@"Este vehículo ha hecho su verificación a tiempo y por lo tanto CUMPLE CON LA LEY AMBIENTAL DEL DISTRITO FEDERAL.";
                    registro.textColor=[UIColor colorWithRed:0.784f green:0.718f blue:0.588f alpha:1.0f];
                    argumento.text=@"Esto significa que el vehículo está haciendo lo posible por mantener sus emisiones de carbon por debajo de las establecidas como límite por la ley.";
                }
                
                else if(result==NSOrderedDescending)
                {
                    imageView.image = [UIImage imageNamed:@"Verificado_no.png"];
                    registro.text=@"Este vehículo NO ha hecho su verificación a tiempo y por lo tanto NO CUMPLE CON LA LEY AMBIENTAL DEL DISTRITO FEDERAL.";
                    registro.textColor=[UIColor colorWithRed:0.557f green:0.031f blue:0.051f alpha:1.0f];
                    argumento.text=@"Esto significa que posiblemente las misiones de carbon del vehículo están por encima de los límites establecidas como límite por la ley.";
                    
                }
                
                else
                {
                    registro.numberOfLines = 5;
                    registro.textAlignment = NSTextAlignmentCenter;
                    registro.text=@"Este vehículo ha hecho su verificación a tiempo y por lo tanto CUMPLE CON LA LEY AMBIENTAL DEL DISTRITO FEDERAL.";
                    imageView.image = [UIImage imageNamed:@"Verificado_si.png"];
                    registro.textColor=[UIColor colorWithRed:0.784f green:0.718f blue:0.588f alpha:1.0f];
                    argumento.text=@"Esto significa que el vehículo está haciendo lo posible por mantener sus emisiones de carbon por debajo de las establecidas como límite por la ley.";
                    
                }
                
            }
            
            [registro adjustsFontSizeToFitWidth];
            [argumento adjustsFontSizeToFitWidth];
            [self.scrollView addSubview:argumento];
            [self.scrollView addSubview:registro];
            [self.scrollView addSubview:imageView];
            
            
        }
        else if (i==2){
            
            UIImageView *imageView;
            UILabel *registro;
            UILabel *argumento;
            CGRect frame;
            CGRect frame2;
            CGRect frame_argumento;
            if ( [delegate.alto intValue] < 568) {
                
                
                frame.origin.x = (self.scrollView.frame.size.width * i)+65;
                frame.origin.y = 15;
                frame.size.height =150;
                frame.size.width=150;
                imageView = [[UIImageView alloc] initWithFrame:frame];
                
                
                frame2.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame2.origin.y = frame.size.height+10;
                frame2.size.height =60;
                frame2.size.width=250;//self.scrollView.frame.size; ancho
                registro=[[UILabel alloc]initWithFrame:frame2];
                [registro setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
                
                registro.numberOfLines = 2;
                registro.textAlignment = NSTextAlignmentCenter;
                
                
                frame_argumento.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame_argumento.origin.y = frame.size.height+60;
                frame_argumento.size.height =83;
                frame_argumento.size.width=240;//self.scrollView.frame.size; ancho
                argumento=[[UILabel alloc]initWithFrame:frame_argumento];
                [argumento setFont:[UIFont systemFontOfSize:12]];
                argumento.numberOfLines = 6;
                argumento.textAlignment = NSTextAlignmentCenter;
            }
            else{
                
                frame.origin.x = (self.scrollView.frame.size.width * i)+30;
                frame.origin.y = 15;
                frame.size.height =220;
                frame.size.width=220;//self.scrollView.frame.size;
                imageView = [[UIImageView alloc] initWithFrame:frame];
                //label
                
                
                frame2.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame2.origin.y = frame.size.height+5;
                frame2.size.height =140;
                frame2.size.width=240;//self.scrollView.frame.size; ancho
                registro=[[UILabel alloc]initWithFrame:frame2];
                [registro setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
                //[registro setFont:[UIFont systemFontOfSize:12]];
                registro.numberOfLines = 2;
                registro.textAlignment = NSTextAlignmentCenter;
                
                
                frame_argumento.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame_argumento.origin.y = frame.size.height+50;
                frame_argumento.size.height =140;
                frame_argumento.size.width=240;//self.scrollView.frame.size; ancho
                argumento=[[UILabel alloc]initWithFrame:frame_argumento];
                [argumento setFont:[UIFont systemFontOfSize:12]];
                argumento.numberOfLines = 6;
                argumento.textAlignment = NSTextAlignmentCenter;
            }
            
            
            if ([delegate.tenencias objectForKey:@"adeudos"]==NULL) {
                
                if([delegate.infracciones count]==0){
                    imageView.image = [UIImage imageNamed:@"Adeudos_no.png"];
                    registro.text=@"Este vehículo no presenta adeudos con Secretaría de Finanzas.";
                    registro.textColor=[UIColor colorWithRed:0.784f green:0.718f blue:0.588f alpha:1.0f];
                    argumento.text=@"Esto incluye pagos por derechos como los son tenencia e infracciones.";
                }
                else
                {
                    int infracciones=0;
                    // infracciones.text=[NSString stringWithFormat:@"%i",[delegate.infracciones count]];
                    for (int i=0; i< [delegate.infracciones count]; i++) {
                        
                        if([[[delegate.infracciones objectAtIndex:i]objectForKey:@"situacion"] isEqualToString:@"Pagada"]){
                            infracciones=infracciones+1;
                        }
                        
                    }
                    if ([delegate.infracciones count] - infracciones!=0) {
                        imageView.image = [UIImage imageNamed:@"Adeudos_si.png"];
                        registro.text=@"Este vehículo presenta adeudos con Secretaría de Finanzas.";
                        registro.textColor=[UIColor colorWithRed:0.557f green:0.031f blue:0.051f alpha:1.0f];
                        argumento.text=@"Esto incluye pagos por derechos como los son tenencia e infracciones.";
                    }
                    else{
                        imageView.image = [UIImage imageNamed:@"Adeudos_no.png"];
                        registro.text=@"Este vehículo no presenta adeudos con Secretaría de Finanzas.";
                        registro.textColor=[UIColor colorWithRed:0.784f green:0.718f blue:0.588f alpha:1.0f];
                        argumento.text=@"Esto incluye pagos por derechos como los son tenencia e infracciones.";
                        
                    }
                }
                
                
            }
            else{
                
                imageView.image = [UIImage imageNamed:@"Adeudos_si.png"];
                registro.text=@"Este vehículo presenta adeudos con Secretaría de Finanzas.";
                registro.textColor=[UIColor colorWithRed:0.557f green:0.031f blue:0.051f alpha:1.0f];
                argumento.text=@"Esto incluye pagos por derechos como los son tenencia e infracciones..";
                
            }
            [registro adjustsFontSizeToFitWidth];
            [argumento adjustsFontSizeToFitWidth];
            [self.scrollView addSubview:argumento];
            [self.scrollView addSubview:registro];
            [self.scrollView addSubview:imageView];
            
            
            
        }
        
        else{
            
            UIImageView *imageView;
            UILabel *registro;
            UILabel *argumento;
            CGRect frame;
            CGRect frame2;
            CGRect frame_argumento;
            CGRect frame_infracciones_button;
            UIButton *infracciones=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            if ( [delegate.alto intValue] < 568) {
                
                
                frame.origin.x = (self.scrollView.frame.size.width * i)+65;
                frame.origin.y = 15;
                frame.size.height =150;
                frame.size.width=150;
                imageView = [[UIImageView alloc] initWithFrame:frame];
                
                
                frame2.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame2.origin.y = frame.size.height+10;
                frame2.size.height =60;
                frame2.size.width=250;//self.scrollView.frame.size; ancho
                registro=[[UILabel alloc]initWithFrame:frame2];
                [registro setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
                
                registro.numberOfLines = 3;
                registro.textAlignment = NSTextAlignmentCenter;
                
                
                frame_argumento.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame_argumento.origin.y = frame.size.height+60;
                frame_argumento.size.height =83;
                frame_argumento.size.width=240;//self.scrollView.frame.size; ancho
                argumento=[[UILabel alloc]initWithFrame:frame_argumento];
                [argumento setFont:[UIFont systemFontOfSize:12]];
                argumento.numberOfLines = 6;
                argumento.textAlignment = NSTextAlignmentCenter;
                
                frame_infracciones_button.origin.x=(self.scrollView.frame.size.width * i)+80;
                frame_infracciones_button.origin.y=frame.size.height+100;
                frame_infracciones_button.size.height =100;
                frame_infracciones_button.size.width =120;
                infracciones.frame=frame_infracciones_button;
                [infracciones addTarget:self
                                 action:@selector(verInfracciones:)
                       forControlEvents:UIControlEventTouchDown];
                [infracciones setTitle:@"Ver Infracciones" forState:UIControlStateNormal];
            }
            else{
                
                frame.origin.x = (self.scrollView.frame.size.width * i)+30;
                frame.origin.y = 15;
                frame.size.height =220;
                frame.size.width=220;//self.scrollView.frame.size;
                imageView = [[UIImageView alloc] initWithFrame:frame];
                //label
                
                
                frame2.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame2.origin.y = frame.size.height+5;
                frame2.size.height =150;
                frame2.size.width=240;//self.scrollView.frame.size; ancho
                registro=[[UILabel alloc]initWithFrame:frame2];
                [registro setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
                //[registro setFont:[UIFont systemFontOfSize:12]];
                registro.numberOfLines = 3;
                registro.textAlignment = NSTextAlignmentCenter;
                
                
                frame_argumento.origin.x = (self.scrollView.frame.size.width * i)+20;
                frame_argumento.origin.y = frame.size.height+60;
                frame_argumento.size.height =140;
                frame_argumento.size.width=240;//self.scrollView.frame.size; ancho
                argumento=[[UILabel alloc]initWithFrame:frame_argumento];
                [argumento setFont:[UIFont systemFontOfSize:12]];
                argumento.numberOfLines = 6;
                argumento.textAlignment = NSTextAlignmentCenter;
                
                frame_infracciones_button.origin.x=(self.scrollView.frame.size.width * i)+80;
                frame_infracciones_button.origin.y=frame.size.height+115;
                frame_infracciones_button.size.height =100;
                frame_infracciones_button.size.width =120;
                infracciones.frame=frame_infracciones_button;
                [infracciones addTarget:self
                                 action:@selector(verInfracciones:)
                       forControlEvents:UIControlEventTouchDown];
                [infracciones setTitle:@"Ver Infracciones" forState:UIControlStateNormal];
                
                
                
            }
            argumento.text=@"Esto incluye infracciones como estacionar el vehículo en lugares prohibidos, conducir a exceso de velocidad, vueltas prohibidas, etc.";
            
            if([delegate.infracciones count]==0){
                imageView.image = [UIImage imageNamed:@"Infracciones_No.png"];
                registro.text=[NSString stringWithFormat:@"Este vehículo no ha cometido infracciones al Reglamento de Tránsito Metropolitano vigente."];
                registro.textColor=[UIColor colorWithRed:0.784f green:0.718f blue:0.588f alpha:1.0f];
                
            }
            else{
                imageView.image = [UIImage imageNamed:@"Infracciones_si.png"];
                registro.text=[NSString stringWithFormat:@"Este vehículo ha cometido %i infracciones al Reglamento de Tránsito Metropolitano vigente.",[delegate.infracciones count]];
                registro.textColor=[UIColor colorWithRed:0.557f green:0.031f blue:0.051f alpha:1.0f];
                
            }
            [self.scrollView addSubview:infracciones];
            [registro adjustsFontSizeToFitWidth];
            [argumento adjustsFontSizeToFitWidth];
            [self.scrollView addSubview:argumento];
            [self.scrollView addSubview:registro];
            [self.scrollView addSubview:imageView];
        }
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [paginas count], scrollView.frame.size.height);
}
-(IBAction)volver:(id)sender
{
    //Regresa a la pantalla de inicio
    ViewController *volver;
    
    if ( [delegate.alto intValue] < 568) {
        volver = [[self storyboard] instantiateViewControllerWithIdentifier:@"inicio1"];
        
    }
    else
    {
        volver = [[self storyboard] instantiateViewControllerWithIdentifier:@"inicio"];
    }
    volver.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:volver animated:YES completion:NULL];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

-(IBAction)comentar:(id)sender
{
    // Cargamos una pantalla donde el usuario podra comentar y leer comentarios
    ComentarViewController *comentar;
    comentar = [[self storyboard] instantiateViewControllerWithIdentifier:@"comentar"];
    comentar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:comentar animated:YES completion:NULL];
    
}

-(IBAction)verInfracciones:(id)sender
{
    
    if([delegate.infracciones count]==0){
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle: @" Atención "message: @"Este Taxi no tiene Infracciones Registradas" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        // Cargamos una pantalla donde el usuario podra comentar y leer comentarios
        InfraccionesViewController *infracciones;
        infracciones = [[self storyboard] instantiateViewControllerWithIdentifier:@"infracciones"];
        infracciones.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:infracciones animated:YES completion:NULL];}
}
@end
