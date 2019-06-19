require 'package'

class Libosinfo < Package
  description 'libosinfo is a GObject based library API for managing information about operating systems, hypervisors and the (virtual) hardware devices they can support.'
  homepage 'https://libosinfo.org/'
  version '1.2.0'
  source_url 'https://releases.pagure.org/libosinfo/libosinfo-1.2.0.tar.gz'
  source_sha256 'ee254fcf3f92447787a87b3f6df190c694a787de46348c45101e8dc7b29b5a78'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'pygobject'

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
