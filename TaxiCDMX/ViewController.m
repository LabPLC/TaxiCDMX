//
//  ViewController.m
//  TaxiCDMX
//
//  Created by Carlos Castellanos on 07/02/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "ViewController.h"
#import "InitViewController.h"
#import "Tesseract.h"
@interface ViewController ()

@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(IBAction)escanear:(id)sender
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/tessdata"];
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *txtPath = [documentsDirectory stringByAppendingPathComponent:@"/tessdata/eng.traineddata"];
    
    if ([fileManager fileExistsAtPath:txtPath] == NO) {
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"eng" ofType:@"traineddata"];
        [fileManager copyItemAtPath:resourcePath toPath:txtPath error:&error];
    }
    Tesseract* tesseract = [[Tesseract alloc]  initWithDataPath:@"tessdata" language:@"eng"];
    [tesseract setVariableValue:@"-aAbBcC0123456789" forKey:@"tessedit_char_whitelist"];
    [tesseract setImage:_imagen.image];//[UIImage imageNamed:@"otros.png"]];//_imagen.image];//[
    [tesseract recognize];
    //_numeros.text=[tesseract recognizedText];
    NSLog(@"%@", [tesseract recognizedText]);
    NSArray *listItems = [[tesseract recognizedText] componentsSeparatedByString:@"-"];
    [tesseract clear];
    if ([[listItems objectAtIndex:0]isEqualToString:@"a"] || [[listItems objectAtIndex:0]isEqualToString:@"A"] || [[listItems objectAtIndex:0]isEqualToString:@"m"] || [[listItems objectAtIndex:0]isEqualToString:@"B"] || [[listItems objectAtIndex:0]isEqualToString:@"M"] || [[listItems objectAtIndex:0]isEqualToString:@"b"] ) {
        _letra.text=[listItems objectAtIndex:0];
    }
    if ([[listItems objectAtIndex:0]isEqualToString:@"a"] || [[listItems objectAtIndex:0]isEqualToString:@"A"] || [[listItems objectAtIndex:0]isEqualToString:@"b"]|| [[listItems objectAtIndex:0]isEqualToString:@"B"]|| [[listItems objectAtIndex:0]isEqualToString:@"m"]|| [[listItems objectAtIndex:0]isEqualToString:@"M"]) {
        
        _letra.text=[listItems objectAtIndex:0];
        NSString *tmp=[NSString stringWithFormat:@"%@%@",[listItems objectAtIndex:1],[listItems objectAtIndex:2]];
        _placa.text = [tmp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
    }
  
    else{
        UIAlertView *alerta=[[UIAlertView alloc] initWithTitle:@"Número de placa no identificado" message:@"Intenta tomar la foto de nueva" delegate:nil cancelButtonTitle:@"aceptar" otherButtonTitles:nil, nil];
        [alerta show];
    }
}

- (void)viewDidLoad
{
   [_letra becomeFirstResponder];
    //_imagen.hidden=TRUE;
   // [self escanear:nil];
    _letra.tag=0;
    _placa.tag=1;
    
    self.view.backgroundColor=[UIColor colorWithRed:0.557 green:0.031 blue:0.051 alpha:1]; /*#8e080d*/
    _View_aux.backgroundColor=[UIColor colorWithRed:0.784 green:0.718 blue:0.588 alpha:1]; /*#c8b796*/
    delegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapped)];
    tapScroll.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapScroll];
    _letra_taxis= @[@"A", @"B",@"M"];
    
    if ( [delegate.alto intValue] < 568) {
      
            NSLog(@"iphone 3.5");
    }
    else{
      NSLog(@"iphone 4");
    }

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
        
    if ([_letra.text isEqualToString:@"a"] || [_letra.text isEqualToString:@"A"] || [_letra.text isEqualToString:@"B"] || [_letra.text isEqualToString:@"b"] || [_letra.text isEqualToString:@"M"] || [_letra.text isEqualToString:@"m"] ) {
        NSString *placas= [NSString stringWithFormat:@"%@%@",_letra.text,_placa.text];
        delegate.placa=placas;
        loading=[[UIView alloc]initWithFrame:CGRectMake(10, 20, 300, 250)];
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
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Por favor introduce un número de placa valida" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alert show];
    }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Por favor introduce un número de placa valida" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
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
        [_placa becomeFirstResponder];
    }

}


- (void) tapped
{
   // [self.view endEditing:YES];
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
            
            NSLog(@"No encontramos información sobre este taxi");
            
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


- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    picker.showsCameraControls = YES;
    picker.navigationBarHidden = YES;
    picker.toolbarHidden = YES;
    
    CGRect f = picker.view.bounds;
    f.size.height -= picker.navigationBar.bounds.size.height;
    CGFloat barHeight = (f.size.height - f.size.width) / 2;
    UIGraphicsBeginImageContext(f.size);
    [[UIColor colorWithWhite:10 alpha:.5] set];
    UIRectFillUsingBlendMode(CGRectMake(0, 0, f.size.width, barHeight), kCGBlendModeNormal);
    UIRectFillUsingBlendMode(CGRectMake(0, f.size.height - barHeight, f.size.width, barHeight), kCGBlendModeNormal);
    UIImage *overlayImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *overlayIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 320)];
    [overlayIV setUserInteractionEnabled:NO];
    
    overlayIV.image = overlayImage;//[UIImage imageNamed:(@"otros.png")];//overlayImage;
    
    //[picker.cameraOverlayView addSubview:overlayIV];
    UIView *vista=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 95)];
    vista.backgroundColor=[UIColor blackColor];
    picker.cameraOverlayView=vista;
    [self presentViewController:picker animated:YES completion:NULL];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
      _imagen.hidden=FALSE;
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imagen.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
     [self escanear:nil];
    [_letra becomeFirstResponder];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_letra_taxis count];//_letra_taxis.count;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [_letra_taxis objectAtIndex:row];
}

-(IBAction)focus:(id)sender{
[_placa becomeFirstResponder];
}
@end
