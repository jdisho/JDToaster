Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "JDToaster"
s.summary = "Toasty iOS alerts"
s.requires_arc = true

s.version = "1.0.0"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Joan Disho" => "dishojoan@gmail.com" }

s.homepage = "https://github.com/jdisho/JDToaster"

s.source = { :git => "https://github.com/jdisho/JDToaster.git", 
             :tag => "#{s.version}" }

s.framework = "Foundation"
s.framework = "UIKit"

s.source_files = "JDToaster/**/*.{swift}"

s.swift_version = "5.0"

end