require 'package'

class Unixodbc < Package
  description 'ODBC is an open specification for providing application developers with a predictable API with which to access Data Sources.'
  homepage 'http://www.unixodbc.org/'
  version '2.3.7'
  source_url 'http://www.unixodbc.org/unixODBC-2.3.7.tar.gz'
  source_sha256 '45f169ba1f454a72b8fcbb82abd832630a3bf93baa84731cf2949f449e1e3e77'

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
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
