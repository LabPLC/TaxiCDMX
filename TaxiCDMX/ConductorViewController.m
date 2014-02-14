//
//  ConductorViewController.m
//  TaxiCDMX
//
//  Created by Carlos Castellanos on 13/02/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "ConductorViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface ConductorViewController ()

@end

@implementation ConductorViewController
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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"opciones"];
    }
    
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    self.menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(8, 21, 34, 24);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.menuBtn];

}
-(IBAction)buscar:(id)sender
{
    [self llamada_asincrona];
}
-(void)llamada_asincrona{

    NSString * urlString = [NSString stringWithFormat:@"http://dev.datos.labplc.mx/movilidad/taxis/conductor.json?nombre=%@&apellido_paterno=%@&apellido_materno=%@",_nombre.text,_apaterno.text,_amaterno.text];
   /****************************************************************************************************/
   /* [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] */
   /*  Si enviamos una url con ut8 por ejemplo con espacio que se traduce como %20 habra que usarlo    */
   /****************************************************************************************************/
   
    dispatch_async(dispatch_get_main_queue(), ^{
        NSError *error;
        NSData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] options:NSDataReadingUncached error:&error];
        if ([data length] >0 )
        {
            
            NSString *dato=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if ([dato isEqualToString:@"null"]) {
               
                
                
            }else{
                NSMutableString * miCadena = [NSMutableString stringWithString: dato];
                NSData *data1 = [miCadena dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
                
                NSMutableDictionary *consulta=[[NSMutableDictionary alloc]init];
                consulta = [jsonObject objectForKey:@"Taxi"];
                NSArray *lugares=[consulta objectForKey:@"conductor"];
                if([lugares count]==1)
                {
                    NSLog(@"taxista sin licencia");
                }
                else{
                    
                    _resultado.text=[[consulta objectForKey:@"conductor"] objectForKey:@"vigencia"];
              
                    NSLog(@"%@",([[consulta objectForKey:@"conductor"] objectForKey:@"nombre"]));
                   }
            }
        }
        else{
            // respuesta = nil;
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Eror" message:@"No se pudo realizar la petición, intentalo de nuevo" delegate:@"Aceptar" cancelButtonTitle:@"aceptar" otherButtonTitles:nil, nil];
            [alert show];
           
            alert=nil;
            
        }
        
        
    });
    
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

@end
