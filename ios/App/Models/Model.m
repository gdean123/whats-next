#import "Model.h"

@implementation Model

- (Model *) init
{
    self = [super init];
    if (self) {
        self.dbId = NULL;
    }
    
    return self;
}

- (NSString *)path
{
    @throw [NSException exceptionWithName:@"MethodNotImplemented"
                                   reason:@"path is not implemented"
                                 userInfo:nil];
}
@end

