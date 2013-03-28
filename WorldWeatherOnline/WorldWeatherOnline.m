//
//  WorldWeatherOnline.m
//  WorldWeatherOnline
//
//  Created by Johan Kuijt on 28-03-13.
//  Copyright (c) 2013 Yo-han. All rights reserved.
//

#import "WorldWeatherOnline.h"

#define WWOLocalWeatherUrl @"http://api.worldweatheronline.com/free/v1/weather.ashx"
#define WWOSearchUrl @"http://api.worldweatheronline.com/free/v1/search.ashx"

@interface WorldWeatherOnline()

@property(nonatomic, strong) NSString *apiKey;
@property(nonatomic, strong) NSString *numberOfDays;
@property(nonatomic, strong) NSString *date;
@property(nonatomic, strong) NSString *includeLocation;
@property(nonatomic, strong) NSString *numberOfResults;
@property(nonatomic, strong) NSString *popular;

- (NSDictionary *)callAPI:(NSString *)apiUrl params:(NSString *)parameters;

@end

@implementation WorldWeatherOnline

@synthesize delegate=_delegate;
@synthesize apiKey=_apiKey;
@synthesize numberOfDays=_numberOfDays;
@synthesize date=_date;
@synthesize includeLocation=_includeLocation;
@synthesize numberOfResults=_numberOfResults;
@synthesize popular=_popular;

- (id) initWithApiKey:(NSString *)key {
    
    self = [super init];
	if (self)
	{
        _apiKey = key;
        _numberOfDays = @"5";
        _date = @"";
        _includeLocation = @"yes";
        _popular = @"no";
        _numberOfResults = @"10";
    }
    
    return self;
}

- (void) setNumberOfDays:(NSString *)numberOfDays {
    _numberOfDays = numberOfDays;
}

- (void) setNumberOfResults:(NSString *)numberOfResults {
    _numberOfResults = numberOfResults;
}

- (void) setPopular:(NSString *)popular {
    _popular = popular;
}

- (void) getWeather:(NSString *)searchString {
    
    NSString *parameters = [NSString stringWithFormat:@"&q=%@&num_of_days=%@&date=%@&includelocation=%@", searchString, self.numberOfDays, self.date, self.includeLocation];
    
    NSDictionary *result = [self callAPI:WWOLocalWeatherUrl params:parameters];
    NSDictionary *responseData = [result objectForKey:@"data"];

    if([responseData objectForKey:@"error"] != nil) {
        [self requestFailed:[responseData objectForKey:@"error"]];
    } else {
        [self requestSucces:responseData];
    }
}

- (void) getWeatherForDate:(NSString *)searchString date:(NSString *)date {
    
    _date = date;
    
    [self getWeather:searchString];
}

- (void) searchLocation:(NSString *)location {
    
    NSString *parameters = [NSString stringWithFormat:@"&q=%@&num_of_results=%@&popular=%@", location, self.numberOfResults, self.popular];
    
    NSDictionary *result = [self callAPI:WWOSearchUrl params:parameters];
    NSDictionary *responseData = [result objectForKey:@"search_api"];
    
    if(responseData == nil) {
        [self requestFailed:[NSDictionary dictionaryWithObject:@"No destinations found" forKey:@"msg"]];
    } else {
        [self requestSucces:[responseData objectForKey:@"result"]];
    }
}

- (NSDictionary *) callAPI:(NSString *)apiUrl params:(NSString *)parameters {
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@?format=json&key=%@%@", apiUrl, self.apiKey, parameters];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestUrl]];
    [request setHTTPMethod: @"GET"];
    
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    if(data == nil)
        return nil;
    
    NSError *errorJSON;
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&errorJSON];
    
    if([[responseDict objectForKey:@"Response"] isEqualToString:@"False"])
        return nil;
    
    return responseDict;
}

- (void) requestSucces:(NSDictionary *)response {
    
    if(_delegate && [_delegate respondsToSelector:@selector(requestSucces:)]) {
        [_delegate requestSucces:response];
    }
}

- (void) requestFailed:(NSDictionary *)response {
    
    if(_delegate && [_delegate respondsToSelector:@selector(requestFailed:)]) {
        [_delegate requestFailed:[response objectForKey:@"msg"]];
    }
}

@end
