//
//  MGWUMinigameTemplate
//
//  Created by Zachary Barryte on 6/6/14.
//  Copyright 2014 Apportable. All rights reserved.
//  07_28_14_12_23pm_v0.090
#import "MyMinigame.h"
#import "GameData.h"
#import "CCPhysics+ObjectiveChipmunk.h"
//#import "MyCharacter.h"
//#import "Diamond.h"


@implementation MyMinigame{
    CCPhysicsNode *_physicsNode;
    
    int _pointInt;
    int _timeInt;
    CCLabelTTF *_timerValue;
    CCLabelTTF *_pointValue;

    
}


//- (void)updateValueDisplay {
//    _valueLabel.string = [NSString stringWithFormat:@"%d", self.value];
//}
//https://www.makegameswith.us/gamernews/387/build-your-own-2048-with-spritebuilder-and-cocos2d


-(id)init {
    if ((self = [super init])) {
        // Initialize any arrays, dictionaries, etc in here
        self.instructions = @"Jumpegypt by Mike";
    }
    
    GameData* data = [GameData sharedData];
    data.missionCriticalNumber = 0;


    return self;
}



- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair diamond:(CCNode *)nodeA wildcard:(CCNode *)nodeB {
    CCLOG(@"COLLISION ***************** ");
    [self removeDiamond:nodeA];
}

- (void)removeDiamond:(CCNode *)diamond {
        // load particle effect
        CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"Explosion"];
        // make the particle effect clean itself up, once it is completed
        explosion.autoRemoveOnFinish = TRUE;
        // place the particle effect on the seals position
        explosion.position = diamond.position;
        // add the particle effect to the same node the seal is on
        [diamond.parent addChild:explosion];
        // finally, remove
        [diamond removeFromParent];

    //One layer:
    //data.missionCriticalNumber = 999;
    
    //Another layer:
    //int numberWeDesperatelyNeed = [GameData sharedData].missionCriticalNumber;

    int score = [GameData sharedData].missionCriticalNumber;
    CCLOG(@"score: %d", score);

    GameData* data = [GameData sharedData];

    //   CCNode *coolNode = [CCNode node];
    //   coolNode = @"myNode";
    //   [self addChild:coolNode];

    
    // I can cahnge score to "data.missionCriticalNumber"
    if(score==0){
        data.missionCriticalNumber = 1;
        CCNode *coolNode = [self getChildByName:@"diamond1" recursively:NO];
        coolNode.visible = YES;
    }else if(score == 1){
        data.missionCriticalNumber = 2;
        CCNode *coolNode = [self getChildByName:@"diamond2" recursively:NO];
        coolNode.visible = YES;
    }else if(score == 2){
        data.missionCriticalNumber = 3;
        CCNode *coolNode = [self getChildByName:@"diamond3" recursively:NO];
        coolNode.visible = YES;
    }else if(score == 3){
        data.missionCriticalNumber = 4;
        CCNode *coolNode = [self getChildByName:@"diamond4" recursively:NO];
        coolNode.visible = YES;
    }else if(score == 4){
        CCNode *coolNode = [self getChildByName:@"diamond5" recursively:NO];
        coolNode.visible = YES;
        //Go to winner screen
    }

    
    CCLOG(@"1_timerValue.string: %@", _timerValue);
    CCLOG(@"1_pointValue.string: %@", _pointValue);
    
    _pointInt = 0;
    _timeInt = 0;
    //_timerValue.string = @"xxx";
    
    _timerValue.string = [NSString stringWithFormat:@"%d", 60];
    _pointValue.string = [NSString stringWithFormat:@"%d", (score+1)*20];
    
    CCLOG(@"2_timerValue.string: %@", _timerValue);
    CCLOG(@"2_pointValue.string: %@", _pointValue);
    
    //_timerValue = [NSString stringWithFormat:@"xu %d",40];
    //_pointValue = [NSString stringWithFormat:@"xx %d",_pointInt];
    
}



-(void)didLoadFromCCB {
    // Set up anything connected to Sprite Builder here
    // We're calling a public method of the character that tells it to jump!
    [self.hero right];
    _physicsNode.collisionDelegate = self;

    
    CCNode *coolNode1 = [self getChildByName:@"diamond1" recursively:NO];
    coolNode1.visible = NO;
    CCNode *coolNode2 = [self getChildByName:@"diamond2" recursively:NO];
    coolNode2.visible = NO;
    CCNode *coolNode3 = [self getChildByName:@"diamond3" recursively:NO];
    coolNode3.visible = NO;
    CCNode *coolNode4 = [self getChildByName:@"diamond4" recursively:NO];
    coolNode4.visible = NO;
    CCNode *coolNode5 = [self getChildByName:@"diamond5" recursively:NO];
    coolNode5.visible = NO;


}

-(void)onEnter {
    [super onEnter];
    // Create anything you'd like to draw here
}

-(void)update:(CCTime)delta {
    // Called each update cycle
    // n.b. Lag and other factors may cause it to be called more or less frequently on different devices or sessions
    // delta will tell you how much time has passed since the last cycle (in seconds)
}

-(void)endMinigame {
    // Be sure you call this method when you end your minigame!
    // Of course you won't have a random score, but your score *must* be between 1 and 100 inclusive
    [self endMinigameWithScore:100]; //    [self endMinigameWithScore:arc4random()%100 + 1];
}

-(void)jumpButton{
    [self.hero jump];
}

-(void)rightButton{
    [self.hero right];
}

-(void)leftButton{
    [self.hero left];
}

-(void)throwButton{
    //[self.hero jump];
}

// DO NOT DELETE!
-(MyCharacter *)hero {
    return (MyCharacter *)self.character;
}
// DO NOT DELETE!

@end
