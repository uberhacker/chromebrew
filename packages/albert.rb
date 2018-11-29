require 'package'

class Albert < Package
  description 'Albert is a unified and efficient keyboard launcher written in C++/Qt.'
  homepage 'https://github.com/albertlauncher/albert'
  version '0.14.22'
  source_url 'https://github.com/albertlauncher/albert/archive/v0.14.22.tar.gz'
  source_sha256 '36fcdcb79f65861dd6da0d073094d0f13b51b3a8522e15e97aeb1ebdb224714b'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'muparser'
  depends_on 'python3'
  depends_on 'qt'

  def self.build
    FileUtils.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake .. -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_BUILD_TYPE=Release"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
