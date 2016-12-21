//
//  StringTests.m
//  THAlgorithm_iOS
//
//  Created by TANG HAO on 21/12/16.
//  Copyright © 2016年 HAOERO TANG. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "THAlgorithmString.h"

@interface StringTests : XCTestCase

@property (nonatomic, strong) THAlgorithmString *algorithmString;

@end

@implementation StringTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.algorithmString = [[THAlgorithmString alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLengthOfSubstring
{
    NSString *str1 = @"abcabcabb";
    NSString *str2 = @"bbbbba";
    NSString *str3 = @"pwwkewb";
    
    XCTAssertEqual(3, [self.algorithmString lengthOfLongestSubstring:str1]);
    XCTAssertEqual(2, [self.algorithmString lengthOfLongestSubstring:str2]);
    XCTAssertEqual(4, [self.algorithmString lengthOfLongestSubstring:str3]);
}

- (void)testPalindorme
{
    NSString *str1 = @"babad";
    NSString *str2 = @"abcddcb";
    NSString *str3 = @"dabaddaba";
    NSLog(@"longest palindorme of %@ is %@", str1, [self.algorithmString longestPalindorme:str1]);
    NSLog(@"longest palindorme of %@ is %@", str2, [self.algorithmString longestPalindorme:str2]);
    NSLog(@"longest palindorme of %@ is %@", str3, [self.algorithmString longestPalindorme:str3]);
}


@end
