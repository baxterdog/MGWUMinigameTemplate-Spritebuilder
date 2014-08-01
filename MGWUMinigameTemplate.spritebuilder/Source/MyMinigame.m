//
//  MGWUMinigameTemplate
//
//  Created by Zachary Barryte on 6/6/14.
//  Copyright 2014 Apportable. All rights reserved.
//  07_28_14_12_23pm_v0.090
#import "MyMinigame.h"
#import "GameData.h"
#import "CCPhysics+ObjectiveChipmunk.h"

@implementation MyMinigame{
    CCPhysicsNode *_physicsNode;
    CCLabelTTF *_timerValue;
    CCLabelTTF *_pointValue;
    long ticks;
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

    ticks = 0;
    [self schedule:@selector(timerTick) interval:1.0];

    return self;
}

-(void)timerTick
{
    ++ticks;
    _timerValue.string = [NSString stringWithFormat:@"%lu", ticks];
    
    if(ticks == 60){
        [self gameOver];
    }
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair diamond:(CCNode *)nodeA wildcard:(CCNode *)nodeB {
    CCLOG(@"diamond collision ***************** ");
    [self removeDiamond:nodeA];
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair buzzsaw:(CCNode *)nodeA wildcard:(CCNode *)nodeB {
    CCLOG(@"buzzsaw ***************** ");
    nodeB.visible = NO;
    [self explodeMe:nodeA];
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair spike:(CCNode *)nodeA wildcard:(CCNode *)nodeB {
    CCLOG(@"spike ***************** ");
    nodeB.visible = NO; // set the character to invisible - easy peasy
    [self explodeMe:nodeA]; // run the explosion method and display the gameover sign
}

- (void)explodeMe:(CCNode *)deathObject {
    // load particle effect
    CCParticleSystem *death = (CCParticleSystem *)[CCBReader load:@"Death"];
    // make the particle effect clean itself up, once it is completed
    death.autoRemoveOnFinish = TRUE;
    // place the particle effect on the position
    death.position = deathObject.position;
    // add the particle effect to the same node the seal is on
    [deathObject.parent addChild:death];
    // remove the deathObject-spike/buzzsaw since it exploded
    [deathObject removeFromParent];

    [self gameOver];

   // stop the clock
    [self unschedule:@selector(timerTick)];
}

- (void)gameOver{
    CCNode *gameover1 = [self getChildByName:@"gameoverTitle" recursively:NO];
    gameover1.visible = YES;
    CCNode *gameover2 = [self getChildByName:@"gameover2" recursively:NO];
    gameover2.visible = YES;
    CCNode *gameover3 = [self getChildByName:@"gameover3" recursively:NO];
    gameover3.visible = YES;
    CCNode *gameover4 = [self getChildByName:@"gameover4" recursively:NO];
    gameover4.visible = YES;
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

    //int score = [GameData sharedData].missionCriticalNumber;
    //CCLOG(@"score: %d", score);

    GameData* data = [GameData sharedData];

    //   CCNode *coolNode = [CCNode node];
    //   coolNode = @"myNode";
    //   [self addChild:coolNode];
    
    // I think I can change "score" to "data.missionCriticalNumber"
    if(data.missionCriticalNumber==0){
        CCNode *coolNode11 = [self getChildByName:@"diamond1" recursively:YES];
        coolNode11.visible = YES;
    }else if(data.missionCriticalNumber == 20){
        CCNode *coolNode21 = [self getChildByName:@"diamond2" recursively:YES];
        coolNode21.visible = YES;
    }else if(data.missionCriticalNumber == 40){
        CCNode *coolNode31 = [self getChildByName:@"diamond3" recursively:YES];
        coolNode31.visible = YES;
    }else if(data.missionCriticalNumber == 60){
        CCNode *coolNode41 = [self getChildByName:@"diamond4" recursively:YES];
        coolNode41.visible = YES;
    }else if(data.missionCriticalNumber == 80){
        CCNode *coolNode51 = [self getChildByName:@"diamond5" recursively:YES];
        coolNode51.visible = YES;
    }
    
    data.missionCriticalNumber = data.missionCriticalNumber+20;

    CCLOG(@"1_timerValue.string: %@", _timerValue);
    CCLOG(@"1_pointValue.string: %@", _pointValue);
    
    //_timerValue.string = @"xxx";
    
    //_timerValue.string = [NSString stringWithFormat:@"%d", 60];
    _pointValue.string = [NSString stringWithFormat:@"%d", data.missionCriticalNumber];
    
    CCLOG(@"2_timerValue.string: %@", _timerValue);
    CCLOG(@"2_pointValue.string: %@", _pointValue);
    
    //_timerValue = [NSString stringWithFormat:@"xu %d",40];
    //_pointValue = [NSString stringWithFormat:@"xx %d",_pointInt];
    if(data.missionCriticalNumber == 100){
        [self gameOver];
    }
}

-(void)didLoadFromCCB {

    // Set up anything connected to Sprite Builder here
    // We're calling a public method of the character that tells it to walk right!
    [self.hero right];
    
    // Set up the collision delegate to watch for objects hitting eachother
    _physicsNode.collisionDelegate = self;
    
    /* Find my fake diamonds and set them to invisible. (there is no parameter in spritebuilder to set a node to invisible... just an image.. so I have to do it in code. The diamond will be invisible and the half opaque image underneath will be visible */

    

    //DiamondScoreBoard.CCB
    CCNode *coolNode1 = [self getChildByName:@"diamond1" recursively:YES];
    coolNode1.visible = NO;
    CCNode *coolNode2 = [self getChildByName:@"diamond2" recursively:YES];
    coolNode2.visible = NO;
    CCNode *coolNode3 = [self getChildByName:@"diamond3" recursively:YES];
    coolNode3.visible = NO;
    CCNode *coolNode4 = [self getChildByName:@"diamond4" recursively:YES];
    coolNode4.visible = NO;
    CCNode *coolNode5 = [self getChildByName:@"diamond5" recursively:YES];
    coolNode5.visible = NO;


}

-(void)onEnter {
    [super onEnter];
}

-(void)update:(CCTime)delta {
    // Called each update cycle
    // n.b. Lag and other factors may cause it to be called more or less frequently on different devices or sessions
    // delta will tell you how much time has passed since the last cycle (in seconds)
}

-(void)endMinigame {
    int score = [GameData sharedData].missionCriticalNumber;
    // Be sure you call this method when you end your minigame!
    // Of course you won't have a random score, but your score *must* be between 1 and 100 inclusive
    [self endMinigameWithScore:score]; //    [self endMinigameWithScore:arc4random()%100 + 1];
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
