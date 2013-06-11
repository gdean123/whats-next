//
//  Model.h
//  ios
//
//  Created by Jason Leng on 6/9/13.
//  Copyright (c) 2013 George Dean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

- (NSDictionary *)serialize;
- (id)initWithDictionary:(NSDictionary *)attributes;

@end
