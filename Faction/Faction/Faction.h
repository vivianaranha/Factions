//
//  Faction.h
//  Fighters
//
//  Created by Vivian Aranha on 11/27/12.
//  Copyright (c) 2012 Vivian Aranha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Unit.h"

@interface Faction : NSObject {
    
    int factionID;
    NSMutableArray *factionUnits;
    int numberOfFights;
    
}

@property (nonatomic, assign) int factionID;
@property (nonatomic, retain) NSMutableArray *factionUnits;
@property (nonatomic, assign) int numberOfFights;

-(id) initWithFactionId:(int)myFactionId andUnits:(int) numberOfUnits;

@end
