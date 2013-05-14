//
//  ViewController.m
//  WorldWeatherOnline-test
//
//  Created by Johan Kuijt on 14-05-13.
//  Copyright (c) 2013 Yo-han. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    WorldWeatherOnline *wwo = [[WorldWeatherOnline alloc] initWithApiKey:@"26j5z24t6pgccah9k8wpcu4f"];
    wwo.delegate = self;
    
    // Lookup info for a specific city
    //[wwo searchLocation:@"London"];
    
    // Request local weather data by a city name
    //[wwo getWeather:@"London"];
    
    // Request local weather data by a city name for a specific date
    //[wwo getWeatherForDate:@"London" date:@"2013-05-17"];
    
    // Request marine weather with lat/lng
    [wwo getMarineWeather:@"49" lng:@"1"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestFailed:(NSString *)message {
    
    NSLog(@"Error: %@", message);
}

- (void)requestSucces:(NSDictionary *)data {
   
    NSLog(@"Succes! Weather data retrieved: %@", data);
}

@end
