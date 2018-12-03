require 'package'

class Pyqt5 < Package
  description 'PyQt is a set of Python v2 and v3 bindings for The Qt Company\'s Qt application framework'
  homepage 'https://riverbankcomputing.com/software/pyqt/intro'
  version '5.11.3'
  source_url 'https://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-5.11.3/PyQt5_gpl-5.11.3.tar.gz'
  source_sha256 'c9b57d15601d436faf35dacf8e0acefa220194829a653e771e80b189b3261073'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'
  depends_on 'qt5'

  def self.build
    system "python3 setup.py build"
  end

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
