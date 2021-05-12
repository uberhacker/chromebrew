require 'package'

class Nmap < Package
  description "Nmap ('Network Mapper') is a free and open source (license) utility for network discovery and security auditing."
  homepage 'https://nmap.org/'
  version '7.91'
  license 'NPSL'
  compatibility 'all'
  source_url 'https://nmap.org/dist/nmap-7.91.tar.bz2'
  source_sha256 '18cc4b5070511c51eb243cdd2b0b30ff9b2c4dc4544c6312f75ce3a67a593300'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libpcap'

  def self.patch
    #fixup "/usr/bin/file" -> "#{CREW_PREFIX}/bin/file" in the configure scripts
    system "sed -i s#/usr/bin/file##{CREW_DEST_PREFIX}/bin/file#g libdnet-stripped/configure"
  end

  def self.build
    system "./configure --with-pcap=linux --without-zenmap --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
