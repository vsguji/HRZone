//
//  HRMainViewController.swift
//  HR
//
//  Created by lipeng on 2018/12/23.
//  Copyright © 2018 lipeng. All rights reserved.
//

import UIKit
import UserNotifications
import Log

class HRMainVC: UIViewController {
    
    var log:Logger!
    
    convenience override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        log = Logger(formatter: .default, theme: Themes.default, minLevel: .debug)
        super.viewDidLoad()
    }
   
    // 模拟发送通知消息
    @IBAction func sendNotification(_ sender: Any) {
        if #available(iOS 10.0, *) {
            // 1.创建通知中心
            let center = UNUserNotificationCenter.current()
            // 2.检查当前用户授权
            center.getNotificationSettings { (setting) in
                self.log.info("=== setting ===")
                // 3.创建通知
                let notification = UNMutableNotificationContent()
                // 通知标题
                notification.title = "peng"
                // 通知小标题
                notification.subtitle = "hello world"
                // 通知内容
                notification.body = "欢迎来到人力空间"
                // 通知生硬
                notification.sound = UNNotificationSound.default
                // 通知小圆圈数量
                notification.badge = NSNumber(integerLiteral: 2)
                
                // 4.创建触发器(相当于ios9中通触发的时间)
                 // 通知触发器主要有三种
                // UNTimeIntervalNotificationTrigger  指定时间触发
                // UNCalendarNotificationTrigger      指定日历时间触发
                // UNLocationNotificationTrigger      指定区域触发
                
                let timeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
                
                // 5.指定通知的分类: 1.identity 表示创建分类时唯一标示;2.该代码一定要在创建通知请求之前,否则无效
                notification.categoryIdentifier = "myNotificationCategory"
                
                // 6. 创建通知请求
                let request = UNNotificationRequest(identifier: "localNotification", content: notification, trigger: timeIntervalTrigger)
                
                // 7. 通知中心发送通知请求
                center.add(request, withCompletionHandler: { (error) in
                    guard let info:Error = error else{return}
                    self.log.debug(info.localizedDescription)
                })
            }
        }
    }
    deinit {
        
    }
}
