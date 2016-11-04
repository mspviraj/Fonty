//
//  FYFontManager.h
//  Fonty
//
//  Created by 颜为晨 on 16/7/2.
//  Copyright © 2016年 颜为晨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIFont.h>

@class FYFontModel;

@interface FYFontManager : NSObject

+ (void)setFontURLStringArray:(NSArray<NSString *> *)fontURLStringArray;
+ (void)setBoldFontURLStringArray:(NSArray<NSString *> *)boldFontURLStringArray;
+ (void)setItalicFontURLStringArray:(NSArray<NSString *> *)italicFontURLStringArray;

@property (nonatomic, assign, class) NSInteger mainFontIndex;
@property (nonatomic, assign, class) NSInteger mainBoldFontIndex;
@property (nonatomic, assign, class) NSInteger mainItalicFontIndex;

@property (nonatomic, strong, readonly, class) NSArray<FYFontModel *> *fontModelArray;
@property (nonatomic, strong, readonly, class) NSArray<FYFontModel *> *boldFontModelArray;
@property (nonatomic, strong, readonly, class) NSArray<FYFontModel *> *italicFontModelArray;

+ (UIFont *)mainFontOfSize:(CGFloat)size;
+ (UIFont *)mainBoldFontOfSize:(CGFloat)size;
+ (UIFont *)mainItalicFontOfSize:(CGFloat)size;

+ (UIFont *)fontWithURL:(NSURL *)URL size:(CGFloat)size;
+ (UIFont *)fontWithURLString:(NSString *)URLString size:(CGFloat)size;

+ (void)downloadFontWithURL:(NSURL *)URL;
+ (void)downloadFontWithURLString:(NSString *)URLString;

+ (void)cancelDownloadingFontWithURL:(NSURL *)URL;
+ (void)cancelDownloadingFontWithURLString:(NSString *)URLString;

+ (void)pauseDownloadingWithURL:(NSURL *)URL;
+ (void)pauseDownloadingWithURLString:(NSString *)URLString;

+ (void)deleteFontWithURL:(NSURL *)URL;
+ (void)deleteFontWithURLString:(NSString *)URLString;

@end

@interface FYFontManager (Style)

@property (nonatomic, getter=isUsingFontyStyle, class) BOOL usingFontyStyle;

+ (UIFont *)UIFontSystemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)UIFontBoldSystemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)UIFontItalicSystemFontOfSize:(CGFloat)fontSize;

@end
