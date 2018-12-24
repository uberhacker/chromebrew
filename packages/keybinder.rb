require 'package'

class Keybinder < Package
  description 'keybinder is a library for registering global key bindings, for gtk-based applications in X11. With gir bindings.'
  homepage 'https://github.com/kupferlauncher/keybinder'
  version '3.0-0.3.2'
  source_url 'https://github.com/kupferlauncher/keybinder/releases/download/keybinder-3.0-v0.3.2/keybinder-3.0-0.3.2.tar.gz'
  source_sha256 'e6e3de4e1f3b201814a956ab8f16dfc8a262db1937ff1eee4d855365398c6020'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
