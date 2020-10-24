require 'package'

class Rtmpdump < Package
  description 'rtmpdump is a toolkit for RTMP streams.'
  homepage 'https://rtmpdump.mplayerhq.hu/'
  version 'c5f04a58f'
  compatibility 'all'
  source_url 'https://git.ffmpeg.org/gitweb/rtmpdump.git/snapshot/c5f04a58fc2aeea6296ca7c44ee4734c18401aa3.tar.gz'
  source_sha256 'fd8c21263d93fbde8bee8aa6c5f6a657789674bb0f9e74f050651504d5f43b46'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "sed -i 's,prefix=/usr/local,prefix=#{CREW_PREFIX},' Makefile"
    system "sed -i 's,prefix=/usr/local,prefix=#{CREW_PREFIX},' librtmp/Makefile"
    system "sed -i 's,libdir=\$(prefix)/lib,libdir=#{CREW_LIB_PREFIX},' librtmp/Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
