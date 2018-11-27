require 'package'

class Libreoffice < Package
  description 'LibreOffice is a powerful office suite - its clean interface and feature-rich tools help you unleash your creativity and enhance your productivity.'
  homepage 'https://www.libreoffice.org/'
  version '6.1.3.2'
  source_url 'https://download.documentfoundation.org/libreoffice/src/6.1.3/libreoffice-6.1.3.2.tar.xz'
  source_sha256 'd46f38f6c48c6d2338fb97c6d0fae9b43802f9849b50817b3bcf9910f1708f44'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ant'
  depends_on 'cups'
  depends_on 'dbus_glib'
  depends_on 'gstreamer_plugins_base'
  depends_on 'gtk2'
  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    system './autogen.sh',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-junit'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
