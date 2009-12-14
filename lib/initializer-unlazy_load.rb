models      = Dir[File.join(RAILS_ROOT, *%w[app models *])]
controllers = Dir[File.join(RAILS_ROOT, *%w[app controllers *])]
helpers     = Dir[File.join(RAILS_ROOT, *%w[app helpers *])]

(models + controllers).select { |f|  File.file?(f) }.each { |f|  require f }
