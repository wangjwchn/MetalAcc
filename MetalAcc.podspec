Pod::Spec.new do |s|
  s.name             = ‘MetalAcc’
  s.version          =  ‘0.1.0’
  s.summary          = 'GPU-based media processing library using Metal written in Swift'
  s.homepage         = 'https://github.com/wangjwchn/MetalAcc‘
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Jiawei Wang" => "wangjwchn@yahoo.com" }
  s.source           = { :git => "https://github.com/wangjwchn/MetalAcc.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'MetalAcc/**/*'
end
