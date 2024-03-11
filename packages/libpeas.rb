require 'package'

class Libpeas < Package
  description 'A GObject plugins library'
  homepage 'https://wiki.gnome.org/Projects/Libpeas'
  version '1.34.0'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/GNOME/libpeas/archive/libpeas-1.34.0.tar.gz'
  source_sha256 '514b0576d9a56460915490bdb61dcb88634fdacfb2801e28dcbb9a730348858f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '78ceca9000c59442db18d1b1702822f479296bff42b047019dea40fae8e314d0',
     armv7l: '78ceca9000c59442db18d1b1702822f479296bff42b047019dea40fae8e314d0',
     x86_64: '44fbfaef5fdbc51964688bc0971ce65aa5424db58615a1a688b872f0f4755625'
  })

  depends_on 'gtk3'
  depends_on 'gobject_introspection'
  depends_on 'gtk_doc' => :build
  depends_on 'pygobject' => :build
  depends_on 'glade' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'vala' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'luajit' # R
  depends_on 'py3_gi_docgen' # R
  depends_on 'python3' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
