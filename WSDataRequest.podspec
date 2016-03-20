Pod::Spec.new do |s|

  s.name        = "WSDataRequest"
  s.version     = "2.0.1"
  s.summary     = "A http request tool encapsulated with AFNetWorking."

  s.homepage    = "https://github.com/Shunzi007/WSDataRequest"
  s.license   	= { :type => 'MIT', :file => 'LICENSE' }
  

  s.author      = { "王顺" => "360752546@qq.com" }
  s.platform    = :ios, '7.0'
  
  s.source      = { :git => "https://github.com/Shunzi007/WSDataRequest.git", :tag => s.version.to_s }

  s.source_files= "WSDataRequest/*.{h,m}"
  

  s.frameworks  = "Foundation"
  s.dependency  "AFNetworking"

end
