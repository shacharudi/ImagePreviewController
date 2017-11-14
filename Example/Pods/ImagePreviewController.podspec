
Pod::Spec.new do |s|

s.name              = 'ImagePreviewController'
s.version           = '0.1'
s.summary           = 'Image preview with text view, cancel and send buttons'
s.homepage          = 'https://github.com/mcmatan/ImageOpenTransition'
s.ios.deployment_target = '9.0'
s.platform = :ios, '9.0'
s.license           = {
:type => 'MIT',
:file => 'LICENSE'
}
s.author            = {
'YOURNAME' => 'Shachar Udi'
}
s.source            = {
:git => 'https://github.com/mcmatan/ImageOpenTransition.git',
:tag => "#{s.version}" }

s.framework = "UIKit"
s.source_files      = 'ImagePreviewController*' , 'Vendor/*', 'Assets/*', 'ImagePreviewController/*'
s.requires_arc      = true

end
