#
# Be sure to run `pod lib lint ProductSKU.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ProductSKU'
  s.version          = '0.1.1'
  s.summary          = '商城中SKU选择弹窗'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
商城中SKU选择弹窗,详细用法参考demo(PZViewController),需要配置dataSource
                       DESC

  s.homepage         = 'https://github.com/peiZheng1/ProductSKU'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'peiZheng1' => 'littlewangbig@163.com' }
  s.source           = { :git => 'https://github.com/peiZheng1/ProductSKU.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'ProductSKU/Classes/**/*'
  
   s.dependency 'Masonry','~> 1.1.0'
end
