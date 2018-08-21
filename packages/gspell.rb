require 'package'

class Gspell < Package
  description 'Spell-checking library for GTK+ applications'
  homepage 'https://wiki.gnome.org/Projects/gspell'
  version '1.8.1'
  source_url 'https://download.gnome.org/sources/gspell/1.8/gspell-1.8.1.tar.xz'
  source_sha256 '819a1d23c7603000e73f5e738bdd284342e0cd345fb0c7650999c31ec741bbe5'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk3'
  depends_on 'enchant'
  depends_on 'iso_codes'
  depends_on 'vala'

  def self.build
    system './configure',
           "--build=#{ARCH}",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
