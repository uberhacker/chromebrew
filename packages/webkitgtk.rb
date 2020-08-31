require 'package'

class Webkitgtk < Package
  description 'WebKitGTK is a full-featured port of the WebKit rendering engine, suitable for projects requiring any kind of web integration, from hybrid HTML/CSS applications to full-fledged web browsers.'
  homepage 'https://webkitgtk.org/'
  version '2.28.4'
  compatibility 'all'
  source_url 'https://webkitgtk.org/releases/webkitgtk-2.28.4.tar.xz'
  source_sha256 '821952e8c9303ed752f1fb1d4283f612c25249d00d705d2b79c2db1bc49c9464'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'meson' => :build
  depends_on 'bubblewrap'
  depends_on 'enchant'
  depends_on 'geoclue'
  depends_on 'gst_plugins_base'
  depends_on 'hyphen'
  depends_on 'libseccomp'
  depends_on 'libsecret'
  depends_on 'woff2'
  depends_on 'wpebackend_fdo'
  depends_on 'xdg_dbus_proxy'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '-DCMAKE_BUILD_TYPE=Release',
             '-DENABLE_MINIBROWSER=ON',
             '-DENABLE_GLES2=ON',
             '-DPORT=GTK',
             '-GNinja',
             '..'
    end
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
