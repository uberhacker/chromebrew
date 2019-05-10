require 'package'

class Texmaker < Package
  description 'Free cross-platform LaTeX editor'
  homepage 'http://www.xm1math.net/texmaker/'
  version '5.0.3'
  source_url 'http://www.xm1math.net/texmaker/texmaker-5.0.3.tar.bz2'
  source_sha256 '6074dffa82c431f8727c39e046f62cb70f5fe1457f158b46306e8f490b4f326f'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
