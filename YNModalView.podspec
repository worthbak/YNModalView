Pod::Spec.new do |spec|
  spec.name = "YNModalView"
  spec.version = "1.0.0"
  spec.summary = "An extensible, simple, and stylish modal view, written in Swift.."
  spec.homepage = "https://github.com/worthbak/YNModalView"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Worth Baker" => 'worthbak@gmail.com' }
  spec.social_media_url = "http://twitter.com/worthbak"

  spec.platform = :ios, "9.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/worthbak/YNModalView.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "YNModalView/**/*.{h,swift}"

  spec.dependency "Curry", "~> 1.4.0"
end