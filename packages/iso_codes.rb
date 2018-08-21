require 'package'

class Iso_codes < Package
  description 'ISO language, territory, currency, script codes and their translations'
  homepage 'https://salsa.debian.org/iso-codes-team/iso-codes'
  version '3.79'
  source_url 'https://salsa.debian.org/iso-codes-team/iso-codes/uploads/ef8de8bc12e0512d26ed73436a477871/iso-codes-3.79.tar.xz'
  source_sha256 'cbafd36cd4c588a254c0a5c42e682190c3784ceaf2a098da4c9c4a0cbc842822'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
