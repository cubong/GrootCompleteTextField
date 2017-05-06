Pod::Spec.new do |s|

  # 1
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.name = "GrootCompleteTextField"
  s.summary = "Auto-complete words for your UITextField"
  s.requires_arc = true

  # 2
  s.version = "1.1"

  # 3
  s.license = { :type => "MIT", :file => "LICENSE" }

  # 4
  s.author = { "AnhDN" => "nhan.anh93@gmail.com" }


  # 5
  s.homepage = "https://github.com/cubong/GrootCompleteTextField"



  # 6
  s.source = { :git => "https://github.com/cubong/GrootCompleteTextField.git", :tag => "1.1"}



  # 7
  s.framework = "UIKit"

  # 8
  s.source_files = "GrootCompleteTextField/**/*.{swift}"
end