# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'Remote_state' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Remote_state

    pod 'Alamofire' ,'= 5.0.0-rc.2'
    pod 'GooglePlaces'
    pod 'GoogleMaps'
    pod 'SwiftyJSON', '~> 4.0'



  post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
     config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
    end

end
