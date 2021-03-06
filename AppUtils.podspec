Pod::Spec.new do |s|
    s.name         = "AppUtils"
    s.version      = "0.1.0"
    s.summary      = "provide general tools for ios developer"
    s.description  = <<-DESC
    this project provide general tools for ios developer
    DESC
    s.homepage     = "https://github.com/softwaredavid/AppUtils"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author             = { "softwaredavid" => "softwaredavid@gmail.com" }
    s.platform     = :ios,"8.0" 
    s.source       = { :git => "https://github.com/softwaredavid/AppUtils.git", :tag => "0.1.0" }
    s.source_files  = "Utils/*"
    s.requires_arc = true


    s.subspec 'Extension' do |ss|
    ss.source_files = "Utils/Extension/*"
    end

#    s.subspec 'UI' do |ss|
#    ss.source_files = "UI/*"
#    ss.dependency 'Extension'
#    end

#    s.subspec 'UIkit' do |ss|
#    ss.source_files = "UIkit/*"
#    s.dependency 'Extension'
#    end
end

