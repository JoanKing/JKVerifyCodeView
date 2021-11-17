#
# Be sure to run `pod lib lint JKVerifyCodeView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JKVerifyCodeView'
  s.version          = '0.1.1'
  s.summary          = '验证码的使用'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '主要适用于验证码的验证'

  s.homepage         = 'https://github.com/JoanKing/JKVerifyCodeView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JoanKing' => 'chongwang27@creditease.cn' }
  s.source           = { :git => 'https://github.com/JoanKing/JKVerifyCodeView.git', :tag => s.version.to_s }
  s.social_media_url   = "https://github.com/JoanKing"
  # 最低要求的系统版本
  s.ios.deployment_target = '9.0'
  # swift 支持的版本
  s.swift_version = '5.0'
  # 要求是ARC
  s.requires_arc = true
  # 表示源文件的路径，这个路径是相对podspec文件而言的。（这属性下面单独讨论）
  s.source_files = 'JKVerifyCodeView/Classes/**/*'
  s.ios.deployment_target = '9.0'

  # s.resource_bundles = {
  #   'JKVerifyCodeView' => ['JKVerifyCodeView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'SnapKit'
end
