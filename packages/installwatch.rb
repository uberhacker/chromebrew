require 'package'

class Installwatch < Package
  description 'Installwatch is an extremely simple utility to keep track of created and modified files during the installation of a new program.'
  homepage 'http://checkinstall.izto.org/installwatch.html'
  version '0.6.3'
  source_url 'http://checkinstall.izto.org/files/source/installwatch-0.6.3.tar.gz'
  source_sha256 '52cf11b88e6982b5745f81cdde8ef76633f120063b9cfbd76812eefc202896db'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'make'
  end

  def self.install
    system "make PREFIX=#{CREW_DEST_PREFIX} LIBDIR=#{CREW_DEST_LIB_PREFIX} VERSION=#{version} install"
  end
end
