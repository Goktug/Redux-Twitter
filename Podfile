platform :ios, '9.0'

def shared_pods
  # Social
  pod 'TwitterKit'
  
  # Networking
  pod 'Moya/RxSwift', '~> 11.0'

  # Data
  pod 'Kingfisher'
  pod 'ObjectMapper'
  
  # Crypto
  pod 'CryptoSwift'

  # Utility
  pod 'R.swift'

  # UI Helper
  pod 'SnapKit'
  pod 'IQKeyboardManagerSwift'
  pod 'PullToRefreshKit'
  
  # Redux
  pod 'ReSwift'
  pod 'ReSwiftRouter'
  pod 'ReRxSwift', '~> 1.0'
  
  # Reactive
  pod 'RxSwift', '~> 4.0'
  pod 'RxCocoa', '~> 4.0'
end

target 'Redux-Twitter' do
  use_frameworks!

  shared_pods

  target 'Redux-TwitterTests' do
    inherit! :search_paths
  end

end
