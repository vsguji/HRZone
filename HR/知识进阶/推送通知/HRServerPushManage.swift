//
//  HServerPush.swift
//  HR
//
//  Created by lipeng on 2018/12/16.
//  Copyright © 2018 lipeng. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import Log

// 注册通知管理
@objc class HRServerPush:NSObject,UIApplicationDelegate,UNUserNotificationCenterDelegate {
    
    static let shareManager = HRServerPush()
    
    fileprivate var log:Logger?
    
    public static func share() -> HRServerPush{
        return shareManager
    }
    private override init(){
        log = Logger(formatter: .minimal, theme:Themes.default , minLevel: .debug)
    }
    
    // 当前应用
    public static var currentApplication:NSObject!
    // 显示通知 还是 静默接受通知
    public var notifiVisitOrSilent :Bool = true
    
    // 通知授权模式
    @available(iOS 10.0,*)
    fileprivate static var optionals:UNAuthorizationOptions = [.alert,.badge,.sound]
    
    // 为关键警报播放声音的授权状态。
    @available(iOS 12.0, *)
    public static  var needCriticalAlert:Bool {
       optionals.insert(.criticalAlert)
        return true
    }
    
    // 应用程序暂时被授权发布不中断的用户通知。
    @available(iOS 12.0, *)
    public static var needProvisional:Bool {
        optionals.insert(.provisional)
        return true
    }
    
    // 指示系统的布尔值显示一个用于应用程序内通知设置的按钮。
    @available(iOS 12.0, *)
    public static var needProvidesAppNotificationSettings:Bool {
        optionals.insert(.providesAppNotificationSettings)
        return true
    }
    
    // 注册推送通知
    public static func requestPermission (){
        // 10.0 以上:权限不可访问,调转到设置
        // 8.0 ~ 10.0: 是否已注册监听 : YES 无需执行 ; NO 注册监听
        // 8.0 以下 : 是否已注册监听 : YES 无需执行 ; NO 注册监听
        if !UIApplication.shared.isRegisteredForRemoteNotifications {
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().requestAuthorization(options:self.optionals) { (ok, msg) in
                    if !ok {
                        guard let authMsg : Error = msg else {
                            return
                        }
                        NSLog("error msg : %@", authMsg.localizedDescription)
                        // 调转到设置
                        let settingURL = URL(string: UIApplication.openSettingsURLString)!
                        UIApplication.shared.openURL(settingURL)
                    }
                    else{
                        DispatchQueue.main.async(execute: {
                           UIApplication.shared.registerForRemoteNotifications()
                        })
                        UNUserNotificationCenter.current().delegate = currentApplication as! AppDelegate
                    }
                }
            }
            else if #available(iOS 8.0, *){
                let setting = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(setting)
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.registerForRemoteNotifications()
                })
            }
            else{
                UIApplication.shared.registerForRemoteNotifications(matching: [.alert,.badge,.sound])
            }
        }
        else{
            if #available(iOS 10.0, *){
                UNUserNotificationCenter.current().delegate = currentApplication as! AppDelegate
            }
        }
    }
    
    // mark - UIApplicationDelegate
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        let data = NSData(data: deviceToken)
        let token:String = data.description.trimmingCharacters(in: CharacterSet(charactersIn: "<>")).replacingOccurrences(of: " ", with: "")
        // 目标服务器
        log?.debug(token + " ",separator:" ", terminator: "=======")
    }
    
    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error){
        log?.error("获取deviceToken失败:"+error.localizedDescription)
        UIApplication.shared.unregisterForRemoteNotifications()
    }
    
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler:]")
    public func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        
    }
    
    // 远程通知
    @available(iOS, introduced: 3.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
   public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
       log?.info("iOS 10.0 之前,接收远程通知")
    }
    
    // 本地通知
    @available(iOS, introduced: 4.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
   public func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        log?.info("ios 10.0,接收之前本地通知")
    }
    
    // 静默更新
    @available(iOS 7.0, *)
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void){
        log?.info("处于后端状态,消息内含用content-available字段,相应事件")
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    // 具有“获取”后台模式的应用程序可能有机会在后台或系统方便的时候获取更新的内容。在这些情况下将调用此方法。您应该在完成该操作后立即调用fetchCompletionHandler，这样系统就可以准确地估计它的功耗和数据成本。
    @available(iOS 7.0, *)
    public func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void){
        log?.info("后台定时刷新内容")
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    // mark - UNUserNotificationCenterDelegate
    
    // 只有在应用程序位于前台时，才会对委托调用该方法。如果方法没有实现，或者处理程序没有及时调用，那么就不会出现通知。应用程序可以选择将通知显示为声音、标识、警告和/或通知列表。此决策应基于通知中的信息是否对用户可见
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        log?.info("处于前台状态,用户可见通知栏,相应事件")
        completionHandler(UNNotificationPresentationOptions.alert)
    }
    
    // 当用户通过打开应用程序、撤销通知或选择UNNotificationAction来响应通知时，将在委托上调用该方法。必须在应用程序从应用程序返回之前设置委托:didFinishLaunchingWithOptions:。
    @available(iOS 10.0, *)
     public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void){
        log?.info("点击通知栏,相应事件")
        completionHandler()
    }
    
    // 该方法将在应用程序启动时调用委托，以响应用户查看应用程序内通知设置的请求。添加UNAuthorizationOptionProvidesAppNotificationSettings作为requestAuthorizationWithOptions:completionHandler:在settings中添加一个按钮到内联通知设置视图和通知设置视图。从设置中打开通知将为nil。
    @available(iOS 12.0, *)
     public func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?){
        log?.info("点击自定义设置,相应事件")
    }
    
}
