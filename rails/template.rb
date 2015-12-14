def source_paths
  Array(super) + [File.expand_path(File.dirname(__FILE__))]
end

copy_file 'rubocop.yml', '.rubocop.yml'
copy_file 'gitignore', '.gitignore', force: true
create_file '.ruby-version', RUBY_VERSION
remove_file 'README.rdoc'

template 'Gemfile.tt', force: true
template 'Rakefile.tt', force: true

apply 'app/template.rb'
apply 'config/template.rb'

environment %Q{
  config.generators do |generators|
    generators.helper       false
    generators.assets       false
    generators.javascripts  false
    generators.stylesheets  false
    generators.view_specs   false
    generators.helper_specs false

    generators.test_framework :rspec, fixture: true
  end
}

remove_dir 'test'
generate 'rspec:install'

apply 'spec/template.rb'
