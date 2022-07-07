//
//  CoCauHeader.m
//  DCM-VongQuay
//
//  Created by tuanlm on 7/7/22.
//

#import "CoCauHeader.h"

@implementation CoCauHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    [NSBundle.mainBundle loadNibNamed: @"CoCauHeader" owner:self options:nil];
    [self addSubview: self.headerView];
    self.headerView.frame = self.bounds;
    return self;
}

@end
