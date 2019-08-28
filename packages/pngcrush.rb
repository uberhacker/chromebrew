require 'package'

class Pngcrush < Package
  description 'Tool for compressing PNG (Portable Network Graphics) files.'
  homepage 'http://pmt.sourceforge.net/'
  version '1.8.13'
  source_url 'https://downloads.sourceforge.net/project/pmt/pngcrush/1.8.13/pngcrush-1.8.13.tar.xz'
  source_sha256 '8fc18bcbcc65146769241e20f9e21e443b0f4538d581250dce89b1e969a30705'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libpng'

  def self.build
    system 'make'
  end

  def self.install
    system "install -Dm755 pngcrush #{CREW_DEST_PREFIX}/bin/pngcrush"
  end
end
