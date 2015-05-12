//
//  ToDoCell.h
//  ToDoList
//
//  Created by Woudini on 12/7/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ToDoCellDidTapButtonBlock)();

@interface ToDoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (copy, nonatomic) ToDoCellDidTapButtonBlock didTapButtonBlock;

@end
