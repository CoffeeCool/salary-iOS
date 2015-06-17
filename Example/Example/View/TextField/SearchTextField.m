//
//  SearchTextField.m
//  Example
//
//  Created by Coffee on 15/6/15.
//  Copyright (c) 2015年 Yalantis. All rights reserved.
//

#import "SearchTextField.h"

@implementation SearchTextField



- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect bound = [super textRectForBounds:bounds];
    bound.origin.x += 2;
    
    return bound;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect bound = [super textRectForBounds:bounds];
    bound.origin.x += 2;
    
    return bound;
}


- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 10;
    return iconRect;
}


@end





