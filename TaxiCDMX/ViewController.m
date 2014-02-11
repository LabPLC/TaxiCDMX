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
    
    if ([_letra.text length]== 1) {
        
    if ([_letra.text isEqualToString:@"a"] || [_letra.text isEqualToString:@"A"] || [_letra.text isEqualToString:@"B"] || [_letra.text isEqualToString:@"b"] ) {
        NSString *placas= [NSString stringWithFormat:@"%@%@",_letra.text,_placa.text];
        delegate.placa=placas;
        
        InitViewController *pedir = [[self storyboard] instantiateViewControllerWithIdentifier:@"init"];
        
        pedir.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        NSLog(@"presiono boton");
        [self presentViewController:pedir animated:YES completion:NULL];
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
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT));
}
- (BOOL)textField2:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:letras] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return (([string isEqualToString:filtered])&&(newLength <= 2));
}


- (void) tapped
{
    [self.view endEditing:YES];
}
@end
