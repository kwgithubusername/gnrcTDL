//
//  TDLViewControllerListDataSource.h
//  ToDoList
//
//  Created by Woudini on 3/12/15.
//  Copyright (c) 2015 Hi Range. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UITableViewCell* (^ConfigureCellBlock)(id indexPath);
typedef void (^DeleteCellBlock)(id indexPath);
typedef NSInteger (^NumberOfRowsInSectionBlock)(NSInteger section);
typedef NSInteger (^NumberOfSectionsBlock)();

@interface TDLTableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

-(id)initWithConfigureCellBlock:(ConfigureCellBlock)aConfigureCellBlock
                DeleteCellBlock:(DeleteCellBlock)aDeleteCellBlock
     NumberOfRowsInSectionBlock:(NumberOfRowsInSectionBlock)aNumberOfRowsInSectionBlock
        NumberOfSectionsBlock:(NumberOfSectionsBlock)aNumberOfSectionsBlock;

@end
