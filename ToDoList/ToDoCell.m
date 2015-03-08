//
//  ToDoCell.m
//  ToDoList
//
//  Created by Woudini on 12/7/14.
//  Copyright (c) 2014 Hi Range. All rights reserved.
//

#import "ToDoCell.h"




@implementation ToDoCell

#pragma mark -
#pragma mark Initialization
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Setup View
    [self setupView];
}

#pragma mark -
#pragma mark View Methods
- (void)setupView
{

    [self.doneButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -
#pragma mark Actions

- (void)didTapButton:(UIButton *)button
{
    if (self.didTapButtonBlock)
    {
        self.didTapButtonBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
