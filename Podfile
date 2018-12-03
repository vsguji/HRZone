# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'HR' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HR
   pod 'Alamofire', '~> 4.2.0'
   # HUD
   pod 'SVProgressHUD', '~> 2.1.2'
   #自动布局
   pod 'SnapKit', '~> 4.0.0'
   #上拉下拉刷新
   pod 'MJRefresh', '~> 3.1.12'
   #加载网络图片
   pod 'SDWebImage', '~> 4.0.0-beta2'   

   # websocket库
   pod 'Starscream',:git => 'https://github.com/daltoniam/Starscream.git',:branch => 'swift3'
   #日志输出管理
   pod 'Log','~> 1.0'
   # Swfit项目语言本地化支持框架：https://github.com/marmelroy/Localize-Swift
   pod 'Localize-Swift','~> 1.5'
   #字体图片库
#   pod 'FontAwesomeKit.Swift'
    pod 'FontAwesomeKit', '~> 2.2.1'

#   Error: 'NSLayoutAttribute' has been renamed to 'NSLayoutConstraint.Attribute'
#   https://github.com/SnapKit/SnapKit/issues/522

   swift_4_1_pod_targets = ['SnapKit']
   
   post_install do | installer |
       installer.pods_project.targets.each do |target|
           if swift_4_1_pod_targets.include?(target.name)
               target.build_configurations.each do |config|
                   config.build_settings['SWIFT_VERSION'] = '4.1'
               end
           end
       end
   end
   
  target 'HRTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'HRUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
