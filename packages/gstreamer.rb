require 'package'

class Gstreamer < Package
  description 'Open source multimedia framework'
  homepage 'https://gstreamer.freedesktop.org/'
  version '1.14.2'
  source_url 'https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.14.2.tar.xz'
  source_sha256 '4bd6127299f3f29379046bbd58a526e6353b569e0e72f7b4df2ae70df6882e09'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glib'
  depends_on 'python27'

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
