//
//  SSFMoneyTypeManager.h
//  SSFAnalysis
//
//  Created by 赛峰 施 on 16/3/24.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SSFMoneyTypeManager : NSObject
+ (NSNumber *)numberWithMoneyTypeString:(NSString *)string;
+ (NSString *)moneyTypeStringWithNumber:(NSNumber *)number;
+ (UIColor *)colorOfSubtypeWithNumber:(NSNumber *)number;
@end
