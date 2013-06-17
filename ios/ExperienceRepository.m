#import "ExperienceRepository.h"
#import "Experience.h"

@interface ExperienceRepository()

@property (nonatomic, strong) RKObjectManager *manager;

@end

@implementation ExperienceRepository

- (ExperienceRepository *)init
{
    self = [super init];
    
    if (self) {
        NSIndexSet *successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
        
        RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[Experience class]];
        [responseMapping addAttributeMappingsFromDictionary:@{
         @"id":          @"dbId",
         @"tagline":     @"tagline",
         }];
        
        // Will match Post and Get index
        RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping pathPattern:@"/experiences" keyPath:nil statusCodes:successStatusCodes],
        
        *responseDescriptor1 = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping pathPattern:@"/experiences/:id" keyPath:nil statusCodes:successStatusCodes];
        
        RKObjectMapping *requestMapping = [RKObjectMapping requestMapping];
        [requestMapping addAttributeMappingsFromDictionary:@{
         @"dbId":          @"id",
         @"tagline":       @"tagline",
         }];
        
        RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[Experience class] rootKeyPath:nil];
        
        NSURL *baseURL = [NSURL URLWithString:@"http://localhost:3000"];
        AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
        [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];

        self.manager = [[RKObjectManager alloc] initWithHTTPClient:client];
        
        [self.manager addRequestDescriptor:requestDescriptor];
        [self.manager addResponseDescriptor:responseDescriptor];
        [self.manager addResponseDescriptor:responseDescriptor1];
    }

    return self;
}

- (void)create:(Experience *)experience then:(void (^) (Experience *))successBlock
{
    void (^success)(RKObjectRequestOperation*, RKMappingResult*) = ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successBlock(experience);
    };
    
    [self.manager postObject:experience path:@"/experiences" parameters:nil success:success failure:NULL];
}

- (void)get:(NSNumber *)id then:(void (^) (Experience *))successBlock
{
    NSString *path = [NSString stringWithFormat:@"/experiences/%@", id];
    [self.manager getObjectsAtPath:path
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                Experience* retrievedExperience = (Experience *)[[mappingResult array] objectAtIndex:0];
                                successBlock(retrievedExperience);
                            }
                            failure:nil];
}

@end
