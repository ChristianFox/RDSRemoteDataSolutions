
Pod::Spec.new do |s|
  s.name             = 'RDSRemoteDataSolutions'
  s.version          = '0.9.2'
  s.summary          = 'A RDSRemoteDataSolutions.'

  s.description      = <<-DESC
Connect to network & submit data to a server etc blah blah blah. Includes scheduling and resubmissions
                       DESC

  s.homepage         = 'https://kfxtech@bitbucket.org/kfx_pods/rdsremotedatasolutions.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Christian Fox' => 'christianfox890@icloud.com' }
  s.source           = { :git => 'https://kfxtech@bitbucket.org/kfx_pods/rdsremotedatasolutions.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'RDSRemoteDataSolutions/Classes/**/*'

  s.dependency 'KFXAdditions'
  s.dependency 'KFXLog'
end
