//
//  ComentarViewController.h
//  TaxiCDMX
//
//  Created by Carlos Castellanos on 05/03/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComentarViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *comentario;
@property (weak, nonatomic) IBOutlet UIButton *comentar;
@property (weak, nonatomic) IBOutlet UITableView *tabla;
-(IBAction)reload:(id)sender;
-(IBAction)regresar:(id)sender;
@end
