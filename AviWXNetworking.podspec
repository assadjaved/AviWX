Pod::Spec.new do |spec|
  spec.name                   = 'AviWXNetworking'
  spec.version                = '1.0.0'
  spec.summary                = 'AviWX networking module'
  spec.homepage               = 'https://github.com/assadjaved/AviWX'
  spec.author                 = { 'Asad Javed' => 'assad.j.karim@gmail.com' }
  spec.source                 = { :git => 'https://github.com/assadjaved/AviWX.git', :tag => spec.version.to_s }
  spec.ios.deployment_target  = '16.0'
  spec.source_files           = 'Modules/AviWXNetworking/Sources/**/*.{swift,h,m}'
  spec.frameworks             = 'Foundation'
  spec.dependency               'SwiftNet'
  
  spec.test_spec 'AviWXNetworkingTests' do |test_spec|
    test_spec.source_files    = 'Modules/AviWXNetworking/Tests/**/*.{swift}'
    test_spec.dependency        'Quick'
    test_spec.dependency        'Nimble'
    test_spec.dependency        'RxTest'
  end
end
