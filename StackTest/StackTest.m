//
//  StackTest.m
//  StackTest
//
//  Created by chen liangxiu on 2017/9/30.
//  Copyright © 2017年 com.best.ios.bexrunner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BSTStack.h"
@interface StackTest : XCTestCase

@property (nonatomic, strong) BSTStack<NSNumber *> *stack;

@end

@implementation StackTest

- (void)setUp {
    [super setUp];
    _stack = [[BSTStack alloc] initWithCapacity:100 isThreadSafe:NO];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPushNil
{
    BOOL rt = [self.stack push:nil];
    XCTAssert(rt == NO, @"nil exception");
}

- (void)testPushNormal
{
    BOOL rt = [self.stack push:@1];
    XCTAssert(rt == YES);
}

- (void)testPushThenPop
{
    [self.stack push:@2];
    XCTAssert(self.stack.count == 1);
    NSNumber *num = [self.stack pop];
    XCTAssert(num.integerValue == 2);
    XCTAssert(self.stack.count == 0);
}

- (void)testEmptyPoP
{
    NSArray *arr = [self.stack popAll];
    XCTAssert(arr.count == 0);
    XCTAssert(self.stack.count == 0);
    id obj = [self.stack pop];
    XCTAssert(obj == nil);
}

- (void)testFastEnum
{
    for (NSNumber *__unused nun in self.stack) {
        XCTAssert(nil);
    }
    [self.stack push:@1];
    [self.stack push:@2];
    for (NSNumber *num in self.stack) {
        XCTAssert([num isKindOfClass:[NSNumber class]]);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{

    }];
}

@end
