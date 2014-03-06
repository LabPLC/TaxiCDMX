//
//  ComentarViewController.m
//  TaxiCDMX
//
//  Created by Carlos Castellanos on 05/03/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "ComentarViewController.h"

@interface ComentarViewController ()

@end

@implementation ComentarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.a
}
-(IBAction)comentar:(id)sender{

   /* NSString *urlString = @"hhttp://placas-taxi.herokuapp.com/comentarios.json";
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
	[request setURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
	
    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
	[request addValue:contentType forHTTPHeaderField:@"Content-Type"];
	
	NSMutableData *body = [NSMutableData data];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"comentario[placa]\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"A12345" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"comentario[coment]\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_comentario.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"comentario[usuario]\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"1" dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body ];
    
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	
	NSLog(returnString);
   
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"hhttp://placas-taxi.herokuapp.com/comentarios"]];
    [request1 setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request1 setHTTPBody:[[NSString stringWithFormat:@"comentario[placa]=a12345&comentario[coment]=%@&comentario[usuario]=1",_comentario.text] dataUsingEncoding:NSUTF8StringEncoding]];
    [request1 setHTTPMethod:@"POST"];
    NSError *error = nil; NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request1 returningResponse:&response error:&error];
    if (error) {
        NSLog(@"Error:%@", error.localizedDescription);
    }
    else {
        //success
    } */
    NSString *queryString = [NSString stringWithFormat:@"http://placas-taxi.herokuapp.com/comentarios.json"];
    
    NSMutableURLRequest *theRequest=[NSMutableURLRequest
                                     requestWithURL:[NSURL URLWithString:
                                                     queryString]
                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                     timeoutInterval:60.0];
    NSDictionary* jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"A12345", @"comentario[placa]",
                                    @"comentario desde ios", @"comentario[coment]",
                                    @"1", @"comentario[usuario]",
                                    nil];
    NSError *error;
  //  NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
    //                                                   options:NSJSONWritingPrettyPrinted error:&error];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // should check for and handle errors here but we aren't
    [theRequest setHTTPBody:jsonDictionary];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
