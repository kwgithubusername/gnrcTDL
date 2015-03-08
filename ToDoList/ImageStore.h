//
//  ImageStore.h
//  ToDoList
//
//  Created by Woudini on 12/25/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageStore : NSObject

@property (nonatomic, strong) NSMutableDictionary *dictionary;

+(ImageStore *)sharedStore;

- (void)setImage:(UIImage *)i forKey:(NSString *)s;
- (UIImage *)imageForKey:(NSString *)s;
- (void)deleteImageForKey:(NSString *)s;

@end
