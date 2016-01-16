//
//  MQPageView.h
//  HomeWork3_2_ScrollView
//
//  Created by Michael Qiu on 16/1/16.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MQPageView : UIView

/**
 *  图片名字
 */
@property (nonatomic, strong) NSArray *imageNames;
/**
 *  其他圆点的颜色
 */
@property (nonatomic, strong) UIColor *otherColor;
/**
 *  当前圆点的颜色
 */
@property (nonatomic, strong) UIColor *currentColor;

+ (instancetype)pageView;

@end
