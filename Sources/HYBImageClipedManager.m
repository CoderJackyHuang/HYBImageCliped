//
//  HYBImageClipedManager.m
//  HYBImageCliped
//
//  Created by huangyibiao on 16/4/2.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBImageClipedManager.h"
#import <CommonCrypto/CommonDigest.h>

static inline NSUInteger HYBCacheCostForImage(UIImage *image) {
  return image.size.height * image.size.width * image.scale * image.scale;
}

@interface HYBImageClipedManager ()

@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, strong) dispatch_queue_t serialQueue;
@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation HYBImageClipedManager

+ (instancetype)shared {
  static  HYBImageClipedManager *s_manager = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    s_manager = [[[self class] alloc] init];
  });
  
  return s_manager;
}

- (instancetype)init {
  if (self = [super init]) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hyb_private_clearCaches)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    self.shouldCache = YES;
    self.totalCostInMemory = 60 * 1024 * 1024; // 默认60M
    _cache = [[NSCache alloc] init];
    _cache.totalCostLimit = self.totalCostInMemory;
    _serialQueue = dispatch_queue_create("com.huangyibiao.imagecliped_serial_queue",
                                         DISPATCH_QUEUE_SERIAL);
    dispatch_sync(self.serialQueue, ^{
      self.fileManager = [[NSFileManager alloc] init];
    });
  }
  
  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIApplicationDidReceiveMemoryWarningNotification
                                                object:nil];
}

- (void)hyb_private_clearCaches {
  [self.cache removeAllObjects];
}

+ (UIImage *)clipedImageFromDiskWithKey:(NSString *)key {
  if (key && key.length) {
    NSString *subpath = [self hyb_md5:key];
    
    UIImage *image = nil;
    if ([HYBImageClipedManager shared].shouldCache) {
      image = [[HYBImageClipedManager shared].cache objectForKey:subpath];
      
      if (image) {
        return image;
      }
    }
    
    NSString *path = [[self hyb_cachePath] stringByAppendingPathComponent:subpath];
    image = [UIImage imageWithContentsOfFile:path];
    
    return image;
  }
  
  return nil;
}

+ (void)clipedImageFromDiskWithKey:(NSString *)key completion:(HYBCacheImage)completion {
  if (key && key.length) {
    dispatch_async([HYBImageClipedManager shared].serialQueue, ^{
      NSString *subpath = [self hyb_md5:key];
      
      UIImage *image = nil;
      if ([HYBImageClipedManager shared].shouldCache) {
        image = [[HYBImageClipedManager shared].cache objectForKey:subpath];
        
        if (image) {
          dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
              completion(image);
            }
          });
          return;
        }
      }
      
      NSString *path = [[self hyb_cachePath] stringByAppendingPathComponent:subpath];
      image = [UIImage imageWithContentsOfFile:path];
      
      dispatch_async(dispatch_get_main_queue(), ^{
        if (completion) {
          completion(image);
        }
      });
    });
  } else {
    if (completion) {
      completion(nil);
    }
  }
}

+ (void)storeClipedImage:(UIImage *)clipedImage toDiskWithKey:(NSString *)key {
  if (clipedImage == nil || key == nil || key.length == 0) {
    return;
  }
  
  NSString *subpath = [self hyb_md5:key];
  
  if ([HYBImageClipedManager shared].shouldCache) {
    NSUInteger cost = HYBCacheCostForImage(clipedImage);
    [[HYBImageClipedManager shared].cache setObject:clipedImage forKey:subpath cost:cost];
  }
  
  dispatch_async([HYBImageClipedManager shared].serialQueue, ^{
    if (![[HYBImageClipedManager shared].fileManager fileExistsAtPath:[self hyb_cachePath] isDirectory:nil]) {
      NSError *error = nil;
      BOOL isOK = [[HYBImageClipedManager shared].fileManager createDirectoryAtPath:[self hyb_cachePath]
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
    
    @autoreleasepool {
      NSString *path = [[self hyb_cachePath] stringByAppendingPathComponent:subpath];
      NSData *data = UIImagePNGRepresentation(clipedImage);
      BOOL isOk = [[HYBImageClipedManager shared].fileManager createFileAtPath:path
                                                                      contents:data
                                                                    attributes:nil];
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
  });
}

+ (void)clearClipedImagesCache {
  dispatch_async([HYBImageClipedManager shared].serialQueue, ^{
    [[HYBImageClipedManager shared].cache removeAllObjects];
    
    NSString *directoryPath = [self hyb_cachePath];
    
    if ([[HYBImageClipedManager shared].fileManager fileExistsAtPath:directoryPath isDirectory:nil]) {
      NSError *error = nil;
      [[HYBImageClipedManager shared].fileManager removeItemAtPath:directoryPath error:&error];
      
      if (error) {
        NSLog(@"clear caches error: %@", error);
      } else {
        NSLog(@"clear caches ok");
      }
    }
  });
}

+ (unsigned long long)imagesCacheSize {
  NSString *directoryPath = [self hyb_cachePath];
  BOOL isDir = NO;
  unsigned long long total = 0;
  
  if ([[HYBImageClipedManager shared].fileManager fileExistsAtPath:directoryPath isDirectory:&isDir]) {
    if (isDir) {
      NSError *error = nil;
      NSArray *array = [[HYBImageClipedManager shared].fileManager contentsOfDirectoryAtPath:directoryPath error:&error];
      
      if (error == nil) {
        for (NSString *subpath in array) {
          NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
          NSDictionary *dict = [[HYBImageClipedManager shared].fileManager attributesOfItemAtPath:path
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
