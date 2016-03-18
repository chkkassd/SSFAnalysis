//
//  CoreDataManager.h
//  LongCube
//
//  Created by zhou dengfeng derek on 11/5/15.
//  Copyright (c) 2015 zhou dengfeng derek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *mainQueueContext;
@property (nonatomic, strong, readonly) NSManagedObjectContext *privateQueueContext;

- (BOOL)startConnectCoreData;
- (BOOL)stopConnectCoreData;

@property (nonatomic, readonly, getter=isConnecting) BOOL connecting;

+ (instancetype)sharedManager;

@end
