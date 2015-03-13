//
//  TDLViewControllerListDataSource.m
//  ToDoList
//
//  Created by Woudini on 3/12/15.
//  Copyright (c) 2015 Hi Range. All rights reserved.
//

#import "TDLViewControllerListDataSource.h"
#import "ListCell.h"
@interface TDLViewControllerListDataSource ()

@property (nonatomic, copy) ConfigureCellBlock configureCellBlock;
@property (nonatomic, copy) DeleteCellBlock deleteCellBlock;
@property (nonatomic, copy) NumberOfRowsInSectionBlock numberOfRowsInSectionBlock;
@property (nonatomic, copy) NumberOfSectionsBlock numberOfSectionsBlock;

@end

@implementation TDLViewControllerListDataSource

-(id)initWithConfigureCellBlock:(ConfigureCellBlock)aConfigureCellBlock
                DeleteCellBlock:(DeleteCellBlock)aDeleteCellBlock
     NumberOfRowsInSectionBlock:(NumberOfRowsInSectionBlock)aNumberOfRowsInSectionBlock
        NumberOfSectionsBlock:(NumberOfSectionsBlock)aNumberOfSectionsBlock
{
    self = [super init];
    if (self)
    {
        self.configureCellBlock = aConfigureCellBlock;
        self.deleteCellBlock = aDeleteCellBlock;
        self.numberOfRowsInSectionBlock = aNumberOfRowsInSectionBlock;
        self.numberOfSectionsBlock = aNumberOfSectionsBlock;
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.numberOfRowsInSectionBlock(section);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.numberOfSectionsBlock();
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListCell *cell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCell" forIndexPath:indexPath];
    
    // Configure Table View Cell
    self.configureCellBlock(cell, indexPath);
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        self.deleteCellBlock(indexPath);
    }
    //[self saveManagedObjectContext];
}

@end
