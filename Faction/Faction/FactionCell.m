//
//  FactionCell.m
//  Faction
//
//  Created by Vivian Aranha on 11/28/12.
//  Copyright (c) 2012 Vivian Aranha. All rights reserved.
//

#import "FactionCell.h"

@implementation FactionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        fightLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
        fightLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:fightLabel];
        
        fighterOne = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 160, 30)];
        fighterOne.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:fighterOne];
        
        fighterTwo = [[UILabel alloc] initWithFrame:CGRectMake(120, 50, 160, 30)];
        fighterTwo.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:fighterTwo];

        
    }
    return self;
}

-(void) setCellValuesWithDictionary:(NSDictionary *)fighterDictionary{
    fightLabel.text = [fighterDictionary objectForKey:@"fightNumber"];
    fighterOne.text = [fighterDictionary objectForKey:@"firstFighter"];
    fighterTwo.text = [fighterDictionary objectForKey:@"secondFighter"];
    
    if([[fighterDictionary objectForKey:@"Winner"] isEqualToString:@"first"]){
        fighterOne.backgroundColor = [UIColor greenColor];
        fighterTwo.backgroundColor = [UIColor redColor];
    } else {
        fighterOne.backgroundColor = [UIColor redColor];
        fighterTwo.backgroundColor = [UIColor greenColor];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
