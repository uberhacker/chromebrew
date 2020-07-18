require 'package'

class Intel_gpu_tools < Package
  description 'Intel GPU Tools is a collection of tools for development and testing of the Intel DRM driver.'
  homepage 'https://01.org/linuxgraphics/'
  version '1.22'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'https://www.x.org/archive/individual/app/intel-gpu-tools-1.22.tar.xz'
    source_sha256 '3d66c1dc5110712ca4d22199b3ce9853f261be1690064edf87e69e5392e39a5c'
    depends_on 'xorg_server' => :build
    depends_on 'gsl'
    depends_on 'libkmod'
    depends_on 'procps'
  end

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/intel_gpu_tools-1.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '53d8682db2080827cc793a927d6559e9e470ab8bcea9a34fae35070e4aa2870b',
  })

  def self.build
    system "./autogen.sh #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
