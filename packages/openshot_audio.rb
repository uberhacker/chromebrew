require 'package'

class Openshot_audio < Package
  description 'OpenShot Audio Library (libopenshot-audio) is a program that allows the high-quality editing and playback of audio, and is based on the amazing JUCE library.'
  homepage 'https://github.com/OpenShot/libopenshot-audio'
  version '0.1.7'
  source_url 'https://github.com/OpenShot/libopenshot-audio/archive/v0.1.7.tar.gz'
  source_sha256 '3aa6dcfc5caaa409cfa63db206d3f6f7e25854642e796915e9ac8fdf9dbc9a3f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cmake' => :build
  depends_on 'graphviz' => :build # needed for dot

  def self.build
    Dir.chdir 'src' do
      if ARCH == 'x86_64'
        system "cmake .. -DCMAKE_CXX_FLAGS='-I#{CREW_PREFIX}/include/freetype2' -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DLIB_SUFFIX=64"
      else
        system "cmake .. -DCMAKE_CXX_FLAGS='-I#{CREW_PREFIX}/include/freetype2' -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
      end
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'src' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
