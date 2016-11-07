
Pod::Spec.new do |s|
  s.name         = "MOViewController"
  s.version      = "0.0.1"
  s.summary      = "A short description of MOViewController."
  s.homepage     = "https://github.com/sunmomomo/MOViewController.git"
  s.license      = "MIT"
  s.author             = { "馍馍帝😈" => "348384930@qq.com" }
  s.platform     = :ios, '7.1'
  s.requires_arc = true
  s.source       = { :git => "https://github.com/sunmomomo/MOViewController.git", :tag => "1.0.0" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.resource  = "icon.png"
  s.framework = "UIKit"
end
