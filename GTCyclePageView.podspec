Pod::Spec.new do |s|

  s.name         = "GTCyclePageView"
  s.version      = "1.0.0"
  s.summary      = "Display page content circularly in UIScrollView"

  s.homepage     = "https://github.com/gongtao/GTCyclePageView"

  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }

  s.author       = { "gongtao" => "gongtao@jike.com" }

  s.platform     = :ios

  s.source       = { :git => "https://github.com/gongtao/GTCyclePageView.git", :commit => "11874389b1f2470249f8d681cab4dd24a0ed1171", :tag =>"1.0.0" }

  s.source_files  = 'Class/*.{h,m}'

  s.framework  = 'UIKit'

  s.requires_arc = true

end
