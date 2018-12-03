require 'package'

class Libopenshot < Package
  description 'OpenShot Library (libopenshot) is an open-source project dedicated to delivering high quality video editing, animation, and playback solutions to the world.'
  homepage 'https://github.com/OpenShot/libopenshot'
  version '0.2.2'
  source_url 'https://github.com/OpenShot/libopenshot/archive/v0.2.2.tar.gz'
  source_sha256 '3f92d42b9fdb66e62429a076678b1feae7de06751efc4217347a78282e86f0cc'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cmake' => :build
  depends_on 'ffmpeg'
  depends_on 'imagemagick7'
  depends_on 'llvm'
  depends_on 'openshot_audio'
  depends_on 'pyqt5'
  depends_on 'swig'

  def self.build
    if ARCH == 'x86_64'
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DLIB_SUFFIX=64"
    else
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
    end
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
