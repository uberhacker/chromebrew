require 'package'

class Julia < Package
  description 'Julia is a flexible dynamic language, appropriate for scientific and numerical computing'
  homepage 'https://julialang.org/'
  version '1.4.2'
  compatibility 'all'
  source_url 'https://github.com/JuliaLang/julia/releases/download/v1.4.2/julia-1.4.2.tar.gz'
  source_sha256 '76a94e06e68fb99822e0876a37c2ed3873e9061e895ab826fd8c9fc7e2f52795'

  binary_url ({
    armv7l: 'file:///home/chronos/user/Downloads/julia-1.4.2-chromeos-armv7l.tar.xz'
  })
  binary_sha256 ({
    armv7l: '01b5954145fc5ea53a1d5f0af0e8f737df1c00b3c67e175c0b89da509dd78ab3'
  })

  depends_on 'curl'
  depends_on 'llvm'
  depends_on 'libgit2'
  depends_on 'libmbedtls'
  depends_on 'libunwind'
  depends_on 'libuv'
  depends_on 'openblas'
  depends_on 'openlibm'
  depends_on 'pcre2'
  depends_on 'suitesparse'

  def self.build
    system 'make', 'cleanall'
    system 'make'
  end

#  def self.check
#    system 'make', 'cleanall'
#    system 'make', 'test'
#  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.mv 'usr/etc', CREW_DEST_PREFIX
    FileUtils.mv 'usr/lib/julia', CREW_DEST_LIB_PREFIX
    FileUtils.mv 'usr/bin/julia', "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'usr/share/julia', "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv 'usr/include/julia', "#{CREW_DEST_PREFIX}/include"
    FileUtils.mv 'usr/lib/libdSFMT.so', CREW_DEST_LIB_PREFIX
    FileUtils.mv 'usr/lib/libccalltest.so', CREW_DEST_LIB_PREFIX
    FileUtils.mv 'usr/lib/libgfortran.so.5', CREW_DEST_LIB_PREFIX
    FileUtils.mv 'usr/lib/libllvmcalltest.so', CREW_DEST_LIB_PREFIX
    FileUtils.mv 'usr/lib/libsuitesparse_wrapper.so', CREW_DEST_LIB_PREFIX
    FileUtils.mv Dir.glob('usr/lib/libLLVM*.so'), CREW_DEST_LIB_PREFIX
    FileUtils.mv Dir.glob('usr/lib/libjulia.so*'), CREW_DEST_LIB_PREFIX
    FileUtils.mv Dir.glob('usr/lib/libOptRemarks.so*'), CREW_DEST_LIB_PREFIX
    FileUtils.mv 'usr/share/man/man1/julia.1', "#{CREW_DEST_MAN_PREFIX}/man1"
  end
end
