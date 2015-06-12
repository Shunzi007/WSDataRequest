Pod::Spec.new do |s|

  s.name         = "WSDataRequest"
  s.version      = "1.0.0"
  s.summary      = "A http request tool encapsulated with AFNetWorking."

  s.homepage     = "https://github.com/Shunzi007/WSDataRequest"
  s.license      = "MIT"
  

  s.author             = { "王顺" => "360752546@qq.com" }
  s.ios.deployment_target = "6.0"
  
  s.source       = { :git => "https://github.com/Shunzi007/WSDataRequest.git", :tag => s.version.to_s }

  s.source_files  = "WSDataRequest/*.{h,m}"
  

  s.frameworks  = "UIKit", "Foundation"
  s.dependency "AFNetworking", "~> 2.5.4"

end
