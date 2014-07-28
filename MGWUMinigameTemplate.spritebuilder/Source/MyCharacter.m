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
    BOOL _isWalking;
    NSInteger _horizontalIncrement;
    NSInteger _verticalIncrement;
}

-(id)init {
    if ((self = [super init])) {
        // Initialize any arrays, dictionaries, etc in here
        
        // We initialize _isIdling to be YES, because we want the character to start idling
        // (Our animation code relies on this)
        // _isIdling = YES;
        // by default, a BOOL's value is NO, so the other BOOLs are NO right now
    }
    _verticalIncrement = 200;
    _horizontalIncrement = 40;
    _isWalkingRight = YES;
    _isWalking = YES;
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

// cclog("float and int and string: %4.2f, %#x, %s", 3.1415926, 2014, "cocos2d-x");
// CCLOG("Characters: %c %c", 'a', 65);
// CCLOG("Decimals: %d %ld", 1977, 650000L);
// CCLOG("Preceding with blanks: %10d", 1977);
// CCLOG("Preceding with zeros: %010d", 1977);
// CCLOG("Some different radixes: %d %x %o %#x %#o", 100, 100, 100, 100, 100);
// CCLOG("Floats: %4.2f %.0e %E", 3.1416, 3.1416, 3.1416);
// CCLOG("%s","A string");


-(void)updateAnimations:(CCTime)delta {
    
    CCLOG(@"updateAnimations ---------------------- ");
    //CCLOG(@"Previous: %4.2f", _velYPrev);

  //  CCLOG(@"-------------------------- Y: %4.2f", self.physicsBody.velocity.y);
    /*if( self.physicsBody.velocity.y > 1){
        CCLOG(@"UP: %4.2f", self.physicsBody.velocity.y);
    }
    else if(self.physicsBody.velocity.y < -1){
        CCLOG(@"Down: %4.2f", self.physicsBody.velocity.y);
    }
    else{
        CCLOG(@"Neither ----: %4.2f", self.physicsBody.velocity.y);
    }*/

    
    if( self.physicsBody.velocity.y > 1){
        _isJumping = YES;
        if(_isWalkingRight){
            CCLOG(@"UP Right: self %4.2f setting to AnimSideJump", self.physicsBody.velocity.y);
            [self.animationManager runAnimationsForSequenceNamed:@"AnimSideJump"];
        }else{
            CCLOG(@"UP Left: self %4.2f setting to AnimSideJumpLeft", self.physicsBody.velocity.y);
           [self.animationManager runAnimationsForSequenceNamed:@"AnimSideJumpLeft"];
        }
    }
    else if(self.physicsBody.velocity.y < -1){
        _isFalling = YES;
        if(_isWalkingRight){
            CCLOG(@"Down Right: self %4.2f Setting to AnimSideFalling", self.physicsBody.velocity.y);
            [self.animationManager runAnimationsForSequenceNamed:@"AnimSideFalling" tweenDuration:0.5f];
        }else{
            CCLOG(@"Down Left: self %4.2f Setting to AnimSideFallingLeft", self.physicsBody.velocity.y);
           [self.animationManager runAnimationsForSequenceNamed:@"AnimSideFallingLeft" tweenDuration:0.5f];
        }
    }else{
        _isWalking = YES;



        
        CCLOG(@"Neither self > 1 nor <-1");

        CCLOG(@"PREVIOUS _velYPrev: %4.2f", _velYPrev);
        if (_velYPrev < -100){
            CCLOG(@"(_velYPrev < -100) Previous was falling _velYPrev < -100");
        }else{
            CCLOG(@"Previous was not falling _velYPrev > -100");
        }
        
        CCLOG(@"SELF: %4.2f", self.physicsBody.velocity.y);
        
         if(self.physicsBody.velocity.y > -0.1 && self.physicsBody.velocity.y < 0.1 ){
            CCLOG(@"(...velocity.y == 0) Current Velocity is ZERO: %4.2f", self.physicsBody.velocity.y);
        }else{
            CCLOG(@"(...velocity.y == 0) Current Velocity NOT ZERO: %4.2f", self.physicsBody.velocity.y);
        }
        
        // just stopped falling
        if (_velYPrev < -100 && self.physicsBody.velocity.y > -0.1 && self.physicsBody.velocity.y < 0.1 ) {
            //CCLOG(@"Neither (_velYPrev < -100) && (self.physicsBody.velocity.y == 0) ----: %4.2f", self.physicsBody.velocity.y);
            // Set Back to Walking Right or left since we jsut came out of a jump
            if(_isWalkingRight){
                CCLOG(@"Neither - Right: %4.2f Setting back to AnimSideWalking", self.physicsBody.velocity.y);
                [self.animationManager runAnimationsForSequenceNamed:@"AnimSideWalking"];
                
            }
            else{
                CCLOG(@"Neither - Left: %4.2f Setting back to AnimSideWalkingLeft", self.physicsBody.velocity.y);
                [self.animationManager runAnimationsForSequenceNamed:@"AnimSideWalkingLeft"];
            }
            
            //if(self.physicsBody.velocity.x > -0.01 && self.physicsBody.velocity.x < 0.01 ){
            //}
        }else if(_isFalling == YES || _isJumping == YES){

            if(_isWalkingRight){
                CCLOG(@"Neither - Right: %4.2f Setting back to AnimSideWalking", self.physicsBody.velocity.y);
                [self.animationManager runAnimationsForSequenceNamed:@"AnimSideWalking"];
                
            }else{
                CCLOG(@"Neither - Left: %4.2f Setting back to AnimSideWalkingLeft", self.physicsBody.velocity.y);
                [self.animationManager runAnimationsForSequenceNamed:@"AnimSideWalkingLeft"];
            }
            _isFalling = NO;
            _isJumping = NO;
        }
        
        /*
       if(_isWalkingRight){
            [self rightRun];
        }
        else{
            [self leftRun];
        }
       */
        

    }
    
    // We track the previous velocity, since it's important to determining how the character is and was moving for animations
    _velYPrev = self.physicsBody.velocity.y;

    
    
    if(false){
    /*
    // IDLE
    // The animation should be idle if the character was and is stationary
    // The character may only start idling if he or she was not already idling or falling
    if (_velYPrev == 0 && self.physicsBody.velocity.y == 0 && !_isIdling && !_isFalling) {
      //  CCLOG(@"IN updateAnimations _isIdling");
      // [self resetBools];
      //  _isIdling = YES;
      //  [self.animationManager runAnimationsForSequenceNamed:@"AnimIsoIdling"];
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

     
        
    }
    // old code
    
    */
    }
    
    
}

/*
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

// This method is called before setting one to YES, so that only one is ever YES at a time
-(void)resetBools {
    CCLOG(@"resetBools");
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
        self.physicsBody.velocity = ccp(0,_verticalIncrement);
        if(_isWalkingRight){
            self.physicsBody.velocity = ccp(_horizontalIncrement,_verticalIncrement);
        }else{
            self.physicsBody.velocity = ccp(-_horizontalIncrement,_verticalIncrement);
        }
    //}
}

-(void)right {
    CCLOG(@"Right Button Pressed");
    _isWalkingRight = YES;
    [self.animationManager runAnimationsForSequenceNamed:@"AnimSideWalking"];
    [self rightRun];

}
-(void)left {
    CCLOG(@"Left Button Pressed");
    _isWalkingRight = NO;
    [self.animationManager runAnimationsForSequenceNamed:@"AnimSideWalkingLeft"];
    [self leftRun];
}

-(void)rightRun {
    CCLOG(@"Right Run");
    self.physicsBody.velocity = ccp(_horizontalIncrement,0);
}
-(void)leftRun {
    CCLOG(@"Left Run");
    self.physicsBody.velocity = ccp(-_horizontalIncrement,0);
}



@end
    
