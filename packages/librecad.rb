require 'package'

class Librecad < Package
  description 'LibreCAD is a free Open Source CAD application for Windows, Apple and Linux.'
  homepage 'https://librecad.org/'
  version '2.2.0-rc2'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/LibreCAD/LibreCAD.git'
  git_hashtag '2.2.0-rc2'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'boost'
  depends_on 'qtsvg' => :build

  def self.build
    system "QT_PLUGIN_PATH=./plugins qmake -r librecad.pro"
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'unix/librecad', "#{CREW_DEST_PREFIX}/bin/librecad", mode: 0o755
  end
end
