Pod::Spec.new do |s|
  s.name             = 'Far'
  s.version          = '5.6.0'
  s.summary          = 'make Function as Request'
  s.homepage         = 'https://github.com/wlgemini/Far'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wlgemini' => 'wangluguang@live.com' }
  s.source           = { :git => 'https://github.com/wlgemini/Far.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.swift_versions = ['5.3', '5.4', '5.5', '5.6']

  s.source_files = 'Source/**/*.swift'

  s.dependency 'Alamofire', '~> 5.6'
end
