dir = File.expand_path("../../", __FILE__)
working_directory dir
worker_processes 2
timeout 30
# listen 3000
listen "#{dir}/tmp/sockets/unicorn.sock", :backlog => 64
pid "#{dir}/tmp/pids/unicorn.pid"

stderr_path "#{dir}/log/unicorn.stderr.log"
stdout_path "#{dir}/log/unicorn.stdout.log"

