//
//  UpdateToDoViewController.m
//  ToDoList
//
//  Created by Woudini on 12/8/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import "UpdateToDoViewController.h"
#import "Task.h"
@interface UpdateToDoViewController ()

@end

@implementation UpdateToDoViewController

#pragma mark -
#pragma mark Actions
- (IBAction)cancel:(id)sender
{
        [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender
{
    // Helpers
    NSString *name = self.textField.text;
    
    if (name && name.length)
    {
        // Populate Record
        self.record.taskName = name;
        
        // Save Record
        NSError *error = nil;
        
        if ([self.managedObjectContext save:&error])
        {
            // Pop View Controller
            [self dismissViewControllerAnimated:YES completion:nil];
        } else
        {
            if (error)
                {
                    NSLog(@"Unable to save record.");
                    NSLog(@"%@, %@", error, error.localizedDescription);
                }
            
            // Show Alert View
            [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do could not be saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        
    } else
    {
        // Show Alert View
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do needs a name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.record)
    {
        // Update text Field
        [self.textField setText:self.record.taskName];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
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
