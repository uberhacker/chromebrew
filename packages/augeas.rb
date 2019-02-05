require 'package'

class Augeas < Package
  description 'Augeas is a configuration editing tool and API.'
  homepage 'http://augeas.net/'
  version '1.11.0'
  source_url 'http://download.augeas.net/augeas-1.11.0.tar.gz'
  source_sha256 '393ce8f4055af89cd4c20bf903eacbbd909cf427891f41b56dc2ba66243ea0b0'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-selinux'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
