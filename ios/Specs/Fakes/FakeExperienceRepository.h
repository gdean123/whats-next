#import <Foundation/Foundation.h>
#import "Experience.h"
#import "ExperienceRepositoryInterface.h"

@interface FakeExperienceRepository : NSObject<ExperienceRepositoryInterface>

@property (strong, nonatomic) void (^successBlock)(NSArray *);
@property (assign, nonatomic) int group;
@property (strong, nonatomic) Experience *lastCreatedExperience;

- (void)getGroup:(int)group then:(void (^) (NSArray *experiences))successBlock;
- (void)create:(Experience *)experience then:(void (^) (Experience *))successBlock;

@end
