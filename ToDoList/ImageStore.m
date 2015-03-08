//
//  ImageStore.m
//  ToDoList
//
//  Created by Woudini on 12/25/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import "ImageStore.h"

@implementation ImageStore

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

+(ImageStore *)sharedStore
{
    static ImageStore *sharedStore = nil;
    if (!sharedStore)
    {
        // Create the singleton
        sharedStore = [[super allocWithZone:NULL] init];
    }
    return sharedStore;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        self.dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(UIImage *)imageForKey:(NSString *)s
{
    return [self.dictionary objectForKey:s];
}

-(void)setImage:(UIImage *)i forKey:(NSString *)s
{
    [self.dictionary setObject:i forKey:s];
}

-(void)deleteImageForKey:(NSString *)s
{
    if (s)
        return;
    [self.dictionary removeObjectForKey:s];
}

@end
