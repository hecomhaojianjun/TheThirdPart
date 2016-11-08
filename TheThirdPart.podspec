Pod::Spec.new do |s|
  s.platform = :ios
  s.name         = "TheThirdPart"
  s.version      = "1.0.0"
  s.summary      = "Objective C and swift class."
  s.description  = <<-DESC
TheThirdPart 集成了AutoLayer、Base64、BlockUI、DynamicDelegate、htmlparser、HYActivityView等私有的第三方库.
                    DESC
  s.homepage     = "https://github.com/hecomhaojianjun/TheThirdPart"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "hecomhaojianjun" => "haojianjun@hecom.cn" }
  s.source       = { :git => 'https://github.com/hecomhaojianjun/TheThirdPart.git', :tag => '1.0.0' }
  s.source_files = 'BlockUI/*.{h,m}', 'AutoLayer/*.{h,m}', 'Base64/*.{h,m}', 'DynamicDelegate/*.{h,m}', 'MailAndMessage/*.{h,m}', 'ParseXML/*.{h,m}', 'SafeTransition/*.{h,m}', 'Tar/*.{h,m}', 'TPKeyboardAvoidingScrollView/*.{h,m}', 'UIImage-Helpers/*.{h,m}', 'MJExtension/*.{h,m}'
  s.public_header_files = 'BlockUI/*.h', 'AutoLayer/*.h', 'Base64/*.h', 'DynamicDelegate/*.h', 'MailAndMessage/*.h', 'MJExtension/*.h', 'ParseXML/*.h','SafeTransition/*.h', 'Tar/*.h', 'TPKeyboardAvoidingScrollView/*.h', 'UIImage-Helpers/*h'
  s.requires_arc = true
  s.frameworks = 'UIKit'
  s.ios.deployment_target = '7.0'
  s..default_subspec = 'Core'
  s.subspec 'Core' do |core|
  core.dependency 'TheThirdPart/AutoLayer'
  core.dependency 'TheThirdPart/Base64'
  core.dependency 'TheThirdPart/BlockUI'
  core.dependency 'TheThirdPart/Manager'
  core.dependency 'TheThirdPart/DynamicDelegate'
  core.dependency 'TheThirdPart/MailAndMessage'
  core.dependency 'TheThirdPart/MJExtension'
  core.dependency 'TheThirdPart/ParseXML'
  core.dependency 'TheThirdPart/SafeTransition'
  core.dependency 'TheThirdPart/Tar'
  core.dependency 'TheThirdPart/TPKeyboardAvoidingScrollView'
  core.dependency 'TheThirdPart/UIImage-Helpers'
  end
end
