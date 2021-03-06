#
# Be sure to run `pod lib lint joyfortSdkLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'joyfortSdkLib'
  s.version          = '0.1.0'
  s.summary          = 'A short description of joyfortSdkLib.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

s.homepage         = 'https://github.com/godfery/joyfortSdkLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
 s.license          = { :type => 'MIT', :file => 'LICENSE' }
 s.author           = { 'godfery' => '157062357@qq.com' }
 s.source           = { :git => 'https://github.com/godfery/joyfortSdkLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'joyfortSdkLib/Classes/**/*.{h,m}'
  
  # s.resource_bundles = {
  #   'joyfortSdkLib' => ['joyfortSdkLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking', '~> 2.3'
   s.dependency 'FBSDKCoreKit', '~> 4.5'
   s.dependency 'FBSDKLoginKit', '~> 4.5'

   s.dependency 'ASIHTTPRequest'
   s.dependency 'Bolts', '~> 1.0'
   s.dependency 'FBSDKShareKit', '~> 4.5'
end
