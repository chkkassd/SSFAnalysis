//
//  UIImage+ScaleSize.h
//  Chat
//
//  Created by 赛峰 施 on 15/10/21.
//  Copyright © 2015年 CZS Team 2015. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScaleSize)
+ (UIImage *)imageWithOriginImage:(UIImage*)image scaledToSize:(CGSize)newSize compressionQuality:(CGFloat)compressionQuality;
@end
