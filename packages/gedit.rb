require 'package'

class Gedit < Package
  description 'The GNOME text editor'
  homepage 'https://wiki.gnome.org/Apps/Gedit'
  version '3.32.0'
  source_url 'https://gitlab.gnome.org/GNOME/gedit/-/archive/3.32.0/gedit-3.32.0.tar.bz2'
  source_sha256 '964be64558069ebef0418fe4f45c53e337f52e8b2c75308445ff8a81c309b8bc'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'meson' => :build
  depends_on 'libgd'
  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    system 'meson _build'
    system 'ninja -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
