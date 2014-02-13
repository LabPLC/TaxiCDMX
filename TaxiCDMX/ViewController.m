//
//  ViewController.m
//  TaxiCDMX
//
//  Created by Carlos Castellanos on 07/02/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "ViewController.h"
#import "InitViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    _letra.tag=0;
    _placa.tag=1;
    
    self.view.backgroundColor=[UIColor colorWithRed:0.573 green:0.467 blue:0.282 alpha:1]; /*#927748*/
        delegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapped)];
    tapScroll.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapScroll];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)verificar:(id)sender
{
   [self tapped];
  
    
    if ([_letra.text length]== 1 && [_placa.text length]==5) {
        
    if ([_letra.text isEqualToString:@"a"] || [_letra.text isEqualToString:@"A"] || [_letra.text isEqualToString:@"B"] || [_letra.text isEqualToString:@"b"] ) {
        NSString *placas= [NSString stringWithFormat:@"%@%@",_letra.text,_placa.text];
        delegate.placa=placas;
        loading=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, (self.view.frame.size.height -20))];
        loading.backgroundColor=[UIColor blackColor];
        loading.alpha=0.8;
        
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [spinner setCenter:CGPointMake(loading.frame.size.width/2.0, loading.frame.size.height/2.0)]; // I do this because I'm in landscape mode
        [spinner startAnimating];
        [loading addSubview:spinner];
        [self.view addSubview:loading];
        [self llamada_asincrona];
        NSLog(@"presiono boton");
      
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Por favor introduce una placa valida" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alert show];
    }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Por favor introduce una placa valida" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alert show];
    }
    
   
   }

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    if (textField.tag==1) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT));
    }
    else{
    
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"abABmM"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 1));
    }

}


- (void) tapped
{
    [self.view endEditing:YES];
}


-(void)llamada_asincrona{
    //http://datos.labplc.mx/movilidad/taxis/b01536.json
    NSString *urlString = [NSString stringWithFormat:@"http://dev.datos.labplc.mx/movilidad/taxis/%@.json",delegate.placa];
    //
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        
        if ([data length] >0  )
        {
            
            NSString *dato=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if ([dato isEqualToString:@"null"]) {
                delegate.registrado=@"false";
                [self reportar_taxi];
                [self detalles];
                
                
            }else{
                NSMutableString * miCadena = [NSMutableString stringWithString: dato];
                NSData *data1 = [miCadena dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
                
                NSMutableDictionary *consulta=[[NSMutableDictionary alloc]init];
                consulta = [jsonObject objectForKey:@"Taxi"];
                  NSArray *lugares=[consulta objectForKey:@"concesion"];
                if([lugares count]==1)
                {
                    delegate.registrado=@"false";
                    delegate.marca=nil;
                    delegate.submarca=nil;
                    delegate.anio=nil;
                    [self reportar_taxi];
                    [self detalles];
                }
                else{
                
               
                    delegate.registrado=@"true";
                    delegate.marca=[[consulta objectForKey:@"concesion"] objectForKey:@"marca"];
                    delegate.submarca=[[consulta objectForKey:@"concesion"] objectForKey:@"submarca"];
                    delegate.anio=[[consulta objectForKey:@"concesion"] objectForKey:@"anio"];
                    [self detalles];
                }
            }
        }
        else{
            // respuesta = nil;
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Eror" message:@"No se pudo realizar la petición, intentalo de nuevo" delegate:@"Aceptar" cancelButtonTitle:@"aceptar" otherButtonTitles:nil, nil];
            [alert show];
            [spinner stopAnimating];
            [loading removeFromSuperview];
            alert=nil;
            
        }
        
        
    });
    
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
            delegate.infracciones=[consulta objectForKey:@"infracciones"];
            delegate.tenencias=[[NSMutableDictionary alloc]initWithDictionary:[consulta objectForKey:@"tenencias"] copyItems:true];
            delegate.verificaciones=[consulta objectForKey:@"verificaciones"];
            InitViewController *pedir = [[self storyboard] instantiateViewControllerWithIdentifier:@"init"];
            
            pedir.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            [self presentViewController:pedir animated:YES completion:NULL];
            NSLog(@"el taxi debe los años %@",[delegate.tenencias objectForKey:@"adeudos"]);
            
        }
        
    });
}


-(void)reportar_taxi{
    
    
    
    NSMutableString *postString = [NSMutableString stringWithString:@"http://lionteamsoft.com.mx/taxi.php"];
    [postString appendString:[NSString stringWithFormat:@"?placa=%@", delegate.placa ]];
    
    [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postString]];
    [request setHTTPMethod:@"POST"];
    postConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    
    
}
@end
