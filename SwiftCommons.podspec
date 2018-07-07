Pod::Spec.new do |s|
  s.name             = 'SwiftCommons'
  s.version          = '0.1'
  s.summary          = 'A common tool library for Swift Language.'

  s.description      = <<-DESC
      Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/data-sky/SwiftCommons'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'luwei' => 'lw1023@gmail.com' }
  s.source           = { :git => 'https://github.com/data-sky/SwiftCommons.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.source_files    = 'SwiftCommons/Classes/*.swift'
  s.frameworks      = 'UIKit', 'Foundation'
  s.platform = :ios
end
