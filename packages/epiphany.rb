# Adapted from Arch Linux epiphany PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/epiphany/trunk/PKGBUILD

require 'package'

class Epiphany < Package
  description 'A GNOME web browser based on the WebKit rendering engine'
  homepage 'https://wiki.gnome.org/Apps/Web'
  version '40.1'
  license 'GPL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/epiphany/-/archive/#{version}/epiphany-#{version}.tar.bz2"
  source_sha256 '0f906479949e8413601008da00291fbdebcf410c85f6dfa4d5a83d5b34a30183'

  binary_url({
  })
  binary_sha256({
  })

  depends_on 'atk'
  depends_on 'cairo' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'freetype' => :build
  depends_on 'gcr'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3'
  depends_on 'help2man' => :build
  depends_on 'json_glib'
  depends_on 'libarchive'
  depends_on 'libdazzle'
  depends_on 'libhandy'
  depends_on 'libportal'
  depends_on 'libsecret'
  depends_on 'libsoup2'
  depends_on 'lsb_release' => :build
  depends_on 'pango'
  depends_on 'startup_notification' => :build
  depends_on 'webkit2gtk_4'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas/"
  end
end
