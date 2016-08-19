//
//  CustomDefine.h
//  FeiYong
//
//  Created by 周大钦 on 16/5/26.
//  Copyright © 2016年 ldj. All rights reserved.
//

#ifndef CustomDefine_h
#define CustomDefine_h

#define DeviceIsiPhone4				([[UIScreen mainScreen] bounds].size.height == 480.0)

#define DEVICE_NavBar_Height            (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)?64.0:44.0f)

#define DEVICE_TabBar_Height            (50.0)
#define DEVICE_Width                    ([[UIScreen mainScreen] bounds].size.width)
#define DEVICE_Height                   ([[UIScreen mainScreen] bounds].size.height)
#define DEVICE_InStatusBar_Height       ([[UIScreen mainScreen] bounds].size.height - DEVICE_StatuBar_Height)
#define DEVICE_InNavTabBar_Height       ([[UIScreen mainScreen] bounds].size.height - DEVICE_NavBar_Height - DEVICE_TabBar_Height)

#define DEVICE_InNavBar_Height          (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)?[[UIScreen mainScreen] bounds].size.height-64.0:[[UIScreen mainScreen] bounds].size.height-44.0f)

#define M_NAVCO [UIColor whiteColor]
#define M_CO    [UIColor colorWithRed:255/255.0f green:188/255.0f blue:6/255.0f alpha:1.000]
#define M_BGCO  [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.000]
#define M_LINECO  [UIColor colorWithRed:237/255.0f green:237/255.0f blue:237/255.0f alpha:1.000]
#define M_TCO  [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.000]
#define M_TCO2  [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.000]
#define M_TCO3  [UIColor colorWithRed:195/255.0f green:195/255.0f blue:195/255.0f alpha:1.000]

#ifdef DEBUG
#define MLLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define MLLog(format, ...)
#endif

#define MLLog_VC(_Method_)  MLLog(@"%@ %@",[self description],@_Method_);

#endif /* CustomDefine_h */
