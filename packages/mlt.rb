require 'package'

class Mlt < Package
  description 'MLT is an open source multimedia framework, designed and developed for television broadcasting.'
  homepage 'https://www.mltframework.org/'
  version '6.20.0'
  source_url 'https://github.com/mltframework/mlt/releases/download/v6.20.0/mlt-6.20.0.tar.gz'
  source_sha256 'ab211e27c06c0688f9cbe2d74dc0623624ef75ea4f94eea915cdc313196be2dd'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'qtbase' => :build
  depends_on 'libexif'
  depends_on 'ffmpeg'
  depends_on 'gtk3'
  depends_on 'qtsvg'
  depends_on 'rtaudio'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_C_FLAGS=-I#{CREW_PREFIX}/include/gtk-3.0 -I#{CREW_PREFIX}/include/cairo",
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
