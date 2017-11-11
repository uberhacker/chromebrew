require 'package'

class Octane < Package
  description 'The JavaScript Benchmark Suite for the modern web https://developers.google.com/octane/.'
  homepage 'https://github.com/chromium/octane'
  version 'v1'
  source_url 'https://github.com/chromium/octane/archive/v1.tar.gz'
  source_sha256 '51e9002e8391f65809c19200e44277d0e5a0adf9f7c03af46676cd321f965d68'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'nginx'

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/share/nginx/html/octane"
    system "cp -r . #{CREW_DEST_PREFIX}/share/nginx/html/octane"
  end

  def self.postinstall
    system "ps ax | grep httpd | grep -v grep | head -1 2> /dev/null > /tmp/httpd.pid"
    if not File.zero? "/tmp/httpd.pid" then
      puts
      puts "Make sure httpd is not running on port 80".lightblue
      puts "sudo apachectl stop".lightblue
    end
    puts
    puts "To perform a benchmark test, execute the following:".lightblue
    puts "startnginx".lightblue
    puts "Visit http://localhost/octane".lightblue
    puts "Click 'Start Octane'".lightblue
    puts
  end
end
