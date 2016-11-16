//
//  FYFontRegister.h
//  Fonty
//
//  Created by 颜为晨 on 9/9/16.
//  Copyright © 2016 颜为晨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYFontRegister : NSObject

+ (instancetype)sharedRegister;

- (NSString *)registerFontWithPath:(NSString *)path;
- (void)unregisterFontWithPath:(NSString *)path;

@end
