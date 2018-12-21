#  知识进阶
## 推送通知
证书下载; 
转为服务端所需文件;
本地测试:
app store 下载  Easy APNS Provider

ios8-10兼容

NSUserNotificationKit


# UNUserNotificationCenterDelegate


//只有在应用程序位于前台时，才会对委托调用该方法。如果方法没有实现，或者没有及时调用处理程序，则不会显示通知。应用程序可以选择将通知显示为声音、徽标、警告和/或在通知列表中。这个决定应该基于通知中的信息是否对用户可见。
@available(iOS 10.0, *)
public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){

}

//当用户通过打开应用程序、撤销通知或选择UNNotificationAction来响应通知时，将在委托上调用该方法。必须在应用程序从应用程序返回之前设置委托:didFinishLaunchingWithOptions:。
@available(iOS 10.0, *)
public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void){

}

//当应用程序响应用户查看应用程序内通知设置的请求而启动时，将在委托上调用该方法。添加UNAuthorizationOptionProvidesAppNotificationSettings作为requestAuthorizationWithOptions:completionHandler:在settings中添加一个按钮到内联通知设置视图和通知设置视图。从设置中打开通知将为nil。
@available(iOS 12.0, *)
public func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?){

}
