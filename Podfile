platform :ios, '9.0'

def shared_pods
  # Networking
  pod 'Moya', '~> 11.0'

  # Data
  pod 'Kingfisher'
  pod 'ObjectMapper'
  pod 'Moya-ObjectMapper', git: 'https://github.com/dimacheverda/Moya-ObjectMapper.git'

  # Utility
  pod 'R.swift'

  # UI Helper
  pod 'SnapKit'
  pod 'IQKeyboardManagerSwift'
end

target 'Redux-Twitter' do
  use_frameworks!

  shared_pods

  target 'Redux-TwitterTests' do
    inherit! :search_paths
  end

end
