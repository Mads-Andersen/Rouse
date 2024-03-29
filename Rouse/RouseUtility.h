//
//  RouseUtility.h
//  Rouse
//
//  Created by Mads Andersen on 19/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface RouseUtility : NSObject

+(CGSize) currentSize;
+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation;
+(float) randFloatBetween:(float)low and:(float)high;

@end
