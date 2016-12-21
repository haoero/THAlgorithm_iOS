//
//  TreeNode.m
//  TestAlgrithm
//
//  Created by TANG HAO on 3/12/16.
//  Copyright © 2016年 Futu Network Technology Limited. All rights reserved.
//

#import "TreeNode.h"

@implementation TreeNode

- (NSString *)description
{
    return [NSString stringWithFormat:@"tree value = [%@]", self.val];
}

- (id)copyWithZone:(NSZone *)zone
{
    TreeNode *node = [[[self class] allocWithZone:zone] init];
    node.val = [_val copyWithZone:zone];
    node.left = [_left copyWithZone:zone];
    node.right = [_right copyWithZone:zone];
    node.childrenNodes = [_childrenNodes copy];//[[NSArray alloc] initWithArray:_childrenNodes copyItems:YES];

    return node;
}



/**
 基于block使用递归方式，inorder遍历当前的tree

 @param block block
 */
- (void)enumInorderRecursivelyUsingBlock:(void (^)(NSString *res))block
{
    NSMutableString *str = [NSMutableString string];
    if (self.left) {
        [self.left enumInorderRecursivelyUsingBlock:^(NSString *res) {
            [str appendString:res];
        }];
    }
    
    [str appendString:self.val];
    
    if (self.right) {
        [self.right enumInorderRecursivelyUsingBlock:^(NSString *res) {
            [str appendString:res];
        }];
    }
    
    block(str);
}

@end
