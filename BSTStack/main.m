//
//  main.m
//  BSTStack
//
//  Created by chen liangxiu on 2017/9/30.
//  Copyright © 2017年 com.best.ios.bexrunner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSTStack.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        BSTStack<NSNumber *> *stack = [BSTStack new];
        [stack push:@1];
        [stack push:@2];
        [stack push:@3];
        [stack push:@4];
        [stack pop];
        for (NSNumber *num in stack) {
            NSLog(@"%ld",num.intValue);
        }
        NSLog(@"Hello, World!");
    }
    return 0;
}
