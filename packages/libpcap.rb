require 'package'

class Libpcap < Package
  description 'A portable C/C++ library for network traffic capture.'
  homepage 'https://www.tcpdump.org/'
  version '1.10.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://www.tcpdump.org/release/libpcap-1.10.0.tar.gz'
  source_sha256 '8d12b42623eeefee872f123bd0dc85d535b00df4d42e865f993c40f7bfc92b1e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libnl3'

  def self.build
    system "CFLAGS='-I#{CREW_PREFIX}/include/libnl3' ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
