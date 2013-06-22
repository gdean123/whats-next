#import "DatabaseCleaner.h"

@implementation DatabaseCleaner

+ (void)cleanThen:(void (^)())successBlock
{
    NSURL *baseURL = [NSURL URLWithString:@"http://localhost:3000"];
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    RKObjectManager *manager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    void (^success)(RKObjectRequestOperation*, RKMappingResult*) = ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successBlock();
    };
    
    [manager postObject:nil path:@"/clean_database" parameters:nil success:success failure:nil];
}

@end
