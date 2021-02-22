require 'package'

class Wxsqlite < Package
  description 'SQLite3 database wrapper for wxWidgets'
  homepage 'https://utelle.github.io/wxsqlite3/docs/html/index.html'
  version '4.6.4'
  compatibility 'all'
  source_url 'https://github.com/utelle/wxsqlite3/archive/v4.6.4.tar.gz'
  source_sha256 '0c9e855a56b4c81e58c4fc3f0475c7848a274b3bbc73b86a0897d46b7986be13'

  binary_url ({
    x86_64: 'file:///home/chronos/user/chromebrew/release/x86_64/wxsqlite-4.6.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256 ({
    x86_64: '764f70eb0fa89e5b5f9454fe03483e6dc1a2e17b3785aa4372add20684744ba6'
  })

  depends_on 'gtk3'
  depends_on 'sqlite'
  depends_on 'wxwidgets'

  def self.build
    system 'autoreconf -i'
    Dir.mkdir '_build'
    Dir.chdir '_build' do
      system "../configure #{CREW_OPTIONS}"
      system 'make'
    end
  end

  def self.install
    Dir.chdir '_build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
