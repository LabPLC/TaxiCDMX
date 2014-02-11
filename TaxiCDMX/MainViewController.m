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
    
    _top.backgroundColor=[UIColor colorWithRed:0.573 green:0.467 blue:0.282 alpha:1];
    _bottom.backgroundColor=[UIColor colorWithRed:0.573 green:0.467 blue:0.282 alpha:1];
    
    self.view.backgroundColor=[UIColor colorWithRed:0.937 green:0.204 blue:0.082 alpha:1]; /*#ef3415*/
    delegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    
    loading=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, (self.view.frame.size.height -20))];
    loading.backgroundColor=[UIColor blackColor];
    loading.alpha=0.8;
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(loading.frame.size.width/2.0, loading.frame.size.height/2.0)]; // I do this because I'm in landscape mode
    [spinner startAnimating];
    [loading addSubview:spinner];
    [self.view addSubview:loading];
    [self llamada_asincrona];
   }
-(void)cargar_contenido{

    //inicia pagecontroller
    NSLog(@"ya debio poner el contenido inicio");
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
            
            if (registrado==true) {
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
            NSLog(@"Ya puso pagina 1");
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
             NSLog(@"Ya puso pagina 2");
            
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
            infracciones.text=[NSString stringWithFormat:@"%i",[delegate.infracciones count]];
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
             NSLog(@"Ya puso pagina 3");
        }
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [paginas count], scrollView.frame.size.height);
    ////fin del pagecontroller
    [spinner stopAnimating];
    [loading removeFromSuperview];
     NSLog(@"ya debio poner el contenido fin");
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

-(void)detalles{

    
        NSString *urlString = [NSString stringWithFormat:@"http://datos.labplc.mx/movilidad/vehiculos/%@.json",delegate.placa];
        dispatch_async(dispatch_get_main_queue(), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        NSString *dato = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
        if ([dato isEqualToString:@"null"]) {
            
            NSLog(@"no encontramos informacion sobre este taxi");
            
        }
        else{
            NSMutableString * respuesta = [NSMutableString stringWithString: dato];
            NSData *data_respuesta = [respuesta dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data_respuesta options:NSJSONReadingAllowFragments error:nil];
            
            NSMutableDictionary *consulta=[[NSMutableDictionary alloc]init];
            consulta = [jsonObject objectForKey:@"consulta"];
            
            /*  NSArray *infracciones=[consulta objectForKey:@"infracciones"];
             //  NSMutableDictionary *lugar=[[NSMutableDictionary alloc]init];
             for(int i=0;i<[delegate.infracciones count];i++) {
             NSLog(@"%i",i);
             
             delegate.infracciones=[infracciones objectAtIndex:i];
                          }///////////////////////*/
             
            delegate.infracciones=[consulta objectForKey:@"infracciones"];
             
            delegate.tenencias=[[NSMutableDictionary alloc]initWithDictionary:[consulta objectForKey:@"tenencias"] copyItems:true];
            delegate.verificaciones=[consulta objectForKey:@"verificaciones"];
            [self cargar_contenido];
            NSLog(@"el taxi debe los años %@",[delegate.tenencias objectForKey:@"adeudos"]);
             
             }

    });
    }
- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}
-(void)reportar_taxi{


    
            NSMutableString *postString = [NSMutableString stringWithString:@"http://lionteamsoft.com.mx/taxi.php"];
            [postString appendString:[NSString stringWithFormat:@"?placa=%@", delegate.placa ]];
    
            [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postString]];
            [request setHTTPMethod:@"POST"];
            postConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    

}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

-(void)llamada_asincrona{
    //http://datos.labplc.mx/movilidad/taxis/b01536.json
    NSString *urlString = [NSString stringWithFormat:@"http://datos.labplc.mx/movilidad/taxis/%@.json",delegate.placa];
    //
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        
        if ([data length] >0  )
        {
            
            NSString *dato=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if ([dato isEqualToString:@"null"]) {
                registrado=false;
                _resultado.text=@"pirata";
                [self reportar_taxi];
                NSLog(@"pirata");
                [self detalles];
                
                
            }else{
                NSMutableString * miCadena = [NSMutableString stringWithString: dato];
                NSData *data1 = [miCadena dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
                
                NSMutableDictionary *consulta=[[NSMutableDictionary alloc]init];
                consulta = [jsonObject objectForKey:@"Taxi"];
                
                NSArray *lugares=[consulta objectForKey:@"concesion"];
                NSMutableDictionary *lugar=[[NSMutableDictionary alloc]init];
                for(int i=0;i<[lugares count];i++) {
                    NSLog(@"%i",i);
                    
                    lugar=[lugares objectAtIndex:i];
                    
                }
                NSLog(@"no pirata");
                registrado=true;
                _marca.text=[lugar objectForKey:@"marca"];
                _submarca.text=[lugar objectForKey:@"submarca"];
                _modelo.text=[lugar objectForKey:@"anio"];
                //_marca.text=[lugar objectForKey:@"marca"];
                [self detalles];
                
            }
        }
        else{
            // respuesta = nil;
            NSLog(@"Contenido vacio");
            
        }
        
        
    });
    
}
-(void)llamada_sincrona{
    //inicia sincrono
    NSString *urlString = [NSString stringWithFormat:@"http://datos.labplc.mx/movilidad/taxis/%@.json",delegate.placa];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    // Se crea la petición
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5];
    
    // Se realiza la petición
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *dato = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([dato isEqualToString:@"null"]) {
        
        
        registrado=false;
        _resultado.text=@"pirata";
        [self reportar_taxi];
        
    }else{
        NSMutableString * miCadena = [NSMutableString stringWithString: dato];
        NSData *data1 = [miCadena dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableDictionary *consulta=[[NSMutableDictionary alloc]init];
        consulta = [jsonObject objectForKey:@"Taxi"];
        
        NSArray *lugares=[consulta objectForKey:@"concesion"];
        NSMutableDictionary *lugar=[[NSMutableDictionary alloc]init];
        for(int i=0;i<[lugares count];i++) {
            NSLog(@"%i",i);
            
            lugar=[lugares objectAtIndex:i];
            
        }
        registrado =true;
        NSLog(@"no pirata");
       
        _resultado.text=@"Oficial";
        _marca.text=[lugar objectForKey:@"marca"];
        _submarca.text=[lugar objectForKey:@"submarca"];
        _modelo.text=[lugar objectForKey:@"anio"];
        NSLog(@"marca:%@",[lugar objectForKey:@"marca"] );
    }
    [self detalles];
    //termina sincrono

}

@end
