Pod::Spec.new do |s|
  s.name         = "Chute-SDK"
  s.version      = "2.0.2"
  s.summary      = "A short description of Chute-SDK."
  s.homepage     = "http://getchute.com"
  s.license      = {:type => 'MIT'}
  s.author       = { "Aleksandar Kex Trpeski" => "kex@getchute.com" }
  s.source       = { :git => "https://github.com/chute/Chute-SDK-v2-iOS", :tag => "2.0.2" } 
  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Chute-SDK/', '**/*.{h,m,c}'
  s.frameworks = 'AssetsLibrary', 'CoreGraphics', 'QuartzCore'  
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '"$(inherited)"'}
    
  s.dependency 'AFNetworking','~> 1.3.2'
  s.dependency 'DCKeyValueObjectMapping', '~> 1.4'
  s.dependency 'MBProgressHUD', '~> 0.7'
  s.dependency 'Lockbox', '~> 1.4.3'
  # s.dependency 'Kiwi', '~> 2.2.1'
  
end
