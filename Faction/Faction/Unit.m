//
//  Unit.m
//  Fighters
//
//  Created by Vivian Aranha on 11/27/12.
//  Copyright (c) 2012 Vivian Aranha. All rights reserved.
//

#import "Unit.h"

@implementation Unit

@synthesize unitId, parentId, lost;

- (id)initWithId:(int)myId andParent:(int)myParentId
{
    self = [super init];
    if (self) {
        self.unitId = myId;
        self.parentId = myParentId;
        self.lost = NO;
    }
    return self;
}

@end
