require 'package'

class Qt4 < Package
  description 'A complete cross-platform C++ software framework and widget toolkit for creating classic and embedded graphical user interfaces.'
  homepage 'https://www.qt.io/'
  version '4.8.7'
  source_url 'https://download.qt.io/archive/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz'
  source_sha256 'e2882295097e47fe089f8ac741a95fef47e0a73a3f3cdf21b56990638f626ea0'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'alsa_plugins'
  depends_on 'cups'
  depends_on 'ffmpeg'
  depends_on 'fontconfig'
  depends_on 'freetds'
  depends_on 'gstreamer'
  depends_on 'harfbuzz'
  depends_on 'jsoncpp'
  depends_on 'lcms'
  depends_on 'libevent'
  depends_on 'libinput'
  depends_on 'libjpeg'
  depends_on 'libvpx'
  depends_on 'protobuf'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}/share/Qt-4",
           "--libdir=#{CREW_LIB_PREFIX}",
           '-verbose',
           '-release',
           '-opensource',
           '-confirm-license',
           '-system-libjpeg',
           '-system-libpng',
           '-system-freetype',
           '-system-zlib',
           '-no-webkit'
    system 'make'
  end

  def self.install
    system 'make', "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir "#{CREW_DEST_PREFIX}/share/Qt-4/bin" do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/share/Qt-4/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
  end
end
