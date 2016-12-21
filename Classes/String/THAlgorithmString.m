//
//  THAlgorithmString.m
//  THAlgorithm_iOS
//
//  Created by TANG HAO on 21/12/16.
//  Copyright © 2016年 HAOERO TANG. All rights reserved.
//

#import "THAlgorithmString.h"

@implementation THAlgorithmString

#pragma mark - longest substring

/**
 3. Longest Substring Without Repeating Characters
 https://leetcode.com/problems/longest-substring-without-repeating-characters/
 
 题意：寻找字符串中最长无重复子串长度
 如：Given "abcabcbb", the answer is "abc", which the length is 3.
 
 解题思路：
 1. 使用双指针，左指针记录当前没有重复子串的第一个字符，右指针遍历移动，并用dic记录右指针遍历过的所有字符的位置
 2. 如果右指针对应字符在之前出现过，则更新左指针的位置到右指针指向的字符之前出现过的位置的后一个字符，保证当前左右指针中间的字符都是没有重复的
 3. 更新最大无重复子串的长度
 
 Time Complexity = O(N)

 @param s 输入字符串
 @return 最长无重复子串长度
 */
- (NSInteger)lengthOfLongestSubstring:(NSString *)s
{
    NSInteger left = 0;
    NSInteger right = 0;
    NSInteger maxLength = 0;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    while (right < s.length) {
        NSString *temp = [s substringWithRange:NSMakeRange(right, 1)];
        //如果当前字符之前出现过，则更新左指针到上一个出现过的位置的后一个
        if (dic[temp] && [dic[temp] integerValue] >= left) {
            left = [dic[temp] integerValue] + 1;
        }
        //更新当前字符的位置信息到dic中
        [dic setObject:@(right) forKey:temp];
        //更新最大长度
        maxLength = MAX(right - left + 1, maxLength);
        right ++;
    }
    return maxLength;
}

#pragma end

#pragma mark - palindormic string


/**
 题意：找最长的回文字符串
 https://leetcode.com/problems/longest-palindromic-substring/
 
 解题思路：
 1. 回文字符串的中心点的左右肯定是对称的，但是可能有一个字符或者两个字符一起构成中心点
 2. 遍历字符串，从中心点往两边扩展，找到当前中心点下的最长的回文串
 3. 更新全局最长的回文子串，只需要记录start 和 end即可
 
 @param s 字符串
 @return 最长的回文字符串
 */
- (NSString *)longestPalindorme:(NSString *)s
{
    if (s.length == 0) {
        return nil;
    }
    NSInteger start = 0;
    NSInteger end = 0;
    for (NSInteger i = 0; i < s.length; i ++) {
        NSInteger length1 = [self expandLengthFromCenter:s left:i right:i];
        NSInteger length2 = [self expandLengthFromCenter:s left:i right:i + 1];
        NSInteger maxLength = MAX(length1, length2);
        if (end - start < maxLength) {
            start = i - (maxLength - 1)/2;
            end = i + maxLength/2;
        }
    }
    return [s substringWithRange:NSMakeRange(start, end - start + 1)];
}

- (NSInteger)expandLengthFromCenter:(NSString *)s left:(NSInteger)left right:(NSInteger)right
{
    while (left >= 0 && right < s.length && [s characterAtIndex:left] == [s characterAtIndex:right]) {
        left --;
        right ++;
    }
    //由于退出while循环前，这里的left小了1，right大了1
    //因此真正的长度计算应该是 (right - 1) - （left + 1） + 1 = right - left - 1
    return right - left - 1;
}


@end
