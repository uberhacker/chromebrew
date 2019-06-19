require 'package'

class Libvirt < Package
  description 'Libvirt provides a portable, long term stable C API for managing the virtualization technologies'
  homepage 'https://libvirt.org/'
  version '5.4.0'
  source_url 'https://libvirt.org/sources/libvirt-5.4.0.tar.xz'
  source_sha256 '1cfa802081bee09fd0ddfa97bd491e6554e25fa59f7a7758b41d8aef53458e7b'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
