require 'buildsystems/autotools'

class Pinta < Autotools
  description 'Simple GTK Paint Program'
  homepage 'http://www.pinta-project.com/'
  version '3.0.3'
  license 'MIT, Unknown licenses'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/PintaProject/Pinta.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ebecfeff108d16f671271dadcb423d43f5342c2a19fd705ff18e38673de86d32',
     armv7l: 'ebecfeff108d16f671271dadcb423d43f5342c2a19fd705ff18e38673de86d32',
     x86_64: '1e7a0c86ad72bbddcbcb85e01d3d848109ddc9e5680004206a2fc5428d0e261c'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'dotnet' => :build
  depends_on 'gtk3'
  depends_on 'libadwaita'

  run_tests
end
