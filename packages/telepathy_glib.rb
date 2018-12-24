require 'package'

class Telepathy_glib < Package
  description 'Real-time communication & collaboration for the desktop & mobile'
  homepage 'https://telepathy.freedesktop.org/'
  version '0.24.1'
  source_url 'https://telepathy.freedesktop.org/releases/telepathy-glib/telepathy-glib-0.24.1.tar.gz'
  source_sha256 '9e0df1d8f857e0270cf0b32e2d1ca5a24aa7282873361785d573f72ad7f7d5eb'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'dbus_glib'

  def self.build
    system './autogen.sh'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-vala-bindings'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
