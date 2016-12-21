//
//  TreeNode.h
//  TestAlgrithm
//
//  Created by TANG HAO on 3/12/16.
//  Copyright © 2016年 Futu Network Technology Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNode : NSObject<NSCopying>

@property (nonatomic, strong) NSString *val;

@property (nonatomic, strong) TreeNode *left;

@property (nonatomic, strong) TreeNode *right;



@property (nonatomic, strong) NSArray *childrenNodes;

/**
 基于block使用递归方式，inorder遍历当前的tree
 
 @param block block
 */
- (void)enumInorderRecursivelyUsingBlock:(void (^)(NSString *res))block;

@end
