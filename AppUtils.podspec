Pod::Spec.new do |s|
    s.name         = "AppUtils"
    s.version      = "0.0.4"
    s.summary      = "provide general tools for ios developer"
    s.description  = <<-DESC
    this project provide general tools for ios developer
    DESC
    s.homepage     = "https://github.com/softwaredavid/AppUtils"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author             = { "softwaredavid" => "softwaredavid@gmail.com" }
    s.platform     = :ios,"8.0" 
    s.source       = { :git => "https://github.com/softwaredavid/AppUtils.git", :tag => "0.0.4" }
    s.source_files  = "Utils/*"
##    s.exclude_files = "Classes/Exclude"
####    s.public_header_files = "iOS_Category/Classes/UIKit/UI_Categories.h"，"iOS_Category/Classes/Foundation/Foundation_Category.h"，"iOS_Category/Classes/**/*.h"
    s.requires_arc = true
end
