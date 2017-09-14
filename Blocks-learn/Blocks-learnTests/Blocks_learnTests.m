//
//  Blocks_learnTests.m
//  Blocks-learnTests
//
//  Created by 中川 慶悟 on 2017/09/14.
//  Copyright © 2017年 nk5. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Blocks_learnTests : XCTestCase

@end

@implementation Blocks_learnTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    [self hello:^(){
        NSLog(@"test");
    }];
    [self hello:nil]; // when callback is nil, app will crash!!
}

- (void)hello:(void (^)(void))callback {
    NSLog(@"hello");
    callback();
}
@end
