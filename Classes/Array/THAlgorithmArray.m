//
//  THAlgorithmArray.m
//  THAlgorithm_iOS
//
//  Created by TANG HAO on 21/12/16.
//  Copyright © 2016年 HAOERO TANG. All rights reserved.
//

#import "THAlgorithmArray.h"

@implementation THAlgorithmArray

#pragma mark - move zeros


/**
 题意：移动所有为0的数字到数组的后面
 https://leetcode.com/problems/move-zeroes/
 
 解题思路：
 1. 采用双指针的方式，左指针指向第一个为0的数字的位置，右指针指向第一个不为0的数字；
 2. 移动右指针时，遇到不为0的数字就与左指针交换，保证所有的非0数字都在前面，并更新左指针
 
 @param nums 数字数组
 */
- (void)moveZerosToEnd:(NSMutableArray *)nums
{
    //第一个为0的数字所在的位置，这样每次找到非0的数，即交互位置，保证非0的数都在前面
    NSInteger firstZeroIndex = 0;
    for (NSInteger right = firstZeroIndex; right < nums.count; right ++) {
        if ([nums[right] integerValue] != 0) {
            [nums exchangeObjectAtIndex:firstZeroIndex withObjectAtIndex:right];
            firstZeroIndex ++;
        }
    }
    //非0数字的个数：count = firstZeroIndex
}

- (void)moveZerosToBegin:(NSMutableArray *)nums
{
    //最后一个为0的数字所在的位置，这样每次找到非0的数，即跟其交换位置，保证非0数移动到后面
    NSInteger lastZeroIndex = nums.count - 1;
    for (NSInteger left = lastZeroIndex; left >= 0; left --) {
        if ([nums[left] integerValue] != 0) {
            [nums exchangeObjectAtIndex:left withObjectAtIndex:lastZeroIndex];
            lastZeroIndex --;
        }
    }
    //非0数字的个数：count = nums.count - (lastZeroIndex + 1)
}


@end
