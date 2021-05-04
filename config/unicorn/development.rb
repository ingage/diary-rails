# frozen_string_literal: true

# ワーカー数を定義 (開発環境はコア1なので、倍の2がたぶん限界)
worker_processes 2

pid Rails.root.join('tmp/pids/unicorn.pid').to_s

# コンソールにログが出力されなくなるので、コメントアウト
# stderr_path File.expand_path('log/unicorn.log')
# stdout_path File.expand_path('log/unicorn.log')

# Unicornの起動コマンドを実行するディレクトリを指定します。
# （記載しておけば他のディレクトリでこのファイルを叩けなくなる。）
working_directory Rails.root

# 接続タイムアウト時間
timeout 1800

# 基本的には`true`を指定する。Unicornの再起動時にダウンタイムなしで再起動が行われる。
preload_app true

# 再起動のためにUSR2シグナルを送るとゾンビプロセスが発生するらしい
before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  # USR2シグナルを受けると古いプロセスを止める
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
    begin
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "failed kill process #{sig}" # rubocop:disable Rails/Output
    end
  end

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead' # rubocop:disable Rails/Output
    Process.kill 'QUIT', Process.pid
  end
end

# unicorn を止めたときに DB connection が残ることがあるらしいので明示的に止める
after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end
