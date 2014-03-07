//
//  ViewController.h
//  TaxiCDMX
//
//  Created by Carlos Castellanos on 07/02/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController 
{

    UIView *loading;
    UIActivityIndicatorView *spinner;
    NSURLConnection *postConnection;
}
@property (weak, nonatomic) IBOutlet UIButton *tomar_foto;
@property (weak, nonatomic) IBOutlet UIImageView *imagen;
@property (weak, nonatomic) IBOutlet UITextField *placa;
@property (weak, nonatomic) IBOutlet UITextField *letra;
@property (weak, nonatomic) IBOutlet UIView *View_aux;
@property (weak, nonatomic) IBOutlet UIButton *verificar;

@property (weak, nonatomic) IBOutlet UILabel *lbl_instruccion;

-(IBAction)verificar:(id)sender;

@end

