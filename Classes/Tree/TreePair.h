//
//  TreePair.h
//  TestAlgrithm
//
//  Created by TANG HAO on 3/12/16.
//  Copyright © 2016年 Futu Network Technology Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"

@interface TreePair : NSObject<NSCopying>

@property (nonatomic, strong) TreeNode *node;

@property (nonatomic, assign) NSInteger depth;

@end
