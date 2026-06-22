require 'buildsystems/cmake'

class Fbedit < CMake
  description 'Integrated development environment for the FreeBASIC compiler.'
  homepage 'https://sourceforge.net/projects/fbedit/'
  version '0.5.0'
  license 'GPLv2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/fbide/v#{version}/FBIde%20#{version}%20source%20code.tar.gz"
  source_sha256 '222c32624ae03f01df78e79d7ed3072fc8ae0398c98d3724b90504babd2e00f0'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'wxwidgets'
  depends_on 'sommelier'
end
