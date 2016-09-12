//
//  FYFontDownloader.m
//  Fonty
//
//  Created by 颜为晨 on 9/9/16.
//  Copyright © 2016 颜为晨. All rights reserved.
//

#import "FYFontDownloader.h"
#import "FYFontCache.h"
#import "FYFontModel.h"

NSString *const FYNewFontDownloadNotification = @"FYNewFontDownloadNotification";
NSString *const FYNewFontDownloadNotificationKey = @"FYNewFontDownloadNotificationKey"; // FYDowloadFontModel

@interface FYFontDownloader () <NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation FYFontDownloader

+ (instancetype)sharedDownloader {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (void)downloadFontWithURL:(NSURL *)URL {
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithURL:URL];
    [task resume];
}

#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSString *path = [[FYFontCache sharedFontCache] cacheFileAtLocolURL:location fromWebURL:downloadTask.originalRequest.URL];
    if (path) {
        dispatch_async(dispatch_get_main_queue(), ^{
            FYFontModel *model = [FYFontModel modelWithURL:downloadTask.originalRequest.URL
                                                                  status:FYFontModelDownloadStatusDownloaded
                                                        downloadProgress:1.0f];
            NSDictionary *userInfo = @{FYNewFontDownloadNotificationKey:model};
            [[NSNotificationCenter defaultCenter] postNotificationName:FYNewFontDownloadNotification object:self userInfo:userInfo];
        });
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    NSLog(@"%f", ((float)totalBytesWritten / totalBytesExpectedToWrite));
    if (totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown) {
        dispatch_async(dispatch_get_main_queue(), ^{
            FYFontModel *model = [FYFontModel modelWithURL:downloadTask.originalRequest.URL
                                                                  status:FYFontModelDownloadStatusDownloading
                                                        downloadProgress:(float)totalBytesWritten / totalBytesExpectedToWrite];
            NSDictionary *userInfo = @{FYNewFontDownloadNotificationKey:model};
            [[NSNotificationCenter defaultCenter] postNotificationName:FYNewFontDownloadNotification object:self userInfo:userInfo];
        });
    }
}

#pragma mark - accessor

- (NSURLSession *)session {
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                 delegate:self
                                            delegateQueue:nil];
    }
    return _session;
}

@end
