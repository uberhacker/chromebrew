require 'package'

class Specto < Package
  description 'Specto is a desktop application that will watch configurable events (such as website updates, emails, file and folder changes, system processes, etc) and then trigger notifications.'
  homepage 'http://specto.sourceforge.net/'
  version '0.4.1'
  source_url 'https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/specto/specto-0.4.1.tar.gz'
  source_sha256 'aa2415ea35f00a0bb6fc20dda56ef7c840c8971e325f87eae80f6f9cd40d8ecc'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk2'
  depends_on 'pygobject'
  depends_on 'sommelier'

  def self.build
    system 'pip install numpy'
    system 'python setup.py build'
  end

  def self.install
    system "python setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system 'pip uninstall numpy -y'
    system "pip install numpy --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
