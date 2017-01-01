//
//  THAlgorithmString.h
//  THAlgorithm_iOS
//
//  Created by TANG HAO on 21/12/16.
//  Copyright © 2016年 HAOERO TANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THAlgorithmString : NSObject

#pragma mark - longest substring

- (NSInteger)lengthOfLongestSubstring:(NSString *)s;

#pragma mark - palindormic string

- (BOOL)validatePalindorme:(NSString *)s;

- (NSString *)longestPalindorme:(NSString *)s;

- (NSArray *)findAllPalindormePairs:(NSArray *)wordList;

#pragma mark - ZigZag Conversion

- (NSString *)convertZigZag:(NSString *)s rows:(NSInteger)rows;

#pragma mark - String to Integer (atoi)

- (int)myAtoi:(NSString *)str;

#pragma mark - letter combination

- (NSArray *)recursiveletterCombinations:(NSString *)digits;

- (NSArray *)iterateLetterCombinations:(NSString *)digits;

#pragma mark - Valid Parentheses

- (BOOL)isValidParentheses:(NSString *)str;

#pragma mark - Generate Parentheses

- (NSArray *)generateParentheses:(NSInteger)n;

@end
