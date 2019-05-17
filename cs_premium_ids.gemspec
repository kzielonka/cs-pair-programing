Gem::Specification.new do |s|
  s.name        = "cs_premium_ids"
  s.version     = "0.0.2"
  s.licenses    = []
  s.summary     = ""
  s.description = ""
  s.authors     = ["DroidsOnRoids"],
  s.files       = Dir.glob("lib/**/*")

  s.add_development_dependency "rspec", "~> 3.8.0"

  s.add_runtime_dependency "bcrypt", "~> 3.1"
  s.add_runtime_dependency "ruby_event_store", "~> 0.36.0"
  s.add_runtime_dependency "dry-struct", "~> 0.6.0"
  s.add_runtime_dependency "dry-types", "~> 0.13.4"
end
