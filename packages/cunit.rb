require 'package'

class Cunit < Package
  description 'CUnit is a lightweight system for writing, administering, and running unit tests in C.'
  homepage 'http://cunit.sourceforge.net/'
  version '2.1-3'
  source_url 'http://downloads.sourceforge.net/project/cunit/CUnit/2.1-3/CUnit-2.1-3.tar.bz2'
  source_sha256 'f5b29137f845bb08b77ec60584fdb728b4e58f1023e6f249a464efa49a40f214'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'autoreconf -i -f'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-examples',
           '--disable-static'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
