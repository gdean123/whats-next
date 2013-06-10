//
//  Model.m
//  ios
//
//  Created by Jason Leng on 6/9/13.
//  Copyright (c) 2013 George Dean. All rights reserved.
//

#import "Model.h"

@implementation Model

- (id) init
{
    if ([self class] == [Model class])
    {
        @throw [NSException exceptionWithName:@"ModelInitialization"
                                       reason:@"Abstract class Model cannot be initiated"
                                     userInfo:nil];
    }
    
    self = [super init];
    
    return self;
}

- (NSDictionary *)serialize
{
    @throw [NSException exceptionWithName:@"NonimplementedMethod"
                                   reason:@"serialize is not implemented"
                                 userInfo:nil];
}

- (id)deserialize:(NSDictionary *)attributes
{
    @throw [NSException exceptionWithName:@"NonimplementedMethod"
                                   reason:@"deserialize is not implemented"
                                 userInfo:nil];

}

@end

