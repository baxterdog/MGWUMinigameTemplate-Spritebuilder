//
//  GameData.h
//  MGWUMinigameTemplate
//
//  Created by Mike Long on 7/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

//an NSObject is the most basic Objective-C object
//We subclass it since our singleton is nothing more than a wrapper around several properties
@interface GameData : NSObject

//the keyword "nonatomic" is a property declaration
//nonatomic properties have better performance than atomic properties (so use them!)
//@property (nonatomic) NSMutableArray* arrayOfDataToBeStored;
@property (nonatomic) int missionCriticalNumber;
//@property (nonatomic) bool somethingToBeToggled;

//Static (class) method:
+(GameData*) sharedData;
@end