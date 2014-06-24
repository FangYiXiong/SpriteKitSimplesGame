//
//  MyScene.m
//  SpriteKitSimplesGame
//
//  Created by FangYiXiong on 14-6-24.
//  Copyright (c) 2014年 Fang YiXiong. All rights reserved.
//

#import "MyScene.h"

@interface MyScene ()
@property (nonatomic) SKSpriteNode *player;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;//记录上一次生成怪物的时间
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;//记录上一次更新的时间
@end


@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        NSLog(@"Size: %@",NSStringFromCGSize(size));
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        self.player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
        self.player.position = CGPointMake(self.player.size.width/2, self.player.size.height/2);
        [self addChild:self.player];
        
    }
    return self;
}

-(void)addMonster{
    // 创建怪物Sprite
    SKSpriteNode *monster = [SKSpriteNode spriteNodeWithImageNamed:@"monster"];
    
    // 决定怪物在竖直方向上的出现位置
    int minY = monster.size.height / 2;
    int maxY = self.frame.size.height - monster.size.height / 2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    //在屏幕的右边缘偏出屏幕一点点的位置创建一个怪物，竖直位置为上面算出的随机值
    monster.position = CGPointMake(self.frame.size.width + monster.size.width/2, actualY);
    [self addChild:monster];
    
    // 设置怪物的速度
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // 创建动作
    SKAction *actionMove = [SKAction moveTo:CGPointMake(-monster.size.width/2, actualY) duration:actualDuration];
    SKAction *actionMoveDone = [SKAction removeFromParent];
    [monster runAction:[SKAction sequence:@[actionMove,actionMoveDone]]];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
