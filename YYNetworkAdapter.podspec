#
# Be sure to run `pod lib lint YYNetworkAdapter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YYNetworkAdapter'
  s.version          = '0.1.0'
  s.summary          = 'A short description of YYNetworkAdapter.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/yuanyuan100/YYNetworkAdapter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pyy' => '469092943@qq.com' }
  s.source           = { :git => 'https://github.com/yuanyuan100/YYNetworkAdapter.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'YYNetworkAdapter/Classes/**/*.{h,m}'
  s.public_header_files = 'YYNetworkAdapter/Classes/**/*.{h}'
  
  s.subspec 'Adapter' do |ss|
      ss.source_files = 'YYNetworkAdapter/Classes/Adapter/*.{h,m}'
      ss.prefix_header_contents = '#import "YYNetworkProtocolClient.h"'
  end
  
  s.subspec 'Plugin-AFNetworking' do |ss|
      ss.dependency 'YYNetworkAdapter/Adapter'
      ss.dependency 'AFNetworking'
      ss.source_files = 'YYNetworkAdapter/Classes/Plugin-AFNetworking/*.{h,m}'
  end
  
end
