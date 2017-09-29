Pod::Spec.new do |s|

  s.name         = 'AXIndicatorView'
  s.version      = '0.1.1'
  s.summary      = 'An indicator view manager kits.'
  s.description  = <<-DESC
                    An indicator view manager kits using on iOS platform.
                   DESC

  s.homepage     = 'https://github.com/devedbox/AXIndicatorView'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { 'aiXing' => '862099730@qq.com' }
  s.platform     = :ios, '7.0'

  s.source       = { :git => 'https://github.com/devedbox/AXIndicatorView.git', :tag => s.version }
  s.source_files = 'AXIndicatorView/Classes/*.{h,m}'
  s.resource     = "AXIndicatorView/Classes/AXIndicatorView.bundle"
  s.frameworks = 'UIKit', 'Foundation'

  s.requires_arc = true
end
