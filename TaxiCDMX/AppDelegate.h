//
//  AppDelegate.h
//  TaxiCDMX
//
//  Created by Carlos Castellanos on 07/02/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *placa;
@property (strong, nonatomic) NSArray * infracciones;
@property (strong, nonatomic) NSMutableDictionary * tenencias;
@property (strong, nonatomic) NSArray * verificaciones;
@end
