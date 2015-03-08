//
//  UpdateToDoViewController.h
//  ToDoList
//
//  Created by Woudini on 12/8/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Task;
@interface UpdateToDoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) Task *record;
@end
