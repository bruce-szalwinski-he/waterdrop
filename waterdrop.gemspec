# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'waterdrop/version'

Gem::Specification.new do |spec|
  spec.name          = 'waterdrop'
  spec.version       = ::WaterDrop::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ['Maciej Mensfeld']
  spec.email         = %w[contact@karafka.io]
  spec.homepage      = 'https://karafka.io'
  spec.summary       = 'Kafka messaging made easy!'
  spec.description   = spec.summary
  spec.license       = 'MIT'

  spec.add_dependency 'karafka-core', '>= 2.4.0.alpha1', '< 3.0.0'
  spec.add_dependency 'zeitwerk', '~> 2.3'

  spec.required_ruby_version = '>= 3.0.0'

  if $PROGRAM_NAME.end_with?('gem')
    spec.signing_key = File.expand_path('~/.ssh/gem-private_key.pem')
  end

  spec.cert_chain    = %w[certs/cert_chain.pem]
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.metadata = {
    'funding_uri' => 'https://karafka.io/#become-pro',
    'homepage_uri' => 'https://karafka.io',
    'changelog_uri' => 'https://karafka.io/docs/Changelog-WaterDrop',
    'bug_tracker_uri' => 'https://github.com/karafka/waterdrop/issues',
    'source_code_uri' => 'https://github.com/karafka/waterdrop',
    'documentation_uri' => 'https://karafka.io/docs/#waterdrop',
    'rubygems_mfa_required' => 'true'
  }
end
