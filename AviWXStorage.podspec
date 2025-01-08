Pod::Spec.new do |spec|
  spec.name                   = 'AviWXStorage'
  spec.version                = '1.0.0'
  spec.summary                = 'AviWX storage module'
  spec.homepage               = 'https://github.com/assadjaved/AviWX'
  spec.author                 = { 'Asad Javed' => 'assad.j.karim@gmail.com' }
  spec.source                 = { :git => 'https://github.com/assadjaved/AviWX.git', :tag => spec.version.to_s }
  spec.ios.deployment_target  = '16.0'
  spec.source_files           = 'Modules/AviWXStorage/Sources/**/*.{swift,h,m}'
  spec.frameworks             = 'Foundation'
  
  spec.test_spec 'AviWXStorageTests' do |test_spec|
    test_spec.source_files    = 'Modules/AviWXStorage/Tests/**/*.{swift}'
  end
end
