require 'package'

class Guayadeque < Package
  description 'Full featured linux music player'
  homepage 'http://www.guayadeque.org/'
  version '0.4.6'
  compatibility 'all'
  source_url 'https://github.com/anonbeat/guayadeque/archive/v0.4.6.tar.gz'
  source_sha256 '3c0d782c6f4aa511c7a635a78742542d130d1a13e20648db886ccfce4e1b9d4f'

  depends_on 'taglib'
  depends_on 'gstreamer'
  depends_on 'wxsqlite'
  depends_on 'dbus'
  depends_on 'glib'
  depends_on 'sommelier'

  def self.build
    Dir.mkdir '_build'
    Dir.chdir '_build' do
      system "cmake #{CREW_CMAKE_OPTIONS} .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir '_build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
