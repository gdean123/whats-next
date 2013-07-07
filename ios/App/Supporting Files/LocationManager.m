//
//  LocationManager.m
//  ios
//
//  Created by Jason Leng on 6/29/13.
//  Copyright (c) 2013 George Dean. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager()

@property (nonatomic, strong) CLLocation *currentLocation;

@property (nonatomic, strong) CLLocationManager *manager;

@property (nonatomic, assign) CLLocationDirection currentHeading;

@end

@implementation LocationManager

@synthesize currentLocation;

@synthesize manager;

- (LocationManager *)init
{
    self = [super init];
    if (self)
    {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.delegate = self;
        if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
            [self.manager startMonitoringSignificantLocationChanges];
        }
        // Start heading updates.
        if ([CLLocationManager headingAvailable]) {
            self.manager.headingFilter = 5;
            [self.manager startUpdatingHeading];
        }
    }
    
    return self;
}

- (CLLocationDistance)getDistanceFromLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    return [location distanceFromLocation:self.currentLocation];    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.currentLocation = locations.lastObject;
    [self.delegate locationDidUpdate:self];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (newHeading.headingAccuracy < 0)
        return;
    
    // Use the true heading if it is valid.
    CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);
    
    self.currentHeading = theHeading;
    [self.delegate locationDidUpdate:self];
}


@end
