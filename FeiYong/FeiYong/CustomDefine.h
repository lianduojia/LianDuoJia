//
//  CustomDefine.h
//  FeiYong
//
//  Created by 周大钦 on 16/5/26.
//  Copyright © 2016年 ldj. All rights reserved.
//

#ifndef CustomDefine_h
#define CustomDefine_h

#define DEVICE_NavBar_Height            (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)?64.0:44.0f)

#define DEVICE_TabBar_Height            (50.0)
#define DEVICE_Width                    ([[UIScreen mainScreen] bounds].size.width)
#define DEVICE_Height                   ([[UIScreen mainScreen] bounds].size.height)
#define DEVICE_InStatusBar_Height       ([[UIScreen mainScreen] bounds].size.height - DEVICE_StatuBar_Height)
#define DEVICE_InNavTabBar_Height       ([[UIScreen mainScreen] bounds].size.height - DEVICE_NavBar_Height - DEVICE_TabBar_Height)

#define DEVICE_InNavBar_Height          (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)?[[UIScreen mainScreen] bounds].size.height-64.0:[[UIScreen mainScreen] bounds].size.height-44.0f)

#define M_NAVCO [UIColor whiteColor]
#define M_CO    [UIColor colorWithRed:164/255.0f green:78/255.0f blue:179/255.0f alpha:1.000]
#define M_BGCO  [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:1.000]
#define M_LINECO  [UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1.000]
#define M_TCO  [UIColor colorWithRed:49/255.0f green:50/255.0f blue:51/255.0f alpha:1.000]
#define M_TCO2  [UIColor colorWithRed:151/255.0f green:151/255.0f blue:151/255.0f alpha:1.000]


#endif /* CustomDefine_h */
