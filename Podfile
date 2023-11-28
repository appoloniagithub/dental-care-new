# Uncomment the next line to define a global platform for your project
 #platform :ios, '12.0'

target 'Dental Care' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
 
 pod 'SkyFloatingLabelTextField'
 pod 'IQKeyboardManagerSwift'
 pod 'DropDown'
 pod 'CountryPickerView'
 pod 'NotificationBannerSwift'
 pod 'Alamofire', '~> 4.8.1'
 
 #pod 'SwiftyJSON'
# pod 'LanguageManager-iOS'
 pod 'MOLH'
 pod 'KDCalendar', '~> 1.8.9'

 pod 'Instructions'
 pod 'Kingfisher','~> 6.2.0'
 pod 'KVSpinnerView'
 #pod 'SwiftyUTType'
 #pod 'DatePickerDialog'
 pod 'Socket.IO-Client-Swift'
 
 pod 'AlamofireImage'
 pod 'Firebase'
 pod 'FirebaseMessaging'
 pod 'WKWebViewRTC'
 #pod 'Starscream', '~> 4.0.4'
 #, '~> 15.2.0'
 
 # Pods for Dental Care
  target 'Dental CareTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Dental CareUITests' do
    # Pods for testing
  end

end
post_install do |installer|
  xcode_base_version = `xcodebuild -version | grep 'Xcode' | awk '{print $2}' | cut -d . -f 1`

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # For xcode 15+ only
      if config.base_configuration_reference && Integer(xcode_base_version) >= 15
        xcconfig_path = config.base_configuration_reference.real_path
        xcconfig = File.read(xcconfig_path)
        xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
        File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
      end
    end
  end
end


