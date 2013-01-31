//
//  FactionViewController.m
//  Faction
//
//  Created by Vivian Aranha on 11/28/12.
//  Copyright (c) 2012 Vivian Aranha. All rights reserved.
//

#import "FactionViewController.h"

#define DEFAULT_FACTIONS 5
#define DEFAULT_UNITS 20

@implementation FactionViewController

@synthesize numberOfFactions, numberOfUnits;

int totalNumberOfFights = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];

    theFightArray = [[NSMutableArray alloc] init];
    winnerString = [[NSMutableString alloc] initWithString:@"Winner: Fight is On"];
    
    if(!numberOfFactions){
        numberOfFactions = DEFAULT_FACTIONS;
    }
    if(!numberOfUnits){
        numberOfUnits = DEFAULT_UNITS;
    }
    
    NSMutableArray *factions = [[NSMutableArray alloc] init];
    for(int i = 0;i < numberOfFactions; i++){
        Faction *theFaction = [[Faction alloc] initWithFactionId:i andUnits:numberOfUnits];
        [factions addObject:theFaction];
    }
    
    [self performSelectorInBackground:@selector(startFightWith:) withObject:factions];
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 1){
        return [theFightArray count];
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){
        static NSString *CellIdentifier = @"Cell";
        FactionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil) {
            
            cell = [[FactionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        
        [cell setCellValuesWithDictionary:[theFightArray objectAtIndex:indexPath.row]];
            
        return cell;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",winnerString];
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1 ){
        return 100;
    }
    return 50;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if(section == 1){
        return @"Fight Log";
    }
    return @"";
    
}



#pragma mark - Faction Methods

-(NSArray *) getEligibleFighterFrom:(NSArray *)theFactions{
    
    NSMutableArray *eligibleFighterFactions = [[NSMutableArray alloc] init];
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"numberOfFights" ascending:YES] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [theFactions sortedArrayUsingDescriptors:sortDescriptors];
    
    
    int minFightsByAFaction = [(Faction*)[sortedArray objectAtIndex:0] numberOfFights];
    
    for (Faction *theFaction in theFactions){
        if(theFaction.numberOfFights == minFightsByAFaction && [theFaction.factionUnits count] > 0){
            [eligibleFighterFactions addObject:theFaction];
        }
    }
    while([eligibleFighterFactions count] <= 1){
        minFightsByAFaction++;
        for (Faction *theFaction in theFactions){
            if(theFaction.numberOfFights == minFightsByAFaction && [theFaction.factionUnits count] > 0){
                [eligibleFighterFactions addObject:theFaction];
            }
        }
        
    }
    
    //    NSLog(@"Eligible Factions: %@",eligibleFighterFactions);
    
    return eligibleFighterFactions;
}

-(Unit *) getRandomUnitFromFaction:(Faction *)theFaction{
    
    //    NSLog(@"%d",[theFaction.factionUnits count]);
    int theSelectedUnitIndex = arc4random() % [theFaction.factionUnits count];
    
    return [theFaction.factionUnits objectAtIndex:theSelectedUnitIndex];
}

-(void) fightUnitFromFaction:(Faction *)firstFaction withUnitFromFaction:(Faction *)secondFaction {
    
    totalNumberOfFights++;
    firstFaction.numberOfFights += 1;
    secondFaction.numberOfFights += 1;
    
    Unit *firstUnit = [self getRandomUnitFromFaction:firstFaction];
    Unit *secondUnit = [self getRandomUnitFromFaction:secondFaction];
    
    NSLog(@"Faction- %d Unit -%d vs Faction -%d Unit -%d",firstUnit.parentId+1, firstUnit.unitId+1, secondUnit.parentId+1, secondUnit.unitId+1);
    
    int winnerUnit = arc4random() % 2;
    
    if(winnerUnit == 0){
        //firstUnit wins
        for (Unit *theUnit in secondFaction.factionUnits) {
            if(theUnit.unitId == secondUnit.unitId){
                NSLog(@"Loser - %d-%d",theUnit.parentId+1, theUnit.unitId+1);
                NSLog(@"Winner - %d-%d",firstUnit.parentId+1, firstUnit.unitId+1);
                [secondFaction.factionUnits removeObject:theUnit];

                NSDictionary *fightDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"Fight %d",totalNumberOfFights], @"fightNumber", [NSString stringWithFormat:@"Faction: %d Unit: %d",firstUnit.parentId+1,firstUnit.unitId+1],@"firstFighter",[NSString stringWithFormat:@"Faction: %d Unit: %d",secondUnit.parentId+1,secondUnit.unitId+1],@"secondFighter", @"first",@"Winner", nil];
                
                [theFightArray insertObject:fightDictionary atIndex:0];
                
                
                
                break;
            }
        }
        
    } else {
        //Second Unit wins
        for (Unit *theUnit in firstFaction.factionUnits) {
            if(theUnit.unitId == firstUnit.unitId){
                NSLog(@"Loser - %d-%d",theUnit.parentId+1, theUnit.unitId+1);
                NSLog(@"Winner - %d-%d",secondUnit.parentId+1, secondUnit.unitId+1);
                [firstFaction.factionUnits removeObject:theUnit];
                
                NSDictionary *fightDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"Fight %d",totalNumberOfFights], @"fightNumber", [NSString stringWithFormat:@"Faction: %d Unit: %d",firstUnit.parentId+1,firstUnit.unitId+1],@"firstFighter",[NSString stringWithFormat:@"Faction: %d Unit: %d",secondUnit.parentId+1,secondUnit.unitId+1],@"secondFighter", @"second",@"Winner", nil];
                [theFightArray insertObject:fightDictionary atIndex:0];
                break;
            }
        }
        
    }
    
    
}

-(void)fightTwoEligibleFactionsFrom:(NSArray *)theEligibleFactions{
    
    //Randomly Select 2 Factions from this eligible list
    int firstRandomFactionIndex = arc4random() % [theEligibleFactions count];
    int secondRandomFactionIndex = arc4random() % [theEligibleFactions count];
    
    while (secondRandomFactionIndex == firstRandomFactionIndex) {
        secondRandomFactionIndex = arc4random() % [theEligibleFactions count];
    }
    
    
    [self fightUnitFromFaction:[theEligibleFactions objectAtIndex:firstRandomFactionIndex] withUnitFromFaction:[theEligibleFactions objectAtIndex:secondRandomFactionIndex]];
    
    
}


-(void) startFightWith:(NSArray *)theFactions{
    
    BOOL fightPossible = YES;
    
    int numberOfUnits = 0;
    for(Faction *theFaction in theFactions){
        numberOfUnits += [theFaction.factionUnits count];
        
    }
    NSLog(@"%d",numberOfUnits);
    
    while (fightPossible) {
        
        //Get the eligible Factions
        NSArray *theFactionsThatAreEligibleForFight = [self getEligibleFighterFrom:theFactions];
        
        //From The eligible list - pick 2 to fight
        [self fightTwoEligibleFactionsFrom:theFactionsThatAreEligibleForFight];
        
        int numberOfUnits = 0;
        for(Faction *theFaction in theFactions){
            numberOfUnits += [theFaction.factionUnits count];
            
        }
        
        //Atleast Two Factions Should have Units to Fight
        int noOfFactionsWithUnits = 0;
        for (Faction *theFaction in theFactions){
            if([theFaction.factionUnits count] > 0){
                noOfFactionsWithUnits++;
            }
        }
        if(noOfFactionsWithUnits == 1) fightPossible = NO;
        
        if(!fightPossible){
            for (Faction *theFaction in theFactions){
                if([theFaction.factionUnits count] > 0){
                    NSLog(@"Winning Faction - %d", theFaction.factionID+1);
                    winnerString = [[NSMutableString alloc]initWithFormat:@"Winner: Faction - %d",theFaction.factionID+1];
                }
            }
        }
        [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:NO];
        [NSThread sleepForTimeInterval:0.1];
    }
}

-(void) reloadTable{
    
    [self.tableView reloadData];

    
}


@end
