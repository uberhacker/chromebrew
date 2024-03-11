require 'package'

class Gnome_desktop < Package
  description 'Library with common API for various GNOME modules'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-desktop'
  version '43'
  license 'GPL-2+, LGPL-2+ and FDL-1.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-desktop.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a74b7c69028d47aaf02549264b22818423cec6fef60b40ef3a25f188f5337ede',
     armv7l: 'a74b7c69028d47aaf02549264b22818423cec6fef60b40ef3a25f188f5337ede',
     x86_64: '759b39213e12c916986ba8c7913f25f7a38cba961d8b85241ba80e4aa59d8a86'
  })

  depends_on 'cairo'
  depends_on 'eudev'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gsettings_desktop_schemas'
  depends_on 'gtk3'
  depends_on 'gtk_doc' => :build
  depends_on 'iso_codes'
  depends_on 'libjpeg'
  depends_on 'libxkbcommon'
  depends_on 'libxkbfile'
  depends_on 'xkeyboard_config'
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'yelp_tools' => :build
  depends_on 'glibc' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'libseccomp' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dsystemd=disabled \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
