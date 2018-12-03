require 'package'

class Nautilus < Package
  description 'Provides the user with a simple way to navigate and manage files.'
  homepage 'https://github.com/GNOME/nautilus'
  version '3.30.4'
  source_url 'https://github.com/GNOME/nautilus/archive/3.30.4.tar.gz'
  source_sha256 '7ad4d2353cedcaa75c8126e5fa648db2e728ebcea35a009d28b174b49fedcfab'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'meson' => :build
  depends_on 'sommelier'

  def self.build
    system 'meson wrap promote subprojects/libgd'
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
