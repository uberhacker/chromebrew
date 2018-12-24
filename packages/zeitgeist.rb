require 'package'

class Zeitgeist < Package
  description 'Zeitgeist is a service which logs the users\' activities and events, anywhere from files opened to websites visited and conversations.'
  homepage 'https://zeitgeist.freedesktop.org/'
  version '1.0.1'
  source_url 'https://launchpad.net/zeitgeist/1.0/1.0.1/+download/zeitgeist-1.0.1.tar.xz'
  source_sha256 '7de6a8e7b8aed33490437e522a9bf2e531681118c8cd91c052d554bbe64435bd'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'raptor'
  depends_on 'rdflib'
  depends_on 'telepathy_glib'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
