//
//  AppDelegate.h
//  Test_Soda
//
//  Created by Siliang Lu on 10/8/16.
//  Copyright © 2016 Siliang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <AWSCore/AWSCore.h>
#import <AWSCognito/AWSCognito.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

//@property (strong, nonatomic) ViewController *viewController;
- (void)saveContext;


@end

