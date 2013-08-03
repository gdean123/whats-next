#import <Foundation/Foundation.h>
#import "ExperienceRepositoryInterface.h"
#import "LocationManagerInterface.h"
#import "Experience.h"

@interface ExperienceBuilder : NSObject

@property (copy, nonatomic) NSString *tagline;
@property (copy, nonatomic) NSString *image;

@property (nonatomic, strong) id<ExperienceRepositoryInterface> experienceRepository;
@property (nonatomic, strong) id<LocationManagerInterface> locationManager;

- (ExperienceBuilder *)initWithRepository:(id<ExperienceRepositoryInterface>)repository locationManager:(id<LocationManagerInterface>)locationManager;

- (void)createThen:(void (^) (Experience *))successBlock;

@end
