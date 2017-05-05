#
#  Be sure to run `pod spec lint GrootCompleteTextFeild.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|



  s.platform     = :ios
  s.ios.deployment_target   =  “8.0”

  s.name         = "GrootCompleteTextFeild"
  s.version      = “0.1”
  s.summary      = "Auto-complete words for your UITextField."



  s.homepage     = "https://github.com/cubong/GrootCompleteTextFeild"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { “AnhDN” => “nhan.anh93@gmail.com" }


  s.source       = { :git => "https://github.com/cubong/GrootCompleteTextFeild", :tag => "#{s.version}" }



  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


end
