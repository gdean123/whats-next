#import <AmazonS3Client.h>

#import "ImageRepository.h"

@interface ImageRepository()

@property (strong, nonatomic) AmazonS3Client *s3;

@end

@implementation ImageRepository

NSString *const AWS_ACCESS_KEY = @"AKIAIDUAQSBMWYKUPMTA";
NSString *const AWS_SECRET_CODE = @"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";
NSString *const BUCKET = @"whatsnext";

- (ImageRepository *)init
{
    ImageRepository *repository = [super init];
    
    if(repository) {
        self.s3 = [[AmazonS3Client alloc] initWithAccessKey:AWS_ACCESS_KEY withSecretKey:AWS_SECRET_CODE];
    }
    
    return repository;
}

- (void)create:(UIImage *)imageToCreate then:(void (^) (NSString *))successBlock
{
    NSString *key = [self generateGUID];
    
    S3PutObjectRequest *request = [[S3PutObjectRequest alloc] initWithKey:key inBucket:BUCKET];
    request.contentType = @"image/png";
    request.data = UIImagePNGRepresentation(imageToCreate);
    [self.s3 putObject:request];

    NSString *url = [[self generatePreSignedURLRequestForKey:key] absoluteString];
    
    successBlock(url);
}

-(NSURL *)generatePreSignedURLRequestForKey:(NSString *)key
{
    NSDate *forever = [NSDate dateWithTimeIntervalSinceNow:(NSTimeInterval) 60*60*24*360];
    
    S3GetPreSignedURLRequest *urlRequest = [[S3GetPreSignedURLRequest alloc] init];
    urlRequest.key     = key;
    urlRequest.bucket  = BUCKET;
    urlRequest.expires = forever;
    return [self.s3 getPreSignedURL:urlRequest];
}

-(NSString *)generateGUID
{
    CFUUIDRef udid = CFUUIDCreate(NULL);
    return CFBridgingRelease(CFUUIDCreateString(NULL, udid));
}

@end
