require 'package'

class Timeshift < Package
  description 'System restore tool for Linux.'
  homepage 'https://github.com/teejee2008/timeshift'
  version '19.01'
  source_url 'https://github.com/teejee2008/timeshift/archive/v19.01.tar.gz'
  source_sha256 '557223cf0b9ab0c4848455e1cc4d9068c607b9f5492a2de4935a2f40393e3c5f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtkvte'
  depends_on 'libgee'

  def self.build
    system 'make all'
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
