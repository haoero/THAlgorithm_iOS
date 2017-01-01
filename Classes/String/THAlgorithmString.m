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
 125. 题意：验证一串字符串是否是回文，只需要考虑其中的英文字母和数字，忽略其他字符
 例如："A man, a plan, a canal: Panama" is a palindrome.
 https://leetcode.com/problems/valid-palindrome/

 @param s 字符串
 @return 是否是回文
 */
- (BOOL)validatePalindorme:(NSString *)s
{
    NSInteger left = 0;
    NSInteger right = s.length - 1;
    if (right <= 1) {
        return YES;
    }
    NSString *lowerString = [s lowercaseString];
    while (left < right) {
        //找到左边第一个为数字或者字母的字符
        while (left < right && !(([lowerString characterAtIndex:left] >= 'a' && [lowerString characterAtIndex:left] <= 'z') || ([lowerString characterAtIndex:left] >= '0' && [lowerString characterAtIndex:left] <= '9')) ) {
            left ++;
        }
        //找到右边第一个为数字或者字母的字符
        while (left < right && !(([lowerString characterAtIndex:right] >= 'a' && [lowerString characterAtIndex:right] <= 'z') || ([lowerString characterAtIndex:right] >= '0' && [lowerString characterAtIndex:right] <= '9')) ) {
            right --;
        }
        
        if ([lowerString characterAtIndex:left] != [lowerString characterAtIndex:right]) {
            return NO;
        }
        
        left ++;
        right --;
    }
    return YES;
}


/**
 5. 题意：找最长的回文字符串
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

/**
 336. 
 题意：寻找所有回文对：例如 ["abcd","dcba","lls","s","sssll"]， 返回 [[0,1],[1,0],[3,2],[2,4]]
 https://leetcode.com/problems/palindrome-pairs/
 
 解题思路：（http://bookshadow.com/weblog/2016/03/10/leetcode-palindrome-pairs/）
 利用字典indexDic保存单词 -> 下标的键值对
 
 遍历单词列表words，记当前单词为word，下标为index：
 
 1). 若当前单词word本身为回文，且words中存在空串，则将空串下标bidx与idx加入答案
 
 2). 若当前单词的逆序串在words中，则将逆序串下标ridx与idx加入答案
 
 3). 将当前单词word拆分为左右两半left，right。
 
 3.1) 若left为回文，并且right的逆序串在words中，则将right的逆序串下标rridx与idx加入答案
 
 3.2) 若right为回文，并且left的逆序串在words中，则将left的逆序串下标idx与rlidx加入答案
 
 @param wordList 字符数组
 @return 回文对列表
 */
- (NSArray *)findAllPalindormePairs:(NSArray *)wordList
{
    NSMutableDictionary *indexDic = [NSMutableDictionary dictionary];
    NSMutableSet *set = [NSMutableSet set];
    for (NSInteger i = 0; i < wordList.count; i ++) {
        [indexDic setObject:@(i) forKey:wordList[i]];
    }
    
    for (NSInteger i = 0; i < wordList.count; i ++) {
        NSString *word = wordList[i];
        //如果存在空字符串，而且当前word是回文，则空字符串与当前的回文单词可以组成回文对
        if (indexDic[@""] && ![word isEqualToString:@""] && [self isPalindorme:word]) {
            [set addObject:@[indexDic[@""], @(i)]];
            [set addObject:@[@(i), indexDic[@""]]];
        }
        
        //如果当前单词的逆序也存在dic中，则其两者可以组成回文对
        NSString *reverse = [self reverseString:word];
        if (indexDic[reverse] && [indexDic[reverse] integerValue] != i) {
            [set addObject:@[indexDic[reverse], @(i)]];
            [set addObject:@[@(i), indexDic[reverse]]];
        }
        
        //遍历单词，检索单词的左右部分分别与另一半的逆序是否可以组成回文对
        for (NSInteger j = 1; j < word.length; j ++) {
            NSString *left = [word substringToIndex:j];
            NSString *right = [word substringFromIndex:j];
            NSString *rLeft = [self reverseString:left];
            NSString *rRight = [self reverseString:right];
            if (indexDic[rLeft] && [self isPalindorme:right]) {
                [set addObject:@[@(i), indexDic[rLeft]]];
            }
            if (indexDic[rRight] && [self isPalindorme:left]) {
                [set addObject:@[indexDic[rRight], @(i)]];
            }
        }
    }
    
    NSMutableArray *res = [NSMutableArray array];
    for (id temp in set) {
        [res addObject:temp];
    }
    return res;
}

- (BOOL)isPalindorme:(NSString *)word
{
    NSInteger left = 0;
    NSInteger right = word.length - 1;
    while (left < right && right > 0) {
        if ([word characterAtIndex:left] != [word characterAtIndex:right]) {
            return NO;
        }
        left ++;
        right --;
    }
    return YES;
}

- (NSString *)reverseString:(NSString *)s
{
    NSMutableString *mutStr = [NSMutableString string];
    for (NSInteger i = s.length - 1; i >= 0; i --) {
        [mutStr appendString:[NSString stringWithFormat:@"%c", [s characterAtIndex:i]]];
    }
    return [mutStr copy];
}

#pragma end

#pragma mark - ZigZag Conversion

/**
 6.
 题意：将字符串中的字符按照翻转的Z形状排列（类似于W），然后从上到下，从左到右读取每一行的字符，拼接成新的字符串返回
 https://leetcode.com/problems/zigzag-conversion/
 
 例如：
 "PAYPALISHIRING" 按照4行排列
 
 P     I     N
 A   L S   I G
 Y A   H R
 P     I
 
 返回结果是 "PINALSIGYAHRPI"
 
 解题思路：
 1. 将W的每一个V看成一组字符，而每组字符的顶部index都是相差(rows - 1)*2
 2. 从上到下，从左到右，遍历每组字符，然后拼接起来；
 3. 其中V的顶部和底部都只有一个字符，而V的左侧和右侧同一行的字符的index相差是 (rows - 1 - i)*2

 @param s 输入字符
 @param rows 行数
 @return 排列后的新字符串
 */
- (NSString *)convertZigZag:(NSString *)s rows:(NSInteger)rows
{
    if (s.length < rows || rows == 1) {
        return s;
    }
    NSMutableString *res = [NSMutableString string];
    NSInteger step = (rows - 1)*2;
    for (NSInteger i = 0; i < rows; i ++) {
        //将Z字型分成若干个V型，每个V代表一组，则每组顶部index相差step个字符
        for (NSInteger j = i; j < s.length; j += step) {
            [res appendFormat:@"%c", [s characterAtIndex:j]];
            //V的顶部和底部都只有一个字符，而中间有左右两个字符，右边字符与左边字符index相差(rows - 1 - i)*2
            if (i != 0 && i != rows - 1 && j + (rows - 1 - i)*2 < s.length) {
                [res appendFormat:@"%c", [s characterAtIndex:j + (rows - 1 - i)*2]];
            }
        }
    }
    return [res copy];
}

#pragma mark - String to Integer (atoi)


/**
 8. 
 题意：转换string到integer
 https://leetcode.com/problems/string-to-integer-atoi/
 
 test cases：
 "3"                    3
 "+2"                   2
 "-123"                 -123
 "    +11"              11
 "+-10"                 0
 "+13d9"                13
 "2147483648"           2147483647
 "-2147483647"          -2147483647
 "-2147483649"          -2147483648
 
 解题思路：
 此题主要是考虑各种边界条件
 1. 找到第一个不为空格的字符
 2. 判断当前是正数还是负数
 3. 从符号的下一位开始遍历，遇到非数字的字符则break,然后返回当前的结果，不考虑之后的字符
 4. 如果遇到数字，则考虑当前res是否会溢出，如果溢出，则break，返回结果
 
 INT_MAX (2147483647), INT_MIN (-2147483648)

 @param str 字符串
 @return 转换后的nsinteger
 */
- (int)myAtoi:(NSString *)str
{
    if (str.length == 0) {
        return 0;
    }
    NSInteger index = 0;
    while (index < str.length && [str characterAtIndex:index] == ' ') {
        index ++;
    }
    NSInteger sign = 1;
    NSInteger res = 0;
    //确定当前的正负
    if ([str characterAtIndex:index] == '+') {
        sign = 1;
        index ++;
    } else if ([str characterAtIndex:index] == '-') {
        sign = -1;
        index ++;
    }
    for (NSInteger i = index; i < str.length; i ++) {
        if ([str characterAtIndex:i] < '0' || [str characterAtIndex:i] > '9') {
            break;
        }
        //由于NSInteger 是long型的，所以此处不会溢出
        res = res*10 + ([str characterAtIndex:i] - '0');
        if (res > INT_MAX) {
            break;
        }
    }
    
    if (res * sign > INT_MAX) {
        return INT_MAX;
    } else if (res * sign < INT_MIN) {
        return INT_MIN;
    } else {
        return (int)(res * sign);
    }
}

#pragma mark - letter combination


/**
 17. Letter Combinations of a Phone Number
 https://leetcode.com/problems/letter-combinations-of-a-phone-number/
 
 题意：输入电话键盘上的数字2~9组成的字符串，输出这些数字对应的英文字母的全排序
 Input:Digit string "23"
 Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
 
 解题思路：
 有两种方式：
 一种是迭代的方式，依次读取字符串中的每位数字，然后把数字对应的字母依次加到当前的所有结果中，然后进入下一次迭代
 递归的方式，思路也类似，就是对于当前已有的字符串，递归剩下的数字串，然后得到结果后加上去。假设输入字符串总共有n个数字，平均每个数字可以代表m个字符，那么时间复杂度是O(m^n)，确切点是输入字符串中每个数字对应字母数量的乘积，即结果的数量，空间复杂度也是一样。

 @param digits 输入数字字符串
 @return 对应字母的全排序数组
 */
- (NSArray *)recursiveletterCombinations:(NSString *)digits
{
    if (digits.length == 0) {
        return [NSArray array];
    }
    
    NSArray *pad = @[@"", @"", @"abc", @"def", @"ghi", @"jkl", @"mno", @"pqrs", @"tuv", @"wxyz"];
    NSMutableArray *res = [NSMutableArray array];
    [self recursiveCombinations:digits pad:pad index:0 temp:@"" res:res];
    return [res copy];
}

- (void)recursiveCombinations:(NSString *)digits pad:(NSArray *)pad index:(NSInteger)index temp:(NSString *)temp res:(NSMutableArray *)res
{
    if (index == digits.length) {
        [res addObject:temp];
    } else {
        NSString *cur = pad[[digits characterAtIndex:index] - '0'];
        for (NSInteger i = 0; i < cur.length; i ++) {
            [self recursiveCombinations:digits pad:pad index:index + 1 temp:[temp stringByAppendingFormat:@"%c", [cur characterAtIndex:i]] res:res];
        }
    }
}

- (NSArray *)iterateLetterCombinations:(NSString *)digits
{
    if (digits.length == 0) {
        return [NSArray array];
    }
    
    NSArray *pad = @[@"", @"", @"abc", @"def", @"ghi", @"jkl", @"mno", @"pqrs", @"tuv", @"wxyz"];
    NSMutableArray *res = [NSMutableArray array];
    [res addObject:@""];
    
    for (NSInteger i = 0; i < digits.length; i ++) {
        NSMutableArray *tempRes = [NSMutableArray array];
        NSString *cur = pad[[digits characterAtIndex:i] - '0'];
        for (NSInteger j = 0; j < res.count; j ++) {
            NSString *temp = res[j];
            for (NSInteger k = 0; k < cur.length; k ++) {
                [tempRes addObject:[NSString stringWithFormat:@"%@%c", temp, [cur characterAtIndex:k]]];
            }
        }
        res = [tempRes mutableCopy];
    }
    return [res copy];
}

#pragma mark - Valid Parentheses

/**
 20.Valid Parentheses
 https://leetcode.com/problems/valid-parentheses/
 
 题意: 判断由'(', ')', '{', '}', '[' 和 ']' 字符组成的字符串是否符合open 对 close的规则；
 
 解题关键：
 使用数据结构栈的特性，每次遇到open的字符，则加入栈，遇到close的字符就与栈顶字符比对，是否能组成一对即可；
 最后遍历完了，如果栈为空则为valid，否则为invalid

 @param str 输入字符串
 @return 是否valid
 */
- (BOOL)isValidParentheses:(NSString *)str
{
    if (str.length%2 == 1) {
        return NO;
    }
    
    NSMutableArray *stack = [NSMutableArray array];
    NSInteger index = 0;
    while (index < str.length) {
        char cur = [str characterAtIndex:index];
        if (cur == '(' || cur == '{' || cur == '[') {
            [stack addObject:[NSString stringWithFormat:@"%c", cur]];
        } else {
            if (stack.count == 0) {
                return NO;
            }
            char last = [[stack lastObject] characterAtIndex:0];
            [stack removeLastObject];
            if (!((last == '(' && cur == ')') || (last == '{' && cur == '}') || (last == '[' && cur == ']'))) {
                return NO;
            }
        }
        index ++;
    }
    
    if (stack.count == 0) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Generate Parentheses


/**
 22.Generate Parentheses
 https://leetcode.com/problems/generate-parentheses/
 
 题意：
 用n对括号，生成所有正确的形式，符合上题的valid
 
 解题思路：
 使用递归的方式穷举所有排列，由于只有左右括号，所以每个排列结果中必定有n个左括号，和n个右括号；
 1. 定义两个变量left和right分别表示剩余左右括号的个数；
 2. 如果在某次递归时，左括号的个数大于右括号的个数，说明此时生成的字符串中右括号的个数大于左括号的个数，即会出现')('这样的非法串，所以这种情况直接返回，不继续处理。
 3. 如果left和right都为0，则说明此时生成的字符串已有3个左括号和3个右括号，且字符串合法，则存入结果中后返回。
 4. 如果以上两种情况都不满足，若此时left大于0，则调用递归函数，注意参数的更新，若right大于0，则调用递归函数，同样要更新参数。
 

 @param n n对括号
 @return 全排列
 */
- (NSArray *)generateParentheses:(NSInteger)n
{
    if (n <= 0) {
        return [NSArray array];
    }
    NSMutableArray *res = [NSMutableArray array];
    [self recursiveGenerateParentheses:n right:n temp:@"" res:res];
    return [res copy];
}

- (void)recursiveGenerateParentheses:(NSInteger)left right:(NSInteger)right temp:(NSString *)temp res:(NSMutableArray *)res
{
    if (left < 0 || right < 0 || left > right) {
        return;
    }
    if (left == 0 && right == 0) {
        [res addObject:temp];
    } else {
        if (left > 0) {
            [self recursiveGenerateParentheses:left - 1 right:right temp:[temp stringByAppendingString:@"("] res:res];
        }
        if (right > 0) {
            [self recursiveGenerateParentheses:left right:right - 1 temp:[temp stringByAppendingString:@")"] res:res];
        }
    }
}

@end
