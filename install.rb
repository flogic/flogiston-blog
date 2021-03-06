require 'fileutils'

def plugin_path(relative)
  File.expand_path(File.join(File.dirname(__FILE__), relative))
end

def rails_path(relative)
  File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', relative))
end

def readme_contents
  IO.read(plugin_path('README.markdown'))
end


# remove application directories not needed in a plugin
['vendor', 'log', 'config', 'lib/tasks', 'script', 'tmp'].each do |path|
  puts "Removing plugin #{path}/ directory (#{plugin_path(path)})..."
  FileUtils.rm_rf(plugin_path(path))
end

puts "Creating new plugin config/ for plugin-specific routes..."
FileUtils.mkdir(plugin_path('config'))

puts "Copying in plugin-specific routes to config/routes.rb..."
FileUtils.copy(plugin_path('lib/plugin-routes.rb'), plugin_path('config/routes.rb'))

if File.directory?(rails_path('db')) and ! File.directory?(rails_path('db/migrate'))
  FileUtils.mkdir(rails_path('db/migrate'))
end

# install our stylesheets to the application
puts "Installing plugin stylesheets #{plugin_path('public/stylesheets/sass')} to #{rails_path('public/stylesheets')}..."
FileUtils.cp_r(plugin_path('public/stylesheets/sass'), rails_path('public/stylesheets'))

# install our database migrations to the application
if File.directory?(rails_path('db/migrate'))
  Dir[File.join(plugin_path('db/migrate'), '*.rb')].each do |migration|
    puts "Installing plugin migration #{migration} to #{rails_path('db/migrate')}..."
    FileUtils.copy(migration, rails_path('db/migrate'))
  end
end

puts "Copying in plugin initialization and unlazy-loading fix..."
FileUtils.copy(plugin_path('lib/plugin-init.rb'), plugin_path('init.rb'))
FileUtils.copy(plugin_path('lib/initializer-unlazy_load.rb'), rails_path('config/initializers/unlazy_load.rb'))

# run our Rails template to insure needed gems and plugins are installed
system("rake rails:template LOCATION=#{plugin_path('templates/plugin-install.rb')}")

# and output our README
puts readme_contents
