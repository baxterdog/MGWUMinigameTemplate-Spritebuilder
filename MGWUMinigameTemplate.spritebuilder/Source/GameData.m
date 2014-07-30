//
//  GameData.m
//  MGWUMinigameTemplate
//
//  Created by Mike Long on 7/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameData.h"

@implementation GameData

//@synthesize arrayOfDataToBeStored;
@synthesize missionCriticalNumber;
//@synthesize somethingToBeToggled;

//static variable - this stores our singleton instance
static GameData *sharedData = nil;

+(GameData*) sharedData
{
    //If our singleton instance has not been created (first time it is being accessed)
    if(sharedData == nil)
    {
        //create our singleton instance
        sharedData = [[GameData alloc] init];
        
        //collections (Sets, Dictionaries, Arrays) must be initialized
        //Note: our class does not contain properties, only the instance does
        //self.arrayOfDataToBeStored is invalid
        //sharedData.arrayOfDataToBeStored = [[NSMutableArray alloc] init];
    }
    
    //if the singleton instance is already created, return it
    return sharedData;
}

@end