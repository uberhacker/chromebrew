require 'package'

class Gemacs < Package
  description 'An extensible, customizable, free/libre text editor - and more.'
  homepage 'http://www.gnu.org/software/emacs/'
  version '26.2'
  source_url 'https://ftp.gnu.org/gnu/emacs/emacs-26.2.tar.xz'
  source_sha256 '151ce69dbe5b809d4492ffae4a4b153b2778459de6deb26f35691e1281a9c58e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gemacs-26.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '09babc8080a5d96bd6806698e8c2c787dfc07c58f811f62dc1a152ec1be03441',
     armv7l: '09babc8080a5d96bd6806698e8c2c787dfc07c58f811f62dc1a152ec1be03441',
       i686: '41b850f2c9ad6d3c7e9829a7f0d252b5840c6410ae976fd2f83ef70d2af5c104',
     x86_64: '0b22d53eb7071137632a0e01ab036b7eafd229ee323fd0c9302cadf15b3e1b81',
  })

  depends_on 'emacs'
  depends_on 'giflib'
  depends_on 'libtiff'
  depends_on 'imagemagick6'
  depends_on 'sommelier'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --localstatedir=#{CREW_PREFIX}/share \
            --with-x=yes \
            --with-x-toolkit=gtk3 \
            --with-gif=yes \
	    --with-jpeg=yes \
	    --with-png=yes \
	    --with-rsvg=yes" 
    system 'make'
  end

  def self.install
    system "install -Dm755 src/emacs #{CREW_DEST_PREFIX}/bin/gemacs"
    system "install -Dm755 src/emacs-26.2.1 #{CREW_DEST_PREFIX}/bin/gemacs-26.2.1"
  end
end
