//
//  TreePair.m
//  TestAlgrithm
//
//  Created by TANG HAO on 3/12/16.
//  Copyright © 2016年 Futu Network Technology Limited. All rights reserved.
//

#import "TreePair.h"

@implementation TreePair

- (id)copyWithZone:(NSZone *)zone
{
    TreePair *pair = [[TreePair alloc]init];
    pair.node = [_node copy];
    pair.depth = _depth;
    return pair;
}

@end
