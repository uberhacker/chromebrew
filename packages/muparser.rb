require 'package'

class Muparser < Package
  description 'muParser is an extensible high performance math expression parser library written in C++.'
  homepage 'http://beltoforion.de/article.php?a=muparser'
  version '2.6.1'
  source_url 'https://github.com/beltoforion/muparser/archive/v2.2.6.1.tar.gz'
  source_sha256 'd2562853d972b6ddb07af47ce8a1cdeeb8bb3fa9e8da308746de391db67897b3'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure \
           --prefix=#{CREW_PREFIX} \
           --libdir=#{CREW_LIB_PREFIX} \
           --enable-shared=yes \
           --enable-samples=no \
           --enable-debug=no"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
