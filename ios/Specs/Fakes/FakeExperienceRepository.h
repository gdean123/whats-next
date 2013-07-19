#import <Foundation/Foundation.h>
#import "Experience.h"
#import "Repository.h"

@interface FakeExperienceRepository : NSObject <Repository>

@property (strong, nonatomic) void (^successBlock)(NSArray *);
@property (assign, nonatomic) int page;

- (void)getPage:(int)page then:(void (^) (NSArray *experiences))successBlock;

@end
