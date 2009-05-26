models      = Dir[File.join(RAILS_ROOT, *%w[app models *])]
controllers = Dir[File.join(RAILS_ROOT, *%w[app controllers *])]

(models + controllers).select { |f|  File.file?(f) }.each { |f|  require f }
