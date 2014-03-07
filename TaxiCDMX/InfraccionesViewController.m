//
//  InfraccionesViewController.m
//  TaxiCDMX
//
//  Created by Carlos Castellanos on 06/03/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "InfraccionesViewController.h"
#import "InitViewController.h"
#import "AppDelegate.h"

#import "NSString+HTML.h"
@interface InfraccionesViewController ()

@end

@implementation InfraccionesViewController
{
    AppDelegate *delegate;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad
{
    delegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
  
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [delegate.infracciones count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    

    cell.textLabel.text = [[[delegate.infracciones objectAtIndex:indexPath.row]objectForKey:@"motivo"]  kv_decodeHTMLCharacterEntities];//[[[delegate.infracciones objectAtIndex:indexPath.row]objectForKey:@"motivo"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)regresar:(id)sender
{
    InitViewController *pedir = [[self storyboard] instantiateViewControllerWithIdentifier:@"init"];
    
    pedir.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:pedir animated:YES completion:NULL];
    
}


@end
