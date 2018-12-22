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
                        UNUserNotificationCenter.current().delegate = currentApplication as! AppDelegate
                        DispatchQueue.main.async(execute: {
                           UIApplication.shared.registerForRemoteNotifications()
                        })
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
    }
    
    // mark - UIApplicationDelegate
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        let data = NSData(data: deviceToken)
        let token:String = data.description.trimmingCharacters(in: CharacterSet(charactersIn: "<>")).replacingOccurrences(of: " ", with: "")
        // 目标服务器
        log?.debug(token + " ",separator:" ", terminator: "=======")
    }
    
    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error){
        NSLog("msg : %@", error.localizedDescription)
        
    }
    
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler:]")
    public func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        
    }
    
    @available(iOS, introduced: 3.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
   public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
       
    }
    
    @available(iOS, introduced: 4.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
   public func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
    }
    
    @available(iOS 7.0, *)
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void){
        
    }
    
    @available(iOS 7.0, *)
    public func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void){
        
    }
    
    // mark - UNUserNotificationCenterDelegate
    
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        
    }
    
    @available(iOS 10.0, *)
     public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void){
        
    }
    
    @available(iOS 12.0, *)
     public func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?){
        
    }
    
}
