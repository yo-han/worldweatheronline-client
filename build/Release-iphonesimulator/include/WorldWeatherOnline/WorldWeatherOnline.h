//
//  WorldWeatherOnline.h
//  WorldWeatherOnline
//
//  Created by Johan Kuijt on 28-03-13.
//  Copyright (c) 2013 Yo-han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorldWeatherOnline : NSObject

@property (nonatomic, strong) id delegate;

- (id) initWithApiKey:(NSString *)key;
- (void) getWeather:(NSString *)searchString;
- (void) getWeatherForDate:(NSString *)searchString date:(NSString *)date;
- (void) getMarineWeather:(NSString *)lat lng:(NSString *)lng premium:(BOOL)premium;
- (void) searchLocation:(NSString *)location;

- (void) setNumberOfDays:(NSString *)numberOfDays;
- (void) setNumberOfResults:(NSString *)numberOfResults;
- (void) setPopular:(NSString *)popular;

@end

@protocol WorldWeatherOnlineDelegate

- (void)requestFailed:(NSString *)message;
- (void)requestSucces:(NSDictionary *)data;

@end
