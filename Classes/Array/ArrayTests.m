//
//  ArrayTests.m
//  THAlgorithm_iOS
//
//  Created by TANG HAO on 22/12/16.
//  Copyright © 2016年 HAOERO TANG. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "THAlgorithmArray.h"

@interface ArrayTests : XCTestCase

@property (nonatomic, strong) THAlgorithmArray *algorithmArray;

@end

@implementation ArrayTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.algorithmArray = [[THAlgorithmArray alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMoveZeros
{
    NSArray *original1 = @[@3, @0, @0, @1, @4, @0, @2];
    NSArray *original2 = @[@0, @2, @7, @1, @4, @9, @0];
    NSArray *original3 = @[];
    
    NSMutableArray *test1 = [NSMutableArray arrayWithArray:original1];
    NSMutableArray *test2 = [NSMutableArray arrayWithArray:original2];
    NSMutableArray *test3 = [NSMutableArray arrayWithArray:original3];
    
    [self.algorithmArray moveZerosToEnd:test1];
    [self.algorithmArray moveZerosToEnd:test2];
    [self.algorithmArray moveZerosToEnd:test3];
    
    NSLog(@"move zeros to the end:");
    NSLog(@"original1 = %@, test1 = %@", original1, test1);
    NSLog(@"original1 = %@, test1 = %@", original2, test2);
    NSLog(@"original1 = %@, test1 = %@", original3, test3);
    
    test1 = [NSMutableArray arrayWithArray:original1];
    test2 = [NSMutableArray arrayWithArray:original2];
    test3 = [NSMutableArray arrayWithArray:original3];
    
    [self.algorithmArray moveZerosToBegin:test1];
    [self.algorithmArray moveZerosToBegin:test2];
    [self.algorithmArray moveZerosToBegin:test3];
    
    NSLog(@"move zeros to the begin:");
    NSLog(@"original1 = %@, test1 = %@", original1, test1);
    NSLog(@"original1 = %@, test1 = %@", original2, test2);
    NSLog(@"original1 = %@, test1 = %@", original3, test3);
}


@end
