require 'package'

class Blender < Package
  description 'Blender is the free and open source 3D creation suite.'
  homepage 'https://www.blender.org/'
  version '4.1.1'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://mirror.clarkson.edu/blender/release/Blender4.1/blender-4.1.1-linux-x64.tar.xz'
  source_sha256 'ab2ea3fe991601a5e6bd2cda786ecaa919c0b39e0550e59978b5d40270c260d3'

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'libice' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxi' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxrender' # R
  depends_on 'libxt' # R
  depends_on 'libxxf86vm' # R
  depends_on 'mesa' # R
  depends_on 'ncurses' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R
  depends_on 'sommelier' # L

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/blender"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/blender"
    FileUtils.ln_s "#{CREW_PREFIX}/share/blender/blender", "#{CREW_DEST_PREFIX}/bin/blender"
  end

  def self.postinstall
    ExitMessage.add "Type 'blender' to get started.".lightblue
  end
end
