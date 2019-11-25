require 'package'

class Skyeye < Package
  description 'SkyEye is a very fast full system simulator which takes llvm as IR of dynmic compiled framework.'
  homepage 'https://sourceforge.net/projects/skyeye/'
  version '1.3.5-rc1'
  source_url 'https://downloads.sourceforge.net/project/skyeye/skyeye/skyeye-1.3.5/skyeye-1.3.5_rc1.tar.bz2'
  source_sha256 'c54e2dfc52197604869dc90181f888a14b603106099d6467685b84f439397a96'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'sommelier'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-x'
    system 'make lib'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install_lib'
  end
end
