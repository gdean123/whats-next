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


@end
