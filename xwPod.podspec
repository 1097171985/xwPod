#
# Be sure to run `pod lib lint xwPod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
#======= 名称、版本、摘要=======
  s.name             = 'xwPod'
  s.version          = '0.1.0'
  s.summary          = 'A short description of xwPod.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
#===============详情===================
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
#========== 仓库地址 ============
  s.homepage         = 'https://github.com/1097171985/xwPod'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  
  #=========== 许可、作者、仓库源、开发版本 ============
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  
  s.author           = { '1097171985' => '1097171985@qq.com' }
  s.source           = { :git => 'https://github.com/1097171985/xwPod.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '8.0'
  #=================源文件目录，资源路径、文件、d库，第三方库============
  s.source_files = 'xwPod/Classes/**/*'
  
 s.resource_bundles = {
   'xwPod' => ['xwPod/Assets/*.png']
}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
