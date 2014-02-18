//
//  ViewController.h
//  TaxiCDMX
//
//  Created by Carlos Castellanos on 07/02/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#define NUMBERS_ONLY @"1234567890"
#define CHARACTER_LIMIT 5
@interface ViewController : UIViewController  <UIPickerViewDataSource,UIPickerViewDelegate>

{
    AppDelegate *delegate;
    UIView *loading;
    UIActivityIndicatorView *spinner;
    NSURLConnection *postConnection;
}
@property (weak, nonatomic) IBOutlet UIImageView *imagen;
@property (weak, nonatomic) IBOutlet UITextField *placa;
@property (weak, nonatomic) IBOutlet UITextField *letra;
@property (weak, nonatomic) IBOutlet UIView *View_aux;
@property (weak, nonatomic) IBOutlet UIButton *verificar;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSArray *letra_taxis;
@property (weak, nonatomic) IBOutlet UILabel *lbl_instruccion;

-(IBAction)verificar:(id)sender;
-(IBAction)focus:(id)sender;
@end

