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
@interface ViewController : UIViewController
{
    AppDelegate *delegate;
    UIView *loading;
    UIActivityIndicatorView *spinner;
    NSURLConnection *postConnection;
}
@property (weak, nonatomic) IBOutlet UITextField *placa;
@property (weak, nonatomic) IBOutlet UITextField *letra;
@property (weak, nonatomic) IBOutlet UIButton *verificar;
-(IBAction)verificar:(id)sender;
@end
