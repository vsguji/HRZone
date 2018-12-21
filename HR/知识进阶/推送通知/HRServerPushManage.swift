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

// 注册通知管理
@objc class HRServerPush:NSObject,UIApplicationDelegate,UNUserNotificationCenterDelegate {
    
    // 当前应用
    public static var currentApplication:NSObject!
    
    // 显示通知 还是 静默接受通知
    public var notifiVisitOrSilent :Bool = true
    
    // 通知授权模式
    @available(iOS 10.0,*)
    fileprivate static var optionals:UNAuthorizationOptions = [.alert,.badge,.sound]
    
    @available(iOS 12.0, *)
    public static  var needCriticalAlert:Bool {
//        var newValue:Bool
//        set(value){
//            newValue = value
//        }
//        get{
//            return newValue
//        }
//        optionals.insert(<#T##newMember: UNAuthorizationOptions##UNAuthorizationOptions#>)
        return true
    }
    @available(iOS 12.0, *)
    public static var needProvisional:Bool {
        //        var newValue:Bool
        //        set(value){
        //            newValue = value
        //        }
        //        get{
        //            return newValue
        //        }
//        optionals.insert(.provisional)
        return true
    }
    
    @available(iOS 12.0, *)
    public static var needProvidesAppNotificationSettings:Bool {
        //        var newValue:Bool
        //        set(value){
        //            newValue = value
        //        }
        //        get{
        //            return newValue
        //        }
//        optionals.insert(<#T##newMember: UNAuthorizationOptions##UNAuthorizationOptions#>)
        return true
    }
    
    private override init(){
        
    }
    
    // 注册推送通知
    public static func requestPermission (){
        // 10.0 以上:权限不可访问,调转到设置
        // 8.0 ~ 10.0: 是否已注册监听 : YES 无需执行 ; NO 注册监听
        // 8.0 以下 : 是否已注册监听 : YES 无需执行 ; NO 注册监听
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
                }
            }
        }
        else if #available(iOS 8.0, *){
            if !UIApplication.shared.isRegisteredForRemoteNotifications {
                let setting = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(setting)
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        else{
            if !UIApplication.shared.isRegisteredForRemoteNotifications {
               UIApplication.shared.registerForRemoteNotifications(matching: [.alert,.badge,.sound])
            }
        }
    }
    
    // mark - UIApplicationDelegate
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        let deviceTokenStr = deviceToken.description.replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with:"")
        // 目标服务器
        print(deviceTokenStr)
    }
    
    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error){
        NSLog("msg : %@", error.localizedDescription)
    }
    
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenter requestAuthorizationWithOptions:completionHandler:]")
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        
    }
    
    @available(iOS, introduced: 3.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
       
    }
    
    @available(iOS, introduced: 4.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
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
