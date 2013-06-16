#import <Foundation/Foundation.h>

@class Model, Experience;

@interface ExperienceRepository : NSObject

- (ExperienceRepository *) init;
- (void)create:(Model *)model;
- (void)getModel:(NSNumber *)id success:(void ( ^ ) ( Experience * ))success failure:(void ( ^ ) ( NSError *error ))failure;

@end