#import "ExperienceRepository.h"
#import "Experience.h"

@interface ExperienceRepository ()

@property (strong, nonatomic) Model* model;

@end

@implementation ExperienceRepository

@synthesize model;

- (void)create:(Model *)model
{
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    
    RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[Experience class]];
    [responseMapping addAttributeMappingsFromDictionary:@{
     @"id":          @"dbId",
     @"tagline":     @"tagline",
     }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping pathPattern:nil keyPath:nil statusCodes:statusCodes];
    
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping]; // objectClass == NSMutableDictionary
    [requestMapping addAttributeMappingsFromDictionary:@{
     @"dbId":          @"id",
     @"tagline":       @"tagline",
     }];
    
    // For any object of class Experience, serialize into an NSMutableDictionary using the given mapping and nest
    // under the 'article' key path
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[Experience class] rootKeyPath:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000"];
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:url];
    
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:responseDescriptor];
    
    // POST to create
    
    void (^success)(RKObjectRequestOperation*, RKMappingResult*) = ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        Experience *experience = [[mappingResult array] objectAtIndex:0];
        self.model.dbId = experience.dbId;
        NSLog(@"================> RETURNED ID: %@", self.model.dbId);
    };
    
    void (^failure)(RKObjectRequestOperation *, NSError *) = ^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"================> FAILURE");
    };
    
    [manager postObject:self.model path:@"/experiences" parameters:nil success:success failure:failure];
}

- (Experience*)getModel:(NSNumber *)id
{
    return NULL;
}

//- (Repository *)initWithModel:(Model *)someModel
//{
//    Repository *repository = [[Repository alloc] init];
//    repository.model = someModel;
//    return repository;
//}
//
//- (void)create
//{
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost:3000/" ]];
//    
//    NSURLRequest* postRequest = [httpClient requestWithMethod:@"POST" path:[self.model path] parameters:nil];
//    
//    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:postRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//                
//        
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//
//    }];
//    
//    [operation start];
//}
//
//- (void)retrieve:(int)objectId
//{    
//}

@end
