#
# Be sure to run `pod lib lint SBNetworking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SBNetworking'
  s.version          = '0.0.1'
  s.summary          = 'SBNetworking lays the groundwork for well organized API code.'

  s.description      = <<-DESC
This networking library allows you to make your API code incredibly modular. Each network call has its own class, which gives you a ton of flexibility. Some advantages include:
- easily taking any subset of your API calls with you between multiple projects
- elegantly handling lazy refactors to new API versions
- enables strict adherence to SRP with your API calls, and all the advantages that entails
- the flexibility to change the server configuration for individual calls or all of them at once
                       DESC

  s.homepage         = 'https://github.com/schrockblock/SBNetworking'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Elliot' => '' }
  s.source           = { :git => 'https://github.com/schrockblock/sbnetworking.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/elliot_schrock'

  s.platform     = :ios, '9.0'
  s.ios.deployment_target = '9.0'

  s.source_files = 'SBNetworking/Classes/**/*'

  # s.dependency 'OHHTTPStubs/Swift'
end
