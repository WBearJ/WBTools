#
# Be sure to run `pod lib lint WBTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WBTools'
  s.version          = '0.0.4'
  s.summary          = '通用工具'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  通用的工具的封装
                       DESC

  s.homepage         = 'https://github.com/WBearJ/WBTools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WBearJ' => 'karuasha@gmail.com' }
  s.source           = { :git => 'https://github.com/WBearJ/WBTools.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version = '5.2'
  s.ios.deployment_target = '12.0'

  s.source_files = 'WBTools/Classes/**/*'
  s.resources = 'WBTools/Assets/WBTools.bundle'

  # s.resource_bundles = {
  #   'WBTools' => ['WBTools/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'MBProgressHUD', '~> 1.2.0'
end
