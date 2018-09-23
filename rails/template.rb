def source_paths
  [File.expand_path(File.dirname(__FILE__)), *super]
end

copy_file 'docker-compose.yml', 'docker-compose.yml'
copy_file 'rubocop.yml', '.rubocop.yml'
create_file '.ruby-version', "ruby-#{RUBY_VERSION}"

template 'gitignore', '.gitignore', force: true
template 'Dockerfile.tt', force: true
template 'Gemfile.tt', 'Gemfile', force: true
template 'Rakefile.tt', force: true
template 'README.md.tt', force: true

apply 'config/template.rb'

remove_dir 'test'
generate 'rspec:install'

apply 'spec/template.rb'
