#import <Foundation/Foundation.h>

@class Model, Experience;

@interface ExperienceRepository : NSObject

- (ExperienceRepository *) init;
- (void)create:(Model *)model;
- (void)get:(NSNumber *)id then:(void (^) (Experience *))successBlock;

@end