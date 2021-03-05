# Uncomment the next line to define a global platform for your project

platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'
workspace 'Workspace'

def commonPods
  # 通用
  pod 'AFNetworking'
  pod 'Toast', '~> 4.0.0'
  pod 'SensorsAnalyticsSDK', :path => "~/Documents/GitLab/sa-sdk-ios"
  # pod 'SensorsAnalyticsSDK', :subspecs => ['Location']
  # pod 'SensorsFocus'
end

target 'FDDemo' do
  project 'FDDemo'
  use_frameworks!
  commonPods

  # 推送功能
  # pod 'JPush'
  # pod 'GTSDK'

  # Deeplink
  # pod 'LinkedME_LinkPage'

  # 穿山甲 SDK
  # pod 'Ads-CN'

  # GrowingIO
  # pod 'GrowingAutoTrackKit'
  # pod 'SensorsABTesting'

  # database
  # pod 'FMDB'
  # pod 'YYCache'
  # pod 'WCDB'

  # add the Firebase pod for Google Analytics®
  # pod 'Firebase/Analytics'
  # pod 'GoogleTagManager', '~> 6.0'

  # pod 'Firebase/DynamicLinks'
  # add pods for any other desired Firebase products
  # https://firebase.google.com/docs/ios/setup#available-pods
end

target 'ListClickDemo' do
  project 'ListClickDemo'
  use_frameworks!
  commonPods

end

target 'SwiftDemo' do
  project 'widgetDemo/SwiftDemo'
  use_frameworks!
  commonPods
end

