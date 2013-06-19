#import <Foundation/Foundation.h>
#import "Experience.h"
#import "Repository.h"

@interface FakeExperienceRepository : NSObject <Repository>

@property (strong, nonatomic) void (^successBlock)(Experience *);

- (void)get:(NSNumber *)id then:(void (^) (Experience *))successBlock;

@end
