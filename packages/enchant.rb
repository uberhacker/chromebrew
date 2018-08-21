require 'package'

class Enchant < Package
  description 'Enchant is a library (and command-line program) that wraps a number of different spelling libraries and programs with a consistent interface.'
  homepage 'https://abiword.github.io/enchant/'
  version '2.2.3'
  source_url 'https://github.com/AbiWord/enchant/releases/download/v2.2.3/enchant-2.2.3.tar.gz'
  source_sha256 'abd8e915675cff54c0d4da5029d95c528362266557c61c7149d53fa069b8076d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glib'

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
