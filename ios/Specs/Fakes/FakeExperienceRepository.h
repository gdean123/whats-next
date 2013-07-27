#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "Experience.h"
#import "ExperienceRepositoryInterface.h"

@interface FakeExperienceRepository : NSObject<ExperienceRepositoryInterface>

@property (strong, nonatomic) void (^completeFetchForGroup)(NSArray *);
@property (strong, nonatomic) void (^completeCreate)(Experience *);

@property (assign, nonatomic) int lastGroup;
@property (strong, nonatomic) CLLocation *lastLocation;
@property (strong, nonatomic) Experience *lastCreatedExperience;

- (void)getGroup:(int)group near:(CLLocation *)location then:(void (^) (NSArray *experiences))successBlock;
- (void)create:(Experience *)experience then:(void (^) (Experience *))successBlock;

@end
