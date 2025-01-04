platform :ios, '16.0'
use_frameworks!
  
target 'AviWX' do
  # Pods for AviWX
  pod 'SwiftNet', :git => 'https://github.com/assadjaved/SwiftNet.git'
  pod 'AviWXNetworking', :path => '.', :inhibit_warnings => false, :testspecs => ['AviWXNetworkingTests']
  pod 'AviWXStyling', :path => '.', :inhibit_warnings => false, :testspecs => ['AviWXStylingTests']

  target 'AviWXTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'AviWXUITests' do
    # Pods for testing
  end

end
