//
//  FactionCell.h
//  Faction
//
//  Created by Vivian Aranha on 11/28/12.
//  Copyright (c) 2012 Vivian Aranha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FactionCell : UITableViewCell {
    UILabel *fightLabel;
    UILabel *fighterOne;
    UILabel *fighterTwo;
    
}

-(void) setCellValuesWithDictionary:(NSDictionary *)fighterDictionary;

@end
