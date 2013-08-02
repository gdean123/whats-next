#import "ImageRepository.h"
#import "Blocker.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ImageRepositorySpec)

describe(@"ImageRepository", ^{
    __block ImageRepository *repository;
    __block NSURL *createdImageUrl;
    __block Blocker *blocker;
    
    beforeEach(^{
        repository = [[ImageRepository alloc] init];
        blocker = [[Blocker alloc] init];
    });
    
    it(@"creates a new image on S3 and returns its URL", ^{
        UIImage *imageToCreate = [UIImage imageNamed:@"new_photo"];
        [repository create:imageToCreate then:^(NSURL *url){
            createdImageUrl = url;
            [blocker doneWaiting];
        }];
        [blocker wait];
        
        NSData *retrievedImageData = [NSData dataWithContentsOfURL:createdImageUrl];
        retrievedImageData should equal(UIImagePNGRepresentation(imageToCreate));
    });
});

SPEC_END
