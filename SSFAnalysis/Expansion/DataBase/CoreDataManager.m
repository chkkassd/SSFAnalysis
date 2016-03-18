//
//  CoreDataManager.m
//  LongCube
//
//  Created by zhou dengfeng derek on 11/5/15.
//  Copyright (c) 2015 zhou dengfeng derek. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager ()
@property (nonatomic, strong) NSManagedObjectContext *mainQueueContext;
@property (nonatomic, strong) NSManagedObjectContext *privateQueueContext;
@property (nonatomic, getter=isConnecting) BOOL connecting;
@end

@implementation CoreDataManager

- (BOOL)startConnectCoreData {
    
    if (self.privateQueueContext && self.mainQueueContext) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.mainQueueContext];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.privateQueueContext];
        self.privateQueueContext = nil;
        self.mainQueueContext = nil;
    }
    
    self.privateQueueContext = [self getPrivateQueueContext];
    self.mainQueueContext = [self getMainQueueContext];
    
    if (self.privateQueueContext && self.mainQueueContext) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(mainQueueContextDidSave:)
                                                     name:NSManagedObjectContextDidSaveNotification
                                                   object:self.mainQueueContext];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(privateQueueContextDidSave:)
                                                     name:NSManagedObjectContextDidSaveNotification
                                                   object:self.privateQueueContext];
        
        self.connecting = YES;
        return YES;
    }
    
    return NO;
}

- (BOOL)stopConnectCoreData {
    if (self.isConnecting && self.privateQueueContext && self.mainQueueContext) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.mainQueueContext];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.privateQueueContext];
        self.privateQueueContext = nil;
        self.mainQueueContext = nil;
        self.connecting = NO;
    }
    return YES;
}

- (NSManagedObjectContext *)getPrivateQueueContext {
    NSManagedObjectContext *managedObjectContext = nil;
    NSPersistentStoreCoordinator *coordinator = [self createPersistentStoreCoordinator];
    if (coordinator) {
        managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return managedObjectContext;
}

- (NSManagedObjectContext *)getMainQueueContext {
    NSManagedObjectContext *managedObjectContext = nil;
    NSPersistentStoreCoordinator *coordinator = [self createPersistentStoreCoordinator];
    if (coordinator) {
        managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return managedObjectContext;
}

#pragma mark - Notification for Core Data

- (void)mainQueueContextDidSave:(NSNotification *)notification
{
    @synchronized(self) {
        [self.privateQueueContext performBlock:^{
            [self.privateQueueContext mergeChangesFromContextDidSaveNotification:notification];
        }];
    }
}

- (void)privateQueueContextDidSave:(NSNotification *)notification
{
    @synchronized(self) {
        [self.mainQueueContext performBlock:^{
            [self.mainQueueContext mergeChangesFromContextDidSaveNotification:notification];
        }];
    }
}

#pragma mark - Core Data

- (NSManagedObjectModel *)createManagedObjectModel {
    NSManagedObjectModel *managedObjectModel = nil;
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Analysis" withExtension:@"momd"];
        managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)createPersistentStoreCoordinator {
    NSPersistentStoreCoordinator *persistentStoreCoordinator = nil;
    NSManagedObjectModel *managedObjectModel = [self createManagedObjectModel];
    if (managedObjectModel) {
        // @"com.coredata.longcube.newversion.sqlite"
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Analysis.sqlite"];
        
        NSError *error = nil;
        persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
        NSDictionary *options = @{ NSMigratePersistentStoresAutomaticallyOption : @YES,
                                   NSInferMappingModelAutomaticallyOption : @YES };
        //    options = nil;
        if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    return persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Initialization

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

+ (instancetype)sharedManager {
    static CoreDataManager *sCoreDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sCoreDataManager = [[super allocWithZone:nil] init];
    });
    return sCoreDataManager;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    @throw [NSException exceptionWithName:@"Alloc CoreDataManager Error"
                                   reason:@"This class only can be used by [CoreDataManager sharedManager]"
                                 userInfo:nil];
    return nil;
}

@end
