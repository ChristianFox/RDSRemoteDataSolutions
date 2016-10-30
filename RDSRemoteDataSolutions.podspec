#
# Be sure to run `pod lib lint RDSRemoteDataSolutions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RDSRemoteDataSolutions'
  s.version          = '0.4.0'
  s.summary          = 'A RDSRemoteDataSolutions.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Connect to network etc. blah blah blha
                       DESC

  s.homepage         = 'https://kfxtech@bitbucket.org/kfxteam/rdsremotedatasolutions.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Christian Fox' => 'christianfox890@icloud.com' }
  s.source           = { :git => 'https://kfxtech@bitbucket.org/kfxteam/rdsremotedatasolutions.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'RDSRemoteDataSolutions/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RDSRemoteDataSolutions' => ['RDSRemoteDataSolutions/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'KFXAdditions'
end
