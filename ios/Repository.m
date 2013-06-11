#import "Repository.h"
#import "Model.h"
#import <AFNetworking/AFNetworking.h>


// private properties
@interface Repository ()

@property (strong, nonatomic) Model* model;

@end

@implementation Repository

@synthesize model;

- (Repository *)initWithModel:(Model *)someModel
{
    Repository *repository = [[Repository alloc] init];
    repository.model = someModel;
    return repository;
}

- (void)create
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost:3000/" ]];
    
    NSURLRequest* postRequest = [httpClient requestWithMethod:@"POST" path:[self.model path] parameters:nil];
    
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:postRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {

    }];
    
    [operation start];
}

- (void)retrieve:(int)objectId
{    
}

@end
