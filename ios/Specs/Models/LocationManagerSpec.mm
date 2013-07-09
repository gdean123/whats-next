#import "LocationManager.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(LocationManagerSpec)

describe(@"LocationManager", ^{
    __block LocationManager *locationManager;

    beforeEach(^{
        locationManager = [[LocationManager alloc] init];
    });
    
    it(@"computes the distance (in miles) from a given latitude and longitude", ^{
        locationManager.currentLocation = [[CLLocation alloc] initWithLatitude:37.788319 longitude:-122.40744];
        CLLocation *targetLocation = [[CLLocation alloc] initWithLatitude:37.806207 longitude:-122.423104];
        [locationManager getDistanceFromLocation:targetLocation] should equal(1.5);
    });
});

SPEC_END
