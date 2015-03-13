//
//  TDLViewControllerListDataSource.m
//  ToDoList
//
//  Created by Woudini on 3/12/15.
//  Copyright (c) 2015 Hi Range. All rights reserved.
//

#import "TDLTableViewDataSource.h"
#import "ListCell.h"
@interface TDLTableViewDataSource ()

@property (nonatomic, copy) ConfigureCellBlock configureCellBlock;
@property (nonatomic, copy) DeleteCellBlock deleteCellBlock;
@property (nonatomic, copy) NumberOfRowsInSectionBlock numberOfRowsInSectionBlock;
@property (nonatomic, copy) NumberOfSectionsBlock numberOfSectionsBlock;

@end

@implementation TDLTableViewDataSource

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
    // Configure Table View Cell
    return self.configureCellBlock(indexPath);

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
}

@end
