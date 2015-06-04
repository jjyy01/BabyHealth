//
//  Common.h
//  BabyHealth
//
//  Created by jiwei on 15/6/4.
//  Copyright (c) 2015年 weiji.info. All rights reserved.
//

#ifndef BabyHealth_Common_h
#define BabyHealth_Common_h

//控制NSLog只在debug模式下输出

#ifdef DEBUG 
    #define DBLog(...) NSLog(__VA_ARGS__)
#else
    #define DBSLog(...) {}
#endif 

#endif