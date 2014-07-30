//
//  Diamond.m
//  MGWUMinigameTemplate
//
//  Created by Mike Long on 7/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Diamond.h"

@implementation Diamond



-(void)didLoadFromCCB {
    // Set up anything connected to Sprite Builder here
    self.physicsBody.collisionType = @"diamond";
}

@end

