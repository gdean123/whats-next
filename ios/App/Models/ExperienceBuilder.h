#import <Foundation/Foundation.h>
#import "ExperienceRepositoryInterface.h"
#import "LocationManagerInterface.h"
#import "ImageRepositoryInterface.h"
#import "Experience.h"

@interface ExperienceBuilder : NSObject

@property (copy, nonatomic) NSString *tagline;
@property (copy, nonatomic) UIImage *image;

@property (nonatomic, strong) id<ExperienceRepositoryInterface> experienceRepository;
@property (nonatomic, strong) id<ImageRepositoryInterface> imageRepository;
@property (nonatomic, strong) id<LocationManagerInterface> locationManager;

-(ExperienceBuilder *)initWithExperienceRepository:(id<ExperienceRepositoryInterface>)experienceRepository imageRepository:(id<ImageRepositoryInterface>)imageRepository locationManager:(id<LocationManagerInterface>)locationManager;

- (void)createThen:(void (^) (Experience *))successBlock;

@end
