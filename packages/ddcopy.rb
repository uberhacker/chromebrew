require 'package'

class Ddcopy < Package
  description 'ddCopy writes bootable iso image files'
  homepage 'https://www.linux-apps.com/p/1240360/'
  version '0.2.3'
  source_url 'file:///home/chronos/user/Downloads/ddcopy-0.2.3.tar.xz'
  source_sha256 '298b6b9c742e1108dd137ca356a849b3dbc846b97aaca7d30f5f28361ef39834'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ddcopy-0.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ddcopy-0.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ddcopy-0.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ddcopy-0.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '32edd7b35d0f41d4501f1b3ad71d68033fae4790d4b66a49c88753afc048d5bc',
     armv7l: '32edd7b35d0f41d4501f1b3ad71d68033fae4790d4b66a49c88753afc048d5bc',
       i686: 'eaab0909a98bf0efd87005d939e453c7eda104705a9cb618a23093c22662f537',
     x86_64: '9b5615e8ad3200895c56506ae66767f605397d18553c137e73880b8cc79a906e',
  })

  depends_on 'eudev'
  depends_on 'pygtk'
  depends_on 'cdrkit'
  depends_on 'yad'
  depends_on 'sommelier'

  def self.patch
    unless File.exists? "#{HOME}/Downloads/ddcopy-0.2.3.tar.xz"
      abort "Visit https://www.linux-apps.com/p/1240360/ and download ddcopy-0.2.3.tar.xz to ~/Downloads and try again.".orange
    end
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' Makefile"
    system "sed -i 's,/usr/lib64,#{CREW_LIB_PREFIX},g' Makefile"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' Makefile"
  end

  def self.build
    system 'make'
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' bin/ddcopy"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' bin/ddcopy"
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' data/ddcopycd"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' data/ddcopycd"
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' data/format"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' data/format"
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' data/usb"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' data/usb"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
