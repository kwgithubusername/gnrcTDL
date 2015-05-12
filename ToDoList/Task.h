//
//  Task.h
//  ToDoList
//
//  Created by Woudini on 12/7/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class List;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * taskDescription;
@property (nonatomic, retain) NSDate * taskDueDate;
@property (nonatomic, retain) NSString * taskName;
@property (nonatomic, retain) List *thatOwns;
@property (nonatomic, retain) NSNumber *done;

@end
