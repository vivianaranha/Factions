//
//  FactionViewController.h
//  Faction
//
//  Created by Vivian Aranha on 11/28/12.
//  Copyright (c) 2012 Vivian Aranha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FactionCell.h"
#import "Faction.h"
#import "Unit.h"

@interface FactionViewController : UITableViewController {
    
    NSMutableArray *theFightArray;
    NSMutableString *winnerString;
    int numberOfFactions;
    int numberOfUnits;
    
}

@property(nonatomic, assign) int numberOfFactions;
@property(nonatomic, assign) int numberOfUnits;

@end
