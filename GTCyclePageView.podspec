Pod::Spec.new do |s|

  s.name         = "GTCyclePageView"
  s.version      = "1.0.0"
  s.summary      = "Display page content circularly in UIScrollView"

  s.homepage     = "https://github.com/gongtao/GTCyclePageView"

  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }

  s.author       = { "gongtao" => "gongtao@jike.com" }

  s.platform     = :ios

  s.source       = { :git => "https://github.com/gongtao/GTCyclePageView.git", :commit => "835a40ada7925e1fa441a50eb74eef893fc96efa" }

  s.source_files  = 'Class/*.{h,m}'

  s.framework  = 'UIKit'

  s.requires_arc = true

end
