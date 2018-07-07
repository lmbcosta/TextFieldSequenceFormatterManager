#
#  Be sure to run `pod spec lint TextFieldSequenceFormatterManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "TextFieldSequenceFormatterManager"
s.summary = "Format textfield input sequentially giving a total and number of elements per group"
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4
s.author = { "Luis Costa" => "lmbcosta@hotmail.com" }

# 5
s.homepage = "https://github.com/lmbcosta"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/lmbcosta/TextFieldSequenceFormatterManager.git", :tag => "#{s.version}"}

# 7
s.framework = "UIKit"

# 8
s.source_files = "TextFieldSequenceFormatterManager/**/*.{swift}"



end
