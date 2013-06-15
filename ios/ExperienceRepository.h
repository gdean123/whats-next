#import <Foundation/Foundation.h>

@class Model, Experience;

@interface ExperienceRepository : NSObject

- (void)create:(Model *)model;
- (Experience*)getModel:(NSNumber *)id;

@end

