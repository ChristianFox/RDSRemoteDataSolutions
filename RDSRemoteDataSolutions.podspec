
Pod::Spec.new do |s|
  s.name             = 'RDSRemoteDataSolutions'
  s.version          = '1.0.1'
  s.summary          = 'A RDSRemoteDataSolutions.'

  s.description      = <<-DESC
Connect to network & submit data to a server. Includes scheduling and resubmissions.
                       DESC

  s.homepage         = 'https://github.com/ChristianFox/RDSRemoteDataSolutions.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Christian Fox' => 'christianfox@kfxtech.com' }
  s.source           = { :git => 'https://github.com/ChristianFox/RDSRemoteDataSolutions.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.2'
  s.source_files = 'RDSRemoteDataSolutions/Classes/**/*'
  s.dependency 'KFXAdditions'
  s.dependency 'KFXLog'
end
