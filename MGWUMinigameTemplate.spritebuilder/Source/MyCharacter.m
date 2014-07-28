//
//  MGWUMinigameTemplate
//
//  Created by Zachary Barryte on 6/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MyCharacter.h"

@implementation MyCharacter {
    float _velYPrev; // this tracks the previous velocity, it's used for animation
    BOOL _isIdling; // these BOOLs track what animations have been triggered.  By default, they're set to NO
    BOOL _isJumping;
    BOOL _isFalling;
    BOOL _isLanding;
    BOOL _isWalkingRight;
    NSInteger _horizontalIncrement;
    NSInteger _verticalIncrement;
}

-(id)init {
    if ((self = [super init])) {
        // Initialize any arrays, dictionaries, etc in here
        
        // We initialize _isIdling to be YES, because we want the character to start idling
        // (Our animation code relies on this)
        _isIdling = YES;
        // by default, a BOOL's value is NO, so the other BOOLs are NO right now
    }
    _verticalIncrement = 200;
    _horizontalIncrement = 50;
    _isWalkingRight = false;
    
    return self;
}

-(void)didLoadFromCCB {
    // Set up anything connected to Sprite Builder here
}

-(void)onEnter {
    [super onEnter];
    // Create anything you'd like to draw here
}

-(void)update:(CCTime)delta {
    // Called each update cycle
    // n.b. Lag and other factors may cause it to be called more or less frequently on different devices or sessions
    // delta will tell you how much time has passed since the last cycle (in seconds)
    
    // This sample method is called every update to handle character animation
    [self updateAnimations:delta];
}


-(void)updateAnimations:(CCTime)delta {
    //CCLOG(@"_isWalkingRight: %d",_isWalkingRight);
    
    
    if(_isWalkingRight){
        //self.physicsBody.velocity = ccp(_horizontalIncrement,0);
        //[self.animationManager runAnimationsForSequenceNamed:@"AnimSideWalking"];
    }else{
        //self.physicsBody.velocity = ccp(-_horizontalIncrement,0);
        //[self.animationManager runAnimationsForSequenceNamed:@"AnimSideWalkingLeft"];
    }
}

// This method is called before setting one to YES, so that only one is ever YES at a time
-(void)resetBools {
    _isIdling = NO;
    _isJumping = NO;
    _isFalling = NO;
    _isLanding = NO;
// _isWalkingRight = NO;
// _isStandingStill = NO;
}

// This method tells the character to jump by giving it an upward velocity.
// It's been added to a physics node in the main scene, like the penguins Peeved Penguins, so it will fall automatically!
-(void)jump {
    CCLOG(@"Jump Button Pressed");
    //if(self.physicsBody.velocity.x == 0){
        //self.physicsBody.velocity = ccp(0,_verticalIncrement);
        if(_isWalkingRight){
            self.physicsBody.velocity = ccp(_horizontalIncrement,_verticalIncrement);
        }else{
            self.physicsBody.velocity = ccp(-_horizontalIncrement,_verticalIncrement);
        }
    //}
}

-(void)right {
    CCLOG(@"Right Button Pressed - AnimSideWalking");
        self.physicsBody.velocity = ccp(_horizontalIncrement,0);
        [self.animationManager runAnimationsForSequenceNamed:@"AnimSideWalking"];
        _isWalkingRight = YES;
}

-(void)left {
    CCLOG(@"Left Button Pressed - AnimSideWalkingLeft");
        self.physicsBody.velocity = ccp(-_horizontalIncrement,0);
        [self.animationManager runAnimationsForSequenceNamed:@"AnimSideWalkingLeft"];
        _isWalkingRight = NO;
}

@end



/*-(void)updateAnimations:(CCTime)delta {
 
 // IDLE
 // The animation should be idle if the character was and is stationary
 // The character may only start idling if he or she was not already idling or falling
 if (_velYPrev == 0 && self.physicsBody.velocity.y == 0 && !_isIdling && !_isFalling) {
 CCLOG(@"IN updateAnimations _isIdling");
 [self resetBools];
 _isIdling = YES;
 
 if(_isWalkingRight){
 [self.animationManager runAnimationsForSequenceNamed:@"AnimSideWalking"];
 }else{
 [self.animationManager runAnimationsForSequenceNamed:@"AnimSideWalkingLeft"];
 }
 
 }
 // JUMP
 // The animation should be jumping if the character wasn't moving up, but now is
 // The character may only start jumping if he or she was idling and isn't jumping
 else if (_velYPrev == 0 && self.physicsBody.velocity.y > 0 && _isIdling && !_isJumping) {
 CCLOG(@"IN updateAnimations _isJumping");
 [self resetBools];
 _isJumping = YES;
 if(_isWalkingRight){
 CCLOG(@"IN updateAnimations AnimSideJump");
 [self.animationManager runAnimationsForSequenceNamed:@"AnimSideJump"];
 }else{
 CCLOG(@"IN updateAnimations AnimSideJumpLeft");
 [self.animationManager runAnimationsForSequenceNamed:@"AnimSideJumpLeft"];
 }
 }
 // FALLING
 // The animation should be falling if the character's moving down, but was moving up or stalled
 // The character may only start falling if he or she was jumping and isn't falling
 else if (_velYPrev >= 0 && self.physicsBody.velocity.y < 0 && _isJumping && !_isFalling) {
 CCLOG(@"IN updateAnimations _isFalling");
 [self resetBools];
 _isFalling = YES;
 if(_isWalkingRight){
 CCLOG(@"IN updateAnimations AnimSideFalling");
 [self.animationManager runAnimationsForSequenceNamed:@"AnimSideFalling" tweenDuration:0.5f];
 }else{
 CCLOG(@"IN updateAnimations AnimSideFallingLeft");
 [self.animationManager runAnimationsForSequenceNamed:@"AnimSideFallingLeft" tweenDuration:0.5f];
 }
 }
 // LANDING
 // The animation sholud be landing if the character's stopped moving down (hit something)
 // The character may only start landing if he or she was falling and isn't landing
 else if (_velYPrev < 0 && self.physicsBody.velocity.y >= 0 && _isFalling && !_isLanding) {
 CCLOG(@"IN updateAnimations _isLanding");
 [self resetBools];
 _isLanding = YES;
 if(_isWalkingRight){
 CCLOG(@"IN updateAnimations AnimSideLand");
 [self.animationManager runAnimationsForSequenceNamed:@"AnimSideLand"];
 }else{
 CCLOG(@"IN updateAnimations AnimSideLandLeft");
 [self.animationManager runAnimationsForSequenceNamed:@"AnimSideLandLeft"];
 }
 }
 
 // We track the previous velocity, since it's important to determining how the character is and was moving for animations
 _velYPrev = self.physicsBody.velocity.y;
 
 }
 
 -(void)updateAnimations:(CCTime)delta {
 // IDLE
 // The animation should be idle if the character was and is stationary
 // The character may only start idling if he or she was not already idling or falling
 if (_velYPrev == 0 && self.physicsBody.velocity.y == 0 && !_isIdling && !_isFalling) {
 CCLOG(@"IN updateAnimations _isIdling");
 [self resetBools];
 _isIdling = YES;
 [self.animationManager runAnimationsForSequenceNamed:@"AnimIsoIdling"];
 }
 // JUMP
 // The animation should be jumping if the character wasn't moving up, but now is
 // The character may only start jumping if he or she was idling and isn't jumping
 else if (_velYPrev == 0 && self.physicsBody.velocity.y > 0 && _isIdling && !_isJumping) {
 CCLOG(@"IN updateAnimations _isJumping");
 [self resetBools];
 _isJumping = YES;
 [self.animationManager runAnimationsForSequenceNamed:@"AnimIsoJump"];
 }
 // FALLING
 // The animation should be falling if the character's moving down, but was moving up or stalled
 // The character may only start falling if he or she was jumping and isn't falling
 else if (_velYPrev >= 0 && self.physicsBody.velocity.y < 0 && _isJumping && !_isFalling) {
 CCLOG(@"IN updateAnimations _isFalling");
 [self resetBools];
 _isFalling = YES;
 [self.animationManager runAnimationsForSequenceNamed:@"AnimIsoFalling" tweenDuration:0.5f];
 }
 // LANDING
 // The animation sholud be landing if the character's stopped moving down (hit something)
 // The character may only start landing if he or she was falling and isn't landing
 else if (_velYPrev < 0 && self.physicsBody.velocity.y >= 0 && _isFalling && !_isLanding) {
 CCLOG(@"IN updateAnimations _isLanding");
 [self resetBools];
 _isLanding = YES;
 [self.animationManager runAnimationsForSequenceNamed:@"AnimIsoLand"];
 }
 
 // We track the previous velocity, since it's important to determining how the character is and was moving for animations
 _velYPrev = self.physicsBody.velocity.y;
 
 } */
