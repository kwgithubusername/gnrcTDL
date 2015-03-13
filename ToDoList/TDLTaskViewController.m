//
//  ViewController.m
//  ToDoList
//
//  Created by Woudini on 12/6/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import "TDLTaskViewController.h"
#import <CoreData/CoreData.h>
#import "ToDoCell.h"
#import "AddToDoViewController.h"
#import "UpdateToDoViewController.h"
#import "Task.h"
#import "List.h"
// Things wrong with this tutorial:
// Autolayout was not covered
// Two navigation controllers instead of one
// Saving managedobjectcontext was confusing and not clear- implemented in the delegate did not work- change in iOS 8?
// PrepareforSegue gets called before didSelectRowAtIndexPath- therefore updateToDoViewController needs a new instance for indexPathForSelectedRow
// Previously was passing blocks to get the cellforRowatIndexPath but the a new fetch had to be done for viewWillDisappear to get fetchedresultscontroller to see a change in List

// Add location
// Add photo attachment
// Add lists
// Search by title, tags, items to be completed this week, items within x mile radius
// Write a Django backend to store and share your lists, become a full-stack iOS developer! ;)

@interface TDLTaskViewController () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSIndexPath *selection;

@end

@implementation TDLTaskViewController



#pragma mark Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Store Selection
    [self setSelection:indexPath];
}

-(void) viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound)
    {
        // This if clause sees if the back button was pressed or screen was swiped away.  We know this is true because self is no longer
        // in the navigation stack.
        if ([[self.tableView visibleCells] count] > 0)
        {
            Task *firstTask = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            List *listNameRecord = firstTask.thatOwns;
            BOOL changed = [listNameRecord.taskChanged boolValue];
            // Notify the fetchedResultsController for Lists that the task for the list at indexPath has changed
            listNameRecord.taskChanged = @(!changed);
        }
    }
    [super viewWillDisappear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // THIS GETS CALLED BEFORE didSelectRowAtIndexPath- therefore updateToDoViewController needs a new instance for indexPathForSelectedRow
    if ([segue.identifier isEqualToString:@"addToDoViewController"])
    {
        // Obtain Reference to View Controller
        AddToDoViewController *vc = segue.destinationViewController;
        
        // Configure View Controller
        [vc setManagedObjectContext:self.managedObjectContext];
        
        [vc setGetListNameBlock:^List*()
        {
            // Pass the specific list to add a new task to
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
            
            // The long way is to create an entity description
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"listName", self.passedListName];
            
            // Sort Descriptors are required only for NSFetchedResultsController
            //[fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"listName" ascending:YES]]];
            NSError *error = nil;
            NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
            
            if (error)
            {
                NSLog(@"Unable to execute fetch request.");
                NSLog(@"%@, %@", error, error.localizedDescription);
                
            } else
            {
                NSLog(@"%@", result);
            }
            
            List *listNameRecord = result[0];
            NSLog(@"ListnameRecord is %@", listNameRecord.listName);
            return listNameRecord;
        }];
    } else if ([segue.identifier isEqualToString:@"updateToDoViewController"])
    {
        // Obtain Reference to View Controller
        UpdateToDoViewController *vc2 = segue.destinationViewController;
        
        [vc2 setManagedObjectContext:self.managedObjectContext];
        NSIndexPath *selection = [self.tableView indexPathForSelectedRow];

        if (selection)
        {
            // Fetch Record
            Task *record = [self.fetchedResultsController objectAtIndexPath:selection];
            
            if (record)
            {
                [vc2 setRecord:record];
            }
            
            // Reset Selection
            [self setSelection:nil];
        }
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
        {
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete:
        {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate:
        {
            [self configureCell:(ToDoCell *)[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove:
        {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ToDoCell *cell = (ToDoCell *)[tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];
    
    // Configure Table View Cell
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

// UITableViewDataSource protocol method 1
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// UITableViewDataSource protocol method 2
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Task *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        if (record)
        {
            [self.fetchedResultsController.managedObjectContext deleteObject:record];
        }
    }
    [self saveManagedObjectContext];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (void)configureCell:(ToDoCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    // Fetch Record
    Task *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Update Cell
    [cell.nameLabel setText:record.taskName];
    
    [cell setDidTapButtonBlock:^{
        BOOL isDone = [record.done boolValue];
        
        // Update Record
        record.done = @(!isDone);
    }];
    
    [cell.doneButton setSelected:[record.done boolValue]];
    NSLog(@"%@: %d",[record valueForKey:@"TaskName"], [[record valueForKey:@"done"] boolValue]);
    [self saveManagedObjectContext];
}

#pragma mark -
#pragma mark Helper Methods
- (void)saveManagedObjectContext
{
    NSError *error = nil;
    
    if (![self.managedObjectContext save:&error])
    {
        if (error)
        {
            NSLog(@"Unable to save changes.");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
    }
}


- (void)checkAll:(id)sender
{
    // Create Entity Description
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:self.managedObjectContext];
    
    // Initialize Batch Update Request
    NSBatchUpdateRequest *batchUpdateRequest = [[NSBatchUpdateRequest alloc] initWithEntity:entityDescription];
    
    // Configure Batch Update Request
    [batchUpdateRequest setResultType:NSUpdatedObjectIDsResultType];
    [batchUpdateRequest setPropertiesToUpdate:@{ @"done" : @YES }];
    
    // Execute Batch Request
    NSError *batchUpdateRequestError = nil;
    NSBatchUpdateResult *batchUpdateResult = (NSBatchUpdateResult *)[self.managedObjectContext executeRequest:batchUpdateRequest error:&batchUpdateRequestError];
    
    if (batchUpdateRequestError)
    {
        NSLog(@"Unable to execute batch update request.");
        NSLog(@"%@, %@", batchUpdateRequestError, batchUpdateRequestError.localizedDescription);
        
    } else
    {
        // Extract Object IDs
        NSArray *objectIDs = batchUpdateResult.result;
        
        for (NSManagedObjectID *objectID in objectIDs)
        {
            // Turn Managed Objects into Faults
            NSManagedObject *managedObject = [self.managedObjectContext objectWithID:objectID];
            
            if (managedObject)
            {
                [self.managedObjectContext refreshObject:managedObject mergeChanges:NO];
            }
        }
        
        // Perform Fetch
        NSError *fetchError = nil;
        [self.fetchedResultsController performFetch:&fetchError];
        
        if (fetchError) {
            NSLog(@"Unable to perform fetch.");
            NSLog(@"%@, %@", fetchError, fetchError.localizedDescription);
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", self.managedObjectContext);
    
    // Initialize Check All Button
    UIButton *checkAllButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, 35, 35)];
    [checkAllButton setTitle:@"Check All" forState:UIControlStateNormal];
    [checkAllButton addTarget:self action:@selector(checkAll:) forControlEvents:UIControlEventTouchUpInside];
    
    // Configure Navigation Item
    self.navigationItem.titleView = checkAllButton;
    [self.view bringSubviewToFront:checkAllButton];
    self.tableView.rowHeight = 44;
    
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    
    // The long way is to create an entity description
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"thatOwns.listName", self.passedListName];
    
    // Add Sort Descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"taskDueDate" ascending:YES]]];
    
    // Initialize Fetched Results Controller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    // Configure Fetched Results Controller
    [self.fetchedResultsController setDelegate:self];
    
    // Perform Fetch
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    // without fetchedResults Controller: NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error)
    {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
