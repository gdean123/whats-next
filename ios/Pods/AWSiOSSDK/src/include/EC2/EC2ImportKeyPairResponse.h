/*
 * Copyright 2010-2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */


#import "EC2Response.h"



/**
 * Import Key Pair Response
 */

@interface EC2ImportKeyPairResponse:EC2Response

{
    NSString *keyName;
    NSString *keyFingerprint;
}



-(void)setException:(AmazonServiceException *)theException;


/**
 * Default constructor for a new  object.  Callers should use the
 * property methods to initialize this object after creating it.
 */
-(id)init;

/**
 * The specified unique key pair name.
 */
@property (nonatomic, retain) NSString *keyName;

/**
 * The MD5 public key fingerprint as specified in section 4 of <a
 * href="http://tools.ietf.org/html/rfc4716"> RFC4716 </a>.
 */
@property (nonatomic, retain) NSString *keyFingerprint;

/**
 * Returns a string representation of this object; useful for testing and
 * debugging.
 *
 * @return A string representation of this object.
 */
-(NSString *)description;


@end
