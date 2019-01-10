require 'package'

class Librecad < Package
  description 'LibreCAD is a free Open Source CAD application for Windows, Apple and Linux.'
  homepage 'https://librecad.org/'
  version '2.2.0-rc1'
  source_url 'https://github.com/LibreCAD/LibreCAD/archive/2.2.0-rc1.tar.gz'
  source_sha256 '2c937a9423ecf501902ef74c722ec413562e47c45125ac87257f02942d0676ea'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'boost'
  depends_on 'qt5'

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
