require 'package'

class Gstreamer_plugins_base < Package
  description 'Open source multimedia framework'
  homepage 'https://gstreamer.freedesktop.org/'
  version '1.14.2'
  source_url 'https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.14.2.tar.xz'
  source_sha256 'a4b7e80ba869f599307449b17c9e00b5d1e94d3ba1d8a1a386b8770b2ef01c7c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'alsa_lib'
  depends_on 'gstreamer'
  depends_on 'libjpeg'
  depends_on 'libopus'
  depends_on 'libsdl'
  depends_on 'libtheora'

  def self.build
    system 'wget https://raw.githubusercontent.com/sdroege/gstreamer-rs/ba4b4a03f015bb8b924b355741f0d64ce71a443f/gir-files/Gst-1.0.gir'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('Gst-1.0.gir') ) == '43046e70f75407acf2e4b3c9977e8802d0ccfe5464baadc5f1a8391a289ad59f'
    system 'wget https://raw.githubusercontent.com/sdroege/gstreamer-rs/ba4b4a03f015bb8b924b355741f0d64ce71a443f/gir-files/GstBase-1.0.gir'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('GstBase-1.0.gir') ) == 'bb4122508510e8a241d14985878efbdbfee6b49a3706f0e25ae9f806f0b9b4b7'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    #system "install -Dm644 Gst-1.0.gir #{CREW_DEST_PREFIX}/"
  end
end
