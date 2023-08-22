Gem::Specification.new do |s|
  s.name        = 'blankpage'
  s.version     = '1.0.0'
  s.summary     = 'Blank Page Detector'
  s.description = 'Blank Page Detector'
  s.authors     = ['Caleb Land']
  s.email       = 'caleb@land.fm'
  s.files       = ['lib/blankpage.rb']
  s.homepage    =
    'https://rubygems.org/gems/blankpage'
  s.license = 'MIT'

  s.extensions = %w[ext/blankpage/extconf.rb]

  s.add_runtime_dependency('rake', '>= 12.3', '< 14.0')

  s.add_development_dependency('minitest', '~> 5.19.0')
  s.add_development_dependency('pry-byebug', '~> 3.9')
  s.add_development_dependency('rake-compiler', '~> 1.2')
  s.add_development_dependency('rubocop', '~> 1.28')
  s.add_dependency('rice', '>= 4.1.0')
end
