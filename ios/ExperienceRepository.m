#import "ExperienceRepository.h"
#import "Experience.h"

@interface ExperienceRepository()

@property (nonatomic, strong) RKObjectManager *manager;

@end

@implementation ExperienceRepository

- (ExperienceRepository *) init
{
    self = [super init];
    
    if (self) {
        NSIndexSet *successStatusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
        
        RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[Experience class]];
        [responseMapping addAttributeMappingsFromDictionary:@{
         @"id":          @"dbId",
         @"tagline":     @"tagline",
         }];
        
        RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping pathPattern:nil keyPath:nil statusCodes:successStatusCodes];
        
        RKObjectMapping *requestMapping = [RKObjectMapping requestMapping];
        [requestMapping addAttributeMappingsFromDictionary:@{
         @"dbId":          @"id",
         @"tagline":       @"tagline",
         }];
        
        RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[Experience class] rootKeyPath:nil];
        
        NSURL *url = [NSURL URLWithString:@"http://localhost:3000"];
        self.manager = [RKObjectManager managerWithBaseURL:url];
        
        [self.manager addRequestDescriptor:requestDescriptor];
        [self.manager addResponseDescriptor:responseDescriptor];
    }

    return self;
}

- (void)create:(Model *)model
{
    void (^success)(RKObjectRequestOperation*, RKMappingResult*) = ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        Experience *experience = (Experience *)[[mappingResult array] objectAtIndex:0];
        model.dbId = experience.dbId;
    };
    
    void (^failure)(RKObjectRequestOperation *, NSError *) = ^(RKObjectRequestOperation *operation, NSError *error) {};
    
    [self.manager postObject:model path:@"/experiences" parameters:nil success:success failure:failure];
}

- (Experience*)getModel:(NSNumber *)id
{
    return NULL;
}

@end
