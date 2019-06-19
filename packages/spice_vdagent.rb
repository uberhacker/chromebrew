require 'package'

class Spice_vdagent < Package
  description 'Spice agent for Linux'
  homepage 'https://www.spice-space.org/'
  version '0.19.0'
  source_url 'https://spice-space.org/download/releases/spice-vdagent/spice-vdagent-0.19.0.tar.bz2'
  source_sha256 '63a77c611c84f8120519a78a30256e43e159085831ac82de71643db643972f65'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk3'
  depends_on 'libx11'
  depends_on 'spice_protocol'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
