//
//  HYBImageClipedManager.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/4/2.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBImageClipedManager.h"
#import <CommonCrypto/CommonDigest.h>

@implementation HYBImageClipedManager

+ (UIImage *)clipedImageFromDiskWithKey:(NSString *)key {
  if (key && key.length) {
    NSString *subpath = [self hyb_md5:key];
    NSString *path = [[self hyb_cachePath] stringByAppendingPathComponent:subpath];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
  }
  
  return nil;
}

+ (void)storeClipedImage:(UIImage *)clipedImage toDiskWithKey:(NSString *)key {
  if (clipedImage == nil || key == nil || key.length == 0) {
    return;
  }
  
  if (![[NSFileManager defaultManager] fileExistsAtPath:[self hyb_cachePath] isDirectory:nil]) {
    NSError *error = nil;
   BOOL isOK = [[NSFileManager defaultManager] createDirectoryAtPath:[self hyb_cachePath]
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:&error];
    if (isOK && error == nil) {
#ifdef kHYBImageCliped
      NSLog(@"create folder HYBClipedImages ok");
#endif
    } else {
      return;
    }
  }
  
  NSString *subpath = [self hyb_md5:key];
  NSString *path = [[self hyb_cachePath] stringByAppendingPathComponent:subpath];
  NSData *data = UIImagePNGRepresentation(clipedImage);
  BOOL isOk = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
  if (isOk) {
#ifdef kHYBImageCliped
    NSLog(@"save cliped image to disk ok, key path is %@", path);
#endif
  } else {
#ifdef kHYBImageCliped
    NSLog(@"save cliped image to disk fail, key path is %@", path);
#endif
  }
}

+ (void)clearClipedImagesCache {
  NSString *directoryPath = [self hyb_cachePath];
  
  if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:&error];
    
    if (error) {
      NSLog(@"clear caches error: %@", error);
    } else {
      NSLog(@"clear caches ok");
    }
  }
}

+ (unsigned long long)imagesCacheSize {
  NSString *directoryPath = [self hyb_cachePath];
  BOOL isDir = NO;
  unsigned long long total = 0;
  
  if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir]) {
    if (isDir) {
      NSError *error = nil;
      NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
      
      if (error == nil) {
        for (NSString *subpath in array) {
          NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
          NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                error:&error];
          if (!error) {
            total += [dict[NSFileSize] unsignedIntegerValue];
          }
        }
      }
    }
  }
  
  return total;
}

#pragma mark - Private
+ (NSString *)hyb_cachePath {
  return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/HYBClipedImages"];
}

+ (NSString *)hyb_md5:(NSString *)string {
  if (string == nil || [string length] == 0) {
    return nil;
  }
  
  unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
  CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
  NSMutableString *ms = [NSMutableString string];
  
  for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
    [ms appendFormat:@"%02x", (int)(digest[i])];
  }
  
  return [ms copy];
}

@end
