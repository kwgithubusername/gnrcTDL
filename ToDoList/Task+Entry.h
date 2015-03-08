//
//  Task+Entry.h
//  ToDoList
//
//  Created by Woudini on 12/7/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import "Task.h"

@interface Task (Entry)

+ (Task *)taskWithEntryInfo:(NSDictionary *)taskDictionary inManagedObjectContext:(NSManagedObjectContext *)context;

+ (void)loadTasksFromEntryArray:(NSArray *)tasks // of Entry NSDictionary
       intoManagedObjectContext:(NSManagedObjectContext *)context;

@end
