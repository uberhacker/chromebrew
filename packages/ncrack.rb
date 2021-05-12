require 'package'

class Ncrack < Package
  description 'Ncrack is a high-speed network authentication cracking tool.'
  homepage 'https://nmap.org/ncrack/'
  version '0.7'
  license 'NPSL'
  compatibility 'all'
  source_url 'https://nmap.org/ncrack/dist/ncrack-0.7.tar.gz'
  source_sha256 'f3f971cd677c4a0c0668cb369002c581d305050b3b0411e18dd3cb9cc270d14a'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
