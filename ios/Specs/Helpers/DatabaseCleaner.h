@interface DatabaseCleaner : NSObject

+ (void)cleanThen:(void (^)())successBlock;

@end
