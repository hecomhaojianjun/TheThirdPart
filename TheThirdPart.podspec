Pod::Spec.new do |s|
  s.platform = :ios
  s.name         = "TheThirdPart"
  s.version      = "1.0.1"
  s.summary      = "Objective C and swift class."
  s.description  = <<-DESC
TheThirdPart 集成了AutoLayer、Base64、BlockUI、DynamicDelegate、htmlparser、HYActivityView等私有的第三方库.
                    DESC
  s.homepage     = "https://github.com/hecomhaojianjun/TheThirdPart"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "hecomhaojianjun" => "haojianjun@hecom.cn" }
  s.source       = { :git => 'https://github.com/hecomhaojianjun/TheThirdPart.git', :tag => '1.0.1' }
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
  s.subspec 'AutoLayer' do |ss|
    ss.source_files = 'AutoLayer/*.{h,m}'
    ss.public_header_files = 'AutoLayer/*.h'
  end
  s.subspec 'Base64' do |s1|
    s1.source_files = 'Base64/*.{h,m}'
    s1.public_header_files = 'Base64/*.h'
  end
  s.subspec 'BlockUI' do |ss|
    ss.source_files = 'BlockUI/*.{h,m}'
    ss.public_header_files = 'BlockUI/*.h'
    ss.frameworks = 'UIKit'
  end
  s.subspec 'DynamicDelegate' do |s3|
    s3.source_files = 'DynamicDelegate/*.{h,m}'
    s3.public_header_files = 'DynamicDelegate/*.h'
  end
  s.subspec 'MailAndMessage' do |s1|
    s1.source_files = 'MailAndMessage/*.{h,m}'
    s1.public_header_files = 'MailAndMessage/*.h'
  end
  s.subspec 'MJExtension' do |s1|
    s1.source_files = 'MJExtension/*.{h,m}'
    s1.public_header_files = 'MJExtension/*.h'
  end
  s.subspec 'ParseXML' do |s1|
    s1.source_files = 'ParseXML/*.{h,m}'
    s1.public_header_files = 'ParseXML/*.h'
  end
  s.subspec 'SafeTransition' do |s1|
    s1.source_files = 'SafeTransition/*.{h,m}'
    s1.public_header_files = 'SafeTransition/*.h'
  end
  s.subspec 'Tar' do |s1|
    s1.source_files = 'Tar/*.{h,m}'
    s1.public_header_files = 'Tar/*.h'
  end
  s.subspec 'TPKeyboardAvoidingScrollView' do |s1|
    s1.source_files = 'TPKeyboardAvoidingScrollView/*.{h,m}'
    s1.public_header_files = 'TPKeyboardAvoidingScrollView/*.h'
  end
  s.subspec 'UIImage-Helpers' do |s1|
    s1.source_files = 'UIImage-Helpers/*.{h,m}'
    s1.public_header_files = 'UIImage-Helpers/*.h'
  end
  s.subspec 'HYActivityView' do |ss|
    ss.source_files = 'HYActivityView/*.{h,m}'
    ss.public_header_files = 'HYActivityView/*.h'
  end
end
