require 'package'

class Libdrm < Package
  description 'Cross-driver middleware for DRI protocol.'
  homepage 'https://dri.freedesktop.org'
  version '2.4.100'
  source_url 'https://dri.freedesktop.org/libdrm/libdrm-2.4.100.tar.bz2'
  source_sha256 'c77cc828186c9ceec3e56ae202b43ee99eb932b4a87255038a80e8a1060d0a5d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libpciaccess'
  depends_on 'xorg_lib'
  depends_on 'eudev'
  depends_on 'libxslt'

  def self.build
    system './configure',
           '--enable-etnaviv-experimental-api',
           '--enable-exynos-experimental-api',
           '--enable-tegra-experimental-api',
           '--enable-omap-experimental-api',
           '--enable-install-test-programs',
           "--libdir=#{CREW_LIB_PREFIX}",
           "--prefix=#{CREW_PREFIX}",
           '--enable-freedreno-kgsl',
           '--enable-freedreno',
           '--enable-manpages',
           '--enable-nouveau',
           '--enable-amdgpu',
           '--enable-vmwgfx',
           '--enable-intel',
           '--enable-udev',
           '--enable-vc4'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
