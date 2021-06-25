require 'package'

class Zig < Package
  description 'Programming language designed for robustness, optimality, and clarity'
  homepage 'https://ziglang.org/'
  version '0.8.0'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ziglang.org/download/0.8.0/zig-0.8.0.tar.xz'
  source_sha256 '03a828d00c06b2e3bb8b7ff706997fd76bf32503b08d759756155b6e8c981e77'

  depends_on 'ccache' => :build

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DZIG_USE_CCACHE=ON -DCMAKE_BUILD_TYPE=Release .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "DESTDIR=#{CREW_DEST_DIR} make install"
    end
  end
end
