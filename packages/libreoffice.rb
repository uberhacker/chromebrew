require 'package'

class Libreoffice < Package
  description 'LibreOffice is a powerful office suite - its clean interface and feature-rich tools help you unleash your creativity and enhance your productivity.'
  homepage 'https://www.libreoffice.org/'
  version '6.1.0.3'
  source_url 'http://download.documentfoundation.org/libreoffice/src/6.1.0/libreoffice-6.1.0.3.tar.xz'
  source_sha256 '54eccd268f75d62fa6ab78d25685719c109257e1c0f4d628eae92ec09632ebd8'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cups'
  depends_on 'dbus_glib'
  depends_on 'gstreamer'
  depends_on 'gtk2'
  depends_on 'gtk3'
  depends_on 'jdk8'
  depends_on 'sommelier'

  def self.build
    system "./autogen.sh --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
