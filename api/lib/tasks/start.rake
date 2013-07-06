desc "Start development and test servers"
task :start do
  IO.popen('foreman start -f Procfile.dev') do |io|
    io.each { |s| print s }
  end
end