# coding: utf-8
$:.push File.expand_path('lib', __dir__)

require "qrcode-generator/version"

gem_files = `git ls-files -- lib/*`.split("\n")

Gem::Specification.new 'qrcode-generator',QrcodeGenerator::Version do |spec|
  spec.authors       = ["Jeffrey"]
  spec.email         = ["jeffrey6052@163.com"]
  spec.description   = "二维码批量生成工具，支持内嵌Logo"
  spec.summary       = "二维码批量生成工具，支持内嵌Logo"
  spec.license       = "MIT"

  spec.files         = gem_files

  spec.add_dependency  "rqrcode", "~> 0.4.2"
  spec.add_dependency  "rmagick", "~> 2.15.4", :require => 'RMagick'

  spec.executables = ["qrcode-generator"]

end