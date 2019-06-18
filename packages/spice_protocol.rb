require 'package'

class Spice_protocol < Package
  description 'Spice protocol headers'
  homepage 'https://www.spice-space.org/'
  version '0.14.0'
  source_url 'https://spice-space.org/download/releases/spice-protocol-0.14.0.tar.bz2'
  source_sha256 'b6a4aa1ca32668790b45a494bbd000e9d05797b391d5a5d4b91adf1118216eac'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
