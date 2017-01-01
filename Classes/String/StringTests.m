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
    NSString *test1 = @"A man, a plan, a canal: Panama";
    NSString *test2 = @"race a car";
    
    XCTAssertTrue([self.algorithmString validatePalindorme:test1]);
    XCTAssertFalse([self.algorithmString validatePalindorme:test2]);
    
    NSString *str1 = @"babad";
    NSString *str2 = @"abcddcb";
    NSString *str3 = @"dabaddaba";
    NSLog(@"longest palindorme of %@ is %@", str1, [self.algorithmString longestPalindorme:str1]);
    NSLog(@"longest palindorme of %@ is %@", str2, [self.algorithmString longestPalindorme:str2]);
    NSLog(@"longest palindorme of %@ is %@", str3, [self.algorithmString longestPalindorme:str3]);
    
    NSArray *wordsList1 = @[@"abcd", @"dcba", @"lls", @"s", @"sssll"];
    NSArray *wordsList2 = @[@"bat", @"tab", @"cat"];
    
    NSLog(@"wordsList = %@, palindorme pairs = %@",wordsList1, [self.algorithmString findAllPalindormePairs:wordsList1]);
    
    NSLog(@"wordsList = %@, palindorme pairs = %@",wordsList2, [self.algorithmString findAllPalindormePairs:wordsList2]);
    
}

- (void)testZigzag
{
    NSString *str = @"PAYPALISHIRING";
    NSLog(@"zigzag string = %@", [self.algorithmString convertZigZag:str rows:4]);
}

- (void)testAtoi
{
    XCTAssertEqual(3, [self.algorithmString myAtoi:@"3"]);
    XCTAssertEqual(2, [self.algorithmString myAtoi:@"+2"]);
    XCTAssertEqual(-123, [self.algorithmString myAtoi:@"-123"]);
    XCTAssertEqual(11, [self.algorithmString myAtoi:@"    +11"]);
    XCTAssertEqual(0, [self.algorithmString myAtoi:@"+-10"]);
    XCTAssertEqual(13, [self.algorithmString myAtoi:@"+13d9"]);
    XCTAssertEqual(2147483647, [self.algorithmString myAtoi:@"2147483648"]);
    XCTAssertEqual(-2147483647, [self.algorithmString myAtoi:@"-2147483647"]);
    XCTAssertEqual(-2147483648, [self.algorithmString myAtoi:@"-2147483649"]);
}

- (void)testPhonePadCombinations
{
    NSString *digits1 = @"23";
    NSString *digits2 = @"239";

    NSLog(@"letter combinations of digits:%@  is %@", digits1, [self.algorithmString recursiveletterCombinations:digits1]);
    NSLog(@"letter combinations of digits:%@  is %@", digits2, [self.algorithmString recursiveletterCombinations:digits2]);

    NSLog(@"letter combinations of digits:%@  is %@", digits1, [self.algorithmString iterateLetterCombinations:digits1]);
    NSLog(@"letter combinations of digits:%@  is %@", digits2, [self.algorithmString iterateLetterCombinations:digits2]);
}

- (void)testParentheses
{
    NSArray *cases = @[@"[", @"", @"[]", @"{[]}", @"{[)}", @"((([{()}))]"];
    NSArray *res = @[@(NO), @(YES), @(YES), @(YES), @(NO), @(NO)];
    for (NSInteger i = 0; i < cases.count; i ++) {
        XCTAssertEqual(res[i], @([self.algorithmString isValidParentheses:cases[i]]));
    }
    
    NSLog(@"all parenthesese = %@", [self.algorithmString generateParentheses:3]);
}

@end
