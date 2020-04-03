require 'package'

class Bcc < Package
  description 'Tools for BPF-based Linux IO analysis, networking, monitoring, and more'
  homepage 'https://github.com/iovisor/bcc'
  version '0.13.0'
  source_url 'https://github.com/iovisor/bcc/releases/download/v0.13.0/bcc-src-with-submodule.tar.gz'
  source_sha256 'dd393ec0b05bb6da5aa5b4a62633e0e5b632b47b8ca0c57860418a7e82e3b797'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'arping'
  depends_on 'elfutils'
  depends_on 'iperf3'
  depends_on 'libtinfo'
  depends_on 'llvm'
  depends_on 'luajit'
  depends_on 'netperf'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
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
