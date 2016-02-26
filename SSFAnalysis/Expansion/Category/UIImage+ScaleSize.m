//
//  UIImage+ScaleSize.m
//  Chat
//
//  Created by 赛峰 施 on 15/10/21.
//  Copyright © 2015年 CZS Team 2015. All rights reserved.
//

#import "UIImage+ScaleSize.h"

@implementation UIImage (ScaleSize)

//将图片压缩到指定宽高
+ (UIImage *)imageWithOriginImage:(UIImage*)image scaledToSize:(CGSize)newSize compressionQuality:(CGFloat)compressionQuality
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(newImage, compressionQuality);
    
    return [UIImage imageWithData:imageData];
}

@end
