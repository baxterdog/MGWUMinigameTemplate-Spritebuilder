//
//  Buzzsaw.m
//  MGWUMinigameTemplate
//
//  Created by Mike Long on 7/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Buzzsaw.h"

@implementation Buzzsaw



-(void)didLoadFromCCB {
    // Set up anything connected to Sprite Builder here
    self.physicsBody.collisionType = @"spike";
}


@end
