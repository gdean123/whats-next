#import "LocationManager.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(LocationManagerSpec)

describe(@"LocationManager", ^{
    __block LocationManager *locationManager;
    __block CLLocation *location;

    beforeEach(^{
        locationManager = [[LocationManager alloc] init];
        location = [[CLLocation alloc] initWithLatitude:37.788319 longitude:-122.40744];
    });
    
    it(@"returns the current location", ^{
        [locationManager locationManager:nil didUpdateLocations:@[location]];
        [locationManager currentLocation] should equal(location);
    });
    
    it(@"computes the distance (in miles) from a given latitude and longitude", ^{
        locationManager.currentLocation = location;
        CLLocation *targetLocation = [[CLLocation alloc] initWithLatitude:37.806207 longitude:-122.423104];
        [locationManager getDistanceFromLocation:targetLocation] should equal(@"1.5mi");
    });
    
    it(@"broadcast location change to subscribers", ^{
        id mockLocationManagerDelegate = [OCMockObject mockForProtocol:@protocol(LocationManagerDelegate)];
        [locationManager registerForLocationUpdates:mockLocationManagerDelegate];
        [[mockLocationManagerDelegate expect] locationDidUpdate:location];
        [locationManager locationManager:nil didUpdateLocations:@[location]];
        [mockLocationManagerDelegate verify];        
    });
    
    it(@"doesn't broadcast location change to unsubscribed objects", ^{
        id mockLocationManagerDelegate = [OCMockObject mockForProtocol:@protocol(LocationManagerDelegate)];
        
        [locationManager registerForLocationUpdates:mockLocationManagerDelegate];
        [locationManager unregisterForLocationUpdates:mockLocationManagerDelegate];
        
        [[mockLocationManagerDelegate reject] locationDidUpdate:location];
        [locationManager locationManager:nil didUpdateLocations:@[location]];
        [mockLocationManagerDelegate verify];
    });
});

SPEC_END
