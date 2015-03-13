//
//  TDLViewControllerList.h
//  ToDoList
//
//  Created by Woudini on 12/10/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TDLViewControllerList : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
