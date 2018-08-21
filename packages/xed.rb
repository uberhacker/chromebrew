require 'package'

class Xed < Package
  description 'X-Apps [Text] Editor (Cross-DE, backward-compatible, GTK3, traditional UI)'
  homepage 'https://github.com/linuxmint/xed'
  version '1.8.3'
  source_url 'https://github.com/linuxmint/xed/archive/1.8.3.tar.gz'
  source_sha256 '641325e9c6ace00d9b2ea6b7e93f12b3f4739829e28a2738c8c19158ecb93282'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gspell'
  depends_on 'sommelier'

  def self.build
    system "./autogen.sh --build=#{ARCH} --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
