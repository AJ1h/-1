//
//  BSTStack.h
//  BSTStack
//
//  Created by chen liangxiu on 2017/9/30.
//  Copyright © 2017年 com.best.ios.bexrunner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTStack<__covariant ObjectType> : NSObject<NSFastEnumeration>

- (instancetype)init;
- (instancetype)initWithCapacity:(NSUInteger)capacity isThreadSafe:(BOOL)need NS_DESIGNATED_INITIALIZER;


- (BOOL)push:(ObjectType)obj;
- (ObjectType)pop;
- (NSArray<ObjectType> *)popAll;
- (NSUInteger)count;
- (NSArray<ObjectType> *)allObjects;

@end
