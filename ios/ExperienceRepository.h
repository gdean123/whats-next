#import <Foundation/Foundation.h>

@class Experience;

@interface ExperienceRepository : NSObject

- (ExperienceRepository *) init;
- (void)create:(Experience *)experience then:(void (^) (Experience *))successBlock;
- (void)get:(NSNumber *)id then:(void (^) (Experience *))successBlock;

@end