//
//  Faction.m
//  Fighters
//
//  Created by Vivian Aranha on 11/27/12.
//  Copyright (c) 2012 Vivian Aranha. All rights reserved.
//

#import "Faction.h"

@implementation Faction

@synthesize factionID, factionUnits, numberOfFights;

-(id) initWithFactionId:(int)myFactionId andUnits:(int) numberOfUnits{
    self = [super init];
    if (self) {
        
        self.factionID = myFactionId;
        self.factionUnits = [[NSMutableArray alloc] init];
        self.numberOfFights = 0;
        for(int i=0;i < numberOfUnits; i++) {
            //Create Units
            Unit *myUnit = [[Unit alloc] initWithId:i andParent:myFactionId];
            [self.factionUnits addObject:myUnit];
        }
        
    }
    return self;
}

@end
