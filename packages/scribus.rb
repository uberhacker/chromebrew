require 'package'

class Scribus < Package
  description 'Open Source Desktop Publishing'
  homepage 'https://www.scribus.net/'
  version '1.4.7'
  source_url 'https://downloads.sourceforge.net/project/scribus/scribus/1.4.7/scribus-1.4.7.tar.xz'
  source_sha256 '42d335b4a59c26c8ae1e3f601676baa3c42b035b8cde326d195f7a30078e5fec'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ghostscript'
  depends_on 'cairo'
  depends_on 'libtiff'
  depends_on 'lcms'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'cups'
  depends_on 'python3'
  depends_on 'aspell'
  depends_on 'qtbase'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
