//
//  Unit.h
//  Fighters
//
//  Created by Vivian Aranha on 11/27/12.
//  Copyright (c) 2012 Vivian Aranha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Unit : NSObject {
    
    int unitId;
    int parentId;
    BOOL lost;
    
}

- (id)initWithId:(int)myId andParent:(int)myParentId;

@property (nonatomic, assign) int unitId;
@property (nonatomic, assign) int parentId;
@property (nonatomic, assign) BOOL lost;

@end
