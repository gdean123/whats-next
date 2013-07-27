#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class Experience;

@protocol ExperienceRepositoryInterface <NSObject>

- (void)getGroup:(int)group near:(CLLocation *)location then:(void (^) (NSArray *experiences))successBlock;
- (void)create:(Experience *)experience then:(void (^) (Experience *))successBlock;

@end
