//
//  PhotoboothAppDelegate.h
//  Photobooth
//
//  Created by Charly Biteau on 17/07/2014.
//  Copyright (c) 2014 Charly Biteau. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PhotoboothAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
