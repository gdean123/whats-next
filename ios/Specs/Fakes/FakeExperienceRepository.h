#import <Foundation/Foundation.h>
#import "Experience.h"
#import "Repository.h"

@interface FakeExperienceRepository : NSObject <Repository>

@property (strong, nonatomic) void (^successBlock)(NSArray *);

- (void)getAllThen:(void (^) (NSArray *experiences))successBlock;

@end
