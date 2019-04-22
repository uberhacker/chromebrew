require 'package'

class Libgee < Package
  description 'Libgee is an utility library providing GObject-based interfaces and classes for commonly used data structures.'
  homepage 'https://wiki.gnome.org/Projects/Libgee'
  version '0.20.1'
  source_url 'https://download.gnome.org/sources/libgee/0.20/libgee-0.20.1.tar.xz'
  source_sha256 'bb2802d29a518e8c6d2992884691f06ccfcc25792a5686178575c7111fea4630'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gobject_introspection'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
