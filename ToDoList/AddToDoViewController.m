//
//  AddToDoViewController.m
//  ToDoList
//
//  Created by Woudini on 12/7/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import "AddToDoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "Task.h"
#import "List.h"
@interface AddToDoViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, NSCoding>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation AddToDoViewController


#pragma mark Function

- (IBAction)cancel:(id)sender {
   // Dismiss view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
        // Helpers
        NSString *name = self.textField.text;
        
        if (name && name.length) {
            // Create Entity
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:self.managedObjectContext];

            // Initialize Record
            Task *record = [[Task alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
            
            // Populate Record
            record.taskName = name;
            //[record setValue:[NSDate date] forKey:@"taskDueDate"];
        
            // 'lists' is an NSManagedObject with entity List with the name self.passedListName - this must be a block set in TDLViewController
            if (self.getListNameBlock) {
                [self.getListNameBlock() addTasksObject:record];}
            //[self.getListNameBlock() setValue:[NSSet setWithObject:record] forKey:@"tasks"];}
            // Save Record
            NSError *error = nil;
            
            if ([self.managedObjectContext save:&error]) {
                // Dismiss View Controller
                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                if (error) {
                    NSLog(@"Unable to save record.");
                    NSLog(@"%@, %@", error, error.localizedDescription);
                }
                
                // Show Alert View
                [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do could not be saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }
            
        } else {
            // Show Alert View
            [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do needs a name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    
    // Dismiss view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.spinner stopAnimating];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
