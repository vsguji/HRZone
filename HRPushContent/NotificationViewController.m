//
//  NotificationViewController.m
//  HRPushContent
//
//  Created by lipeng on 2018/12/22.
//  Copyright © 2018 lipeng. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification  API_AVAILABLE(ios(10.0)){
    self.label.text = notification.request.content.body;
}

@end
