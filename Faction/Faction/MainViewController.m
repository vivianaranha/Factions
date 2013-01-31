//
//  MainViewController.m
//  Faction
//
//  Created by Vivian Aranha on 11/28/12.
//  Copyright (c) 2012 Vivian Aranha. All rights reserved.
//

#import "MainViewController.h"


@implementation MainViewController

-(void)fight{
    
    FactionViewController *faction = [[FactionViewController alloc] initWithStyle:UITableViewStyleGrouped];
    faction.title = @"Fight Details";
    faction.numberOfFactions = [factionNumber.text intValue];
    faction.numberOfUnits = [unitNumber.text intValue];
    [self.navigationController pushViewController:faction animated:YES];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    factionNumber = [[UITextField alloc] initWithFrame:CGRectMake(10, 50, 300, 30)];
    factionNumber.borderStyle = UITextBorderStyleRoundedRect;
    factionNumber.placeholder = @"No. of Factions";
    factionNumber.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:factionNumber];
    
    unitNumber = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 300, 30)];
    unitNumber.borderStyle = UITextBorderStyleRoundedRect;
    unitNumber.placeholder = @"No. of Units";
    unitNumber.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:unitNumber];
    
    UIButton *fightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    fightButton.frame = CGRectMake(120, 150, 80, 30);
    [fightButton setTitle:@"Fight" forState:UIControlStateNormal];
    [fightButton addTarget:self action:@selector(fight) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fightButton];
}


@end
