require 'package'

class Clementine < Package
  description 'Clementine is a modern music player and library organizer'
  homepage 'https://www.clementine-player.org/'
  version '1.3.1'
  source_url 'https://github.com/clementine-player/Clementine/archive/1.3.1.tar.gz'
  source_sha256 'f885931a9ab7c88607d07b50c64fcce46fc05f13dd2c0a04188c94eff938f37c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cmake' => :build
  depends_on 'qt4'

  def self.build
    Dir.chdir 'bin' do
      system "cmake .. -DPREFIX=#{CREW_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX}"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'bin' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
