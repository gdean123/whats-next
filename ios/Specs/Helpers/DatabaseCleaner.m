#import "DatabaseCleaner.h"

@implementation DatabaseCleaner

+ (void)cleanThen:(void (^)())successBlock
{
    NSURL *baseURL = [NSURL URLWithString:@"http://localhost:3000"];
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    RKObjectManager *manager = [[RKObjectManager alloc] initWithHTTPClient:client];
        
    [manager deleteObject:nil path:@"/clean_database" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successBlock();
    } failure:nil];
}

@end
