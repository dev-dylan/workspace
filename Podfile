# Uncomment the next line to define a global platform for your project

platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'
workspace 'Workspace'

target 'FDDemo' do
  project 'FDDemo'
  # Comment the next line if you don't want to use dynamic frameworks
#  use_frameworks!

# 通用
#  pod 'AFNetworking'
#  pod 'Toast', '~> 4.0.0'

# 推送功能
  pod 'JPush'
  pod 'GTSDK'

# Deeplink
#  pod 'LinkedME_LinkPage'


# Sensors
#  pod  'SensorsAnalyticsSDK', :subspecs => ['Location']
  pod 'SensorsAnalyticsSDK', :path => "~/Documents/GitLab/sa-sdk-ios-test", :subspecs => ['Location']
#  pod 'SensorsAnalyticsSDK', :path => "~/Documents/GitLab/sa-sdk-ios-test", :subspecs => ['Location', 'DeviceOrientation', 'WKWebView']
#  pod 'SensorsFocus'

# GrowingIO
#  pod 'GrowingAutoTrackKit'
#  pod 'SensorsABTesting'

# database
#  pod 'FMDB'
#  pod 'YYCache'
#  pod 'WCDB'

  # add the Firebase pod for Google Analytics®
#  pod 'Firebase/Analytics'
#  pod 'GoogleTagManager', '~> 6.0'

#  pod 'Firebase/DynamicLinks'
  # add pods for any other desired Firebase products
  # https://firebase.google.com/docs/ios/setup#available-pods

end

target 'ListClickDemo' do
  project 'ListClickDemo'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
#  pod  'SensorsAnalyticsSDK', :subspecs => ['Location']
  pod 'SensorsAnalyticsSDK', :path => "~/Documents/GitLab/sa-sdk-ios-test", :subspecs => ['Location']
  # Pods for ListClickDemo

end

target 'SwiftDemo' do
  project 'widgetDemo/SwiftDemo'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
#  pod  'SensorsAnalyticsSDK', :subspecs => ['Location']
  pod 'SensorsAnalyticsSDK', :path => "~/Documents/GitLab/sa-sdk-ios-test", :subspecs => ['Location']

  # Pods for ListClickDemo

end

