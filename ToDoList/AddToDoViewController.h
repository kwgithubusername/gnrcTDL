//
//  AddToDoViewController.h
//  ToDoList
//
//  Created by Woudini on 12/7/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "List.h"
typedef List *(^AddToDoGetListNameBlock)();

@interface AddToDoViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *image; // the image we're displaying - no instance variable
@property (strong, nonatomic) NSString *imageKey;

@property (copy, nonatomic) AddToDoGetListNameBlock getListNameBlock;

@end
