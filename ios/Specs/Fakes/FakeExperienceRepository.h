#import <Foundation/Foundation.h>
#import "Experience.h"
#import "Repository.h"

@interface FakeExperienceRepository : NSObject <Repository>

@property (strong, nonatomic) void (^successBlock)(NSArray *);
@property (assign, nonatomic) int group;

- (void)getGroup:(int)group then:(void (^) (NSArray *experiences))successBlock;

@end
