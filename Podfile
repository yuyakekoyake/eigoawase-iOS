# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'eigo_awase' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for eigo_awase
pod 'lottie-ios'
pod 'Spring', :git => 'https://github.com/MengTo/Spring.git'
pod 'Google-Mobile-Ads-SDK'
pod 'RealmSwift'
pod 'RandomKit'
pod 'Cheers'
pod "SwiftRater"
pod 'Firebase/Core'
pod 'Firebase/AdMob'
pod 'Firebase/Messaging'
pod 'IBAnimatable'
pod 'LTMorphingLabel'

post_install do | installer |
  require 'fileutils'

  FileUtils.cp_r('Pods/Target Support Files/Pods-eigo_awase/Pods-eigo_awase-Acknowledgements.plist', 'eigo_awase/Settings.bundle/Acknowledgements.plist', :remove_destination => true)

installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
  end
end

  target 'eigo_awaseTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'eigo_awaseUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
