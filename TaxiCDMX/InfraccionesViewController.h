//
//  InfraccionesViewController.h
//  TaxiCDMX
//
//  Created by Carlos Castellanos on 06/03/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfraccionesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
   
}
@property (nonatomic,retain) NSArray * infracciones;
-(IBAction)regresar:(id)sender;

@end
