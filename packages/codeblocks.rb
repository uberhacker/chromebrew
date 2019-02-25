require 'package'

class Codeblocks < Package
  description 'Code::Blocks is a free C, C++ and Fortran IDE built to meet the most demanding needs of its users.'
  homepage 'http://www.codeblocks.org/'
  version '17.12'
  source_url 'https://downloads.sourceforge.net/project/codeblocks/Sources/17.12/codeblocks_17.12.tar.xz'
  source_sha256 '13881a0a72769694e82e531b8e7814d51fbf1fa122c73c5004e186560fbc57e0'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'boost'
  depends_on 'gamin'
  depends_on 'gtk2'
  depends_on 'hunspell'
  depends_on 'wxwidgets'
  depends_on 'sommelier'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           #'--with-contrib-plugins',
           '--with-boost=yes',
           '--with-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
