require 'package'

class Emacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '26.2'
  source_url 'https://ftp.gnu.org/gnu/emacs/emacs-26.2.tar.xz'
  source_sha256 '151ce69dbe5b809d4492ffae4a4b153b2778459de6deb26f35691e1281a9c58e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/emacs-26.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f154394acc72fa516e63b3066a62438ebb43988957948d2c321003dbed68504a',
     armv7l: 'f154394acc72fa516e63b3066a62438ebb43988957948d2c321003dbed68504a',
       i686: 'ba2b4f1e01fa71e156fbdea69c7ff90f8267e3759cac364ec24f03c8fa19eb23',
     x86_64: 'fbc5a5f2d5ad899cba0c85171ad03b74175265c8b344b9a8bf1002c2b5d0818b',
  })

  depends_on 'lcms'
  depends_on 'libjpeg'
  depends_on 'libpng'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --localstatedir=#{CREW_PREFIX}/share \
            --with-x=no \
            --without-makeinfo \
            --without-selinux"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
