require 'package'

class Gparted < Package
  description 'GParted is a free partition editor for graphically managing your disk partitions.'
  homepage 'https://gparted.org/'
  version '0.32.0'
  source_url 'https://prdownloads.sourceforge.net/project/gparted/gparted/gparted-0.32.0/gparted-0.32.0.tar.gz'
  source_sha256 'ae1db86def71015f2d755310a32ab334354076d23bf400e35a720226112357ba'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gparted-0.32.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gparted-0.32.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gparted-0.32.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gparted-0.32.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a900deaf64ce46bc7436b6a025fc126d88319d553ae1efe16cdaea4457f84f86',
     armv7l: 'a900deaf64ce46bc7436b6a025fc126d88319d553ae1efe16cdaea4457f84f86',
       i686: '5fa32dda54eca18f424d8cb219365b34676b8fcad6a61e3c1be8fbaf56b5665b',
     x86_64: '3002c4aedd80bf6b89274d7615a081aeb1b4563bd563188cc00241bb249fb600',
  })

  depends_on 'gtkmm2'
  depends_on 'parted'
  depends_on 'sommelier'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-doc',
           '--disable-static',
           '--disable-maintainer-mode',
           '--enable-xhost-root'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
