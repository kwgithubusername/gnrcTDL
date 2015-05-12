//
//  ListCell.h
//  ToDoList
//
//  Created by Woudini on 12/10/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ToDoCellDidTapButtonBlock)();

@interface ListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfItemsLabel;

@property (copy, nonatomic) ToDoCellDidTapButtonBlock didTapButtonBlock;

@end
