#import <Foundation/Foundation.h>

@class Experience;

@protocol ExperienceRepositoryInterface <NSObject>

- (void)getGroup:(int)group then:(void (^) (NSArray *experiences))successBlock;
- (void)create:(Experience *)experience then:(void (^) (Experience *))successBlock;

@end
