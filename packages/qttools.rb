require 'package'

class Qttools < Package
  description 'Qt Tools'
  homepage 'https://code.qt.io/cgit/qt/qttools'
  version '5.15.2'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'qtbase'
  depends_on 'libtinfo'

  def self.build
    system "git clone --branch v#{version} --depth 1 git://code.qt.io/qt/qttools.git"
    Dir.chdir 'qttools' do
      system 'qmake && make'
    end
  end

  def self.install
    Dir.chdir 'qttools' do
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Qt-5"
      FileUtils.cp_r Dir.glob('lib/*'), CREW_DEST_LIB_PREFIX
      FileUtils.cp_r 'bin', "#{CREW_DEST_PREFIX}/share/Qt-5"
      FileUtils.cp_r 'examples', "#{CREW_DEST_PREFIX}/share/Qt-5"
      FileUtils.cp_r 'include', "#{CREW_DEST_PREFIX}/share/Qt-5"
      FileUtils.cp_r 'mkspecs', "#{CREW_DEST_PREFIX}/share/Qt-5"
      FileUtils.cp_r 'src/linguist/phrasebooks', "#{CREW_DEST_PREFIX}/share/Qt-5"
      Dir.chdir "#{CREW_DEST_PREFIX}/share/Qt-5/bin" do
        system "find . -type f -exec ln -s #{CREW_PREFIX}/share/Qt-5/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
      end
    end
  end
end
