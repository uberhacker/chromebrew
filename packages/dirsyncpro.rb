require 'package'

class Dirsyncpro < Package
  description 'DirSync Pro is a utility for file and folder synchronization.'
  homepage 'https://www.dirsyncpro.org/'
  version '1.53'
  source_url 'http://downloads.sourceforge.net/project/directorysync/DirSync%20Pro%20%28stable%29/1.53/DirSyncPro-1.53-noarch.tar.gz'
  source_sha256 'ed8ced2550a2f5b6c8d0a7d29227f370a9ea11bc3ba37de66c7c6b7e11fa81da'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'jdk8'

  def self.build
    system "echo '#!/bin/bash' > dirsync"
    system "echo 'java -Xmx512M -Dfile.encoding=UTF-8 -jar #{CREW_PREFIX}/share/dirsyncpro/dirsyncpro.jar \$\*' >> dirsync"
  end

  def self.install
    system "install -Dm755 dirsync #{CREW_DEST_PREFIX}/bin/dirsync"
    system "rm -f dirsync"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/dirsyncpro"
    system "cp -r . #{CREW_DEST_PREFIX}/share/dirsyncpro"
  end
end
