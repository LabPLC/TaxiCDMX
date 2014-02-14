//
//  ConductorViewController.h
//  TaxiCDMX
//
//  Created by Carlos Castellanos on 13/02/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConductorViewController : UIViewController
@property (strong, nonatomic) UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UITextField *nombre;
@property (weak, nonatomic) IBOutlet UITextField *apaterno;
@property (weak, nonatomic) IBOutlet UITextField *amaterno;
@property (weak, nonatomic) IBOutlet UILabel *resultado;
-(IBAction)buscar:(id)sender;
@end
