#import <Foundation/Foundation.h>
#import "Repository.h"

@class Experience;

@interface ExperienceRepository : NSObject <Repository>

- (ExperienceRepository *) init;

- (void)create:(Experience *)experience then:(void (^) (Experience *))successBlock;
- (void)get:(NSNumber *)id then:(void (^) (Experience *))successBlock;
- (void)destroy:(Experience *)experience then:(void (^) ())successBlock;

@end