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
         @"image":       @"image",
         @"latitude":    @"latitude",
         @"longitude":   @"longitude",
         }];
        
        RKResponseDescriptor *postResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping pathPattern:@"/experiences" keyPath:nil statusCodes:successStatusCodes];
        
        RKResponseDescriptor *getResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping pathPattern:@"/experiences/:id" keyPath:nil statusCodes:successStatusCodes];
        
        RKObjectMapping *requestMapping = [RKObjectMapping requestMapping];
        [requestMapping addAttributeMappingsFromDictionary:@{
         @"dbId":          @"id",
         @"tagline":       @"tagline",
         @"image":         @"image",
         @"latitude":      @"latitude",
         @"longitude":     @"longitude",
         }];
        
        RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[Experience class] rootKeyPath:nil];
        
        NSURL *baseURL = [NSURL URLWithString:ROOT_URL];
        AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
        [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];

        self.manager = [[RKObjectManager alloc] initWithHTTPClient:client];
        
        [self.manager addRequestDescriptor:requestDescriptor];
        [self.manager addResponseDescriptor:postResponseDescriptor];
        [self.manager addResponseDescriptor:getResponseDescriptor];
    }

    return self;
}

- (void)create:(Experience *)experience then:(void (^) (Experience *))successBlock
{
    void (^success)(RKObjectRequestOperation*, RKMappingResult*) = ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successBlock(experience);
    };
    
    [self.manager postObject:experience path:@"/experiences" parameters:nil success:success failure:nil];
}

- (void)get:(NSNumber *)id then:(void (^) (Experience *))successBlock
{
    NSString *path = [NSString stringWithFormat:@"/experiences/%@", id];

    [self.manager getObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        Experience* retrievedExperience = (Experience *)[[mappingResult array] objectAtIndex:0];
        successBlock(retrievedExperience);
    } failure:nil];
}

- (void)getAllThen:(void (^) (NSArray *experiences))successBlock
{
    NSString *path = [NSString stringWithFormat:@"/experiences"];
    
    [self.manager getObjectsAtPath:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        successBlock([mappingResult array]);
    } failure:nil];
}

- (void)destroy:(Experience *)experience then:(void (^) ())successBlock
{
    NSString *path = [NSString stringWithFormat:@"/experiences/%@", experience.dbId];
    [self.manager deleteObject:nil path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) { successBlock(); } failure:nil];
}

@end
