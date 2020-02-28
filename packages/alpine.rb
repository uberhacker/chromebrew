require 'package'

class Alpine < Package
  description 'Alpine is a program to manage e-mail'
  homepage 'http://alpine.x10host.com/alpine/'
  version '1.0.21'
  source_url 'http://alpine.x10host.com/alpine/patches/alpine-2.22/alpine-2.22.tar.xz'
  source_sha256 '8ff01fc780daf257978a9d25c80464510bfebb920aa3c8fe5116633f78bef7b6'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'hunspell_en_us'

  def self.build
    system "./configure \
           --disable-maintainer-mode \
           --prefix=#{CREW_PREFIX} \
           --libdir=#{CREW_LIB_PREFIX} \
           --with-include-path=#{CREW_PREFIX}/include/openssl:#{CREW_PREFIX}include/ncursesw"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
