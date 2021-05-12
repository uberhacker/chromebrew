require 'package'

class Nping < Package
  description 'Nping is part of the nmap suite - a network diagnostics tool.'
  homepage 'https://nmap.org/nping/'
  version '7.91'
  license 'NPSL'
  compatibility 'all'
  source_url 'https://nmap.org/dist/nmap-7.91.tar.bz2'
  source_sha256 '18cc4b5070511c51eb243cdd2b0b30ff9b2c4dc4544c6312f75ce3a67a593300'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.patch
    #fixup "/usr/bin/file" -> "file" in the configure script
    system "sed -i s#/usr/bin/file##{CREW_PREFIX}/bin/file#g libdnet-stripped/configure"
  end

  def self.build
    #without-zenmap in configure removes openssl dependency
    system "./configure --without-zenmap --prefix=#{CREW_PREFIX}"

    # Make files in the project don't have the right dependencies to build this by itself
    # so just make the whole thing and then install nping - not efficient, but
    # more likely to work than a bunch of Makefile dependency edits
    system 'make'
  end

  def self.install
    system "cd nping && make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
