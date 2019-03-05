platform :ios, '9.0'

def app_pods
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxAlamofire'
    pod 'AlamofireObjectMapper'
    pod 'RxDataSources'
    pod 'Moya/RxSwift', '~> 11.0'
    pod 'ObjectMapper'
    pod 'SDWebImage/WebP'
    pod 'ReachabilitySwift'
    pod 'Reusable', '~> 4.0'
    pod 'SVPullToRefresh'


end
target 'HomeTestTiki' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HomeTestTiki
    app_pods
  target 'HomeTestTikiTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'HomeTestTikiUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
