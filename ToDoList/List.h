//
//  List.h
//  ToDoList
//
//  Created by Woudini on 12/7/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface List : NSManagedObject

@property (nonatomic, retain) NSString * listName;
@property (nonatomic, retain) NSSet *tasks;
@property (nonatomic, retain) NSNumber *taskChanged;
@end

@interface List (CoreDataGeneratedAccessors)

- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSSet *)values;
- (void)removeTasks:(NSSet *)values;

@end
