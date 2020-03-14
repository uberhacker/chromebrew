require 'package'

class Libebur128 < Package
  description 'A library implementing the EBU R128 loudness standard.'
  homepage 'https://github.com/jiixyj/libebur128'
  version '1.2.4'
  source_url 'https://github.com/jiixyj/libebur128/archive/v1.2.4.tar.gz'
  source_sha256 '2ee41a3a5ae3891601ae975d5ec2642b997d276ef647cf5c5b363b6127f7add8'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libsndfile'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '-DCMAKE_BUILD_TYPE=Release',
             '-DENABLE_TESTS=ON',
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
