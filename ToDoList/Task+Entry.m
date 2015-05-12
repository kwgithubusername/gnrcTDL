//
//  Task+Entry.m
//  ToDoList
//
//  Created by Woudini on 12/7/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import "Task+Entry.h"

@implementation Task (Entry)

+ (Task *)taskWithEntryInfo:(NSDictionary *)taskDictionary inManagedObjectContext:(NSManagedObjectContext *)context;
{
    Task *task = nil;
    NSString *unique = taskDictionary[
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"task"];
    request.predicate = [NSPredicate predicateWithFormat:"%@", unique];
    
    return task;
}

+ (void)loadTasksFromEntryArray:(NSArray *)tasks // of Entry NSDictionary
       intoManagedObjectContext:(NSManagedObjectContext *)context;
{
    
}
@end
