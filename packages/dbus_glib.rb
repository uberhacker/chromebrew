require 'package'

class Dbus_glib < Package
  description 'simple interprocess messaging system (GLib-based shared library)'
  homepage 'https://directory.fsf.org/wiki/Dbus-glib'
  version '0.108'
  source_url 'https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.108.tar.gz'
  source_sha256 '9f340c7e2352e9cdf113893ca77ca9075d9f8d5e81476bf2bf361099383c602c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'dbus'
  depends_on 'glib'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
