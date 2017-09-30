//
//  BSTStack.m
//  BSTStack
//
//  Created by chen liangxiu on 2017/9/30.
//  Copyright © 2017年 com.best.ios.bexrunner. All rights reserved.
//

#import "BSTStack.h"
#import <pthread.h>

#define MutexLock(lk) ({ _needThreadSafe ? pthread_mutex_lock(&lk) : (void)0; })
#define MutexUnlock(lk) ({ _needThreadSafe ? pthread_mutex_unlock(&lk) : (void)0; })

@interface BSTStack<__covariant ObjectType>()

@property (nonatomic, assign,) BOOL needThreadSafe;
@property (nonatomic, strong) NSMutableArray<ObjectType> *stackArray;

@end

@implementation BSTStack
{
    pthread_mutex_t _stackLocker;
}

- (void)dealloc
{
    if (self.needThreadSafe) {
        pthread_mutex_destroy(&_stackLocker);
    }
}

- (instancetype)init
{
    return [self initWithCapacity:0 isThreadSafe:YES];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity isThreadSafe:(BOOL)need
{
    if (self = [super init]) {
        _stackArray = [NSMutableArray arrayWithCapacity:capacity];
        _needThreadSafe = need;
        /* mutex locker init */
        {
            if (_needThreadSafe) {
                pthread_mutexattr_t mattr;
                pthread_mutexattr_init(&mattr);
                pthread_mutexattr_settype(&mattr,PTHREAD_MUTEX_NORMAL);
                pthread_mutex_init(&_stackLocker, &mattr);
                pthread_mutexattr_destroy(&mattr);
            } else {
                /* needn't init */
            }
        }
    }
    return self;
}

- (BOOL)push:(id)obj
{
    if (!obj) return NO;
    MutexLock(_stackLocker);
    [self.stackArray addObject:obj];
    MutexUnlock(_stackLocker);
    return YES;
}

- (id)pop
{
    
    MutexLock(_stackLocker);
    id obj = self.stackArray.lastObject;
    MutexUnlock(_stackLocker);
    if (obj) {
        MutexLock(_stackLocker);
        [self.stackArray removeObjectAtIndex:self.stackArray.count - 1];
        MutexUnlock(_stackLocker);
    }
    return obj;
}

- (NSArray *)popAll
{
    NSArray *drops = [self allObjects];
    MutexLock(_stackLocker);
    [self.stackArray removeAllObjects];
    MutexUnlock(_stackLocker);
    return drops;
}

- (NSUInteger)count
{
    MutexLock(_stackLocker);
    NSUInteger count = [self.stackArray count];
    MutexUnlock(_stackLocker);
    return count;
}

- (NSArray *)allObjects
{
    MutexLock(_stackLocker);
    NSArray *duplicated = self.stackArray.copy;
    MutexUnlock(_stackLocker);
    return duplicated;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id  _Nullable __unsafe_unretained [])buffer count:(NSUInteger)len
{
    MutexLock(_stackLocker);
    NSUInteger count = [self.stackArray countByEnumeratingWithState:state objects:buffer count:len];
    MutexUnlock(_stackLocker);
    return count;
}

@end
