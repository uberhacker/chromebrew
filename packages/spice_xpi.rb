require 'package'

class Spice_xpi < Package
  description 'Allows you to execute spice-client directly from the oVirt/RHEVM UserPortal.'
  homepage 'https://www.spice-space.org/'
  version '2.8.90'
  source_url 'https://spice-space.org/download/releases/spice-xpi/spice-xpi-2.8.90.tar.bz2'
  source_sha256 '1414559aa77f01d3f92ee0acadaae1351e3a2da6d1fe80447c69cab494101d35'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
