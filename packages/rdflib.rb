require 'package'

class Rdflib < Package
  description 'RDFLib is a Python library for working with RDF, a simple yet powerful language for representing information.'
  homepage 'http://librdf.org/'
  version '4.2.2'
  source_url 'https://github.com/RDFLib/rdflib/archive/4.2.2.tar.gz'
  source_sha256 'a362926f77624a8abfb93042c28607f49445d003792d5271cd07f0610ab16033'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27'

  def self.install
    system "pip install rdflib==4.2.2 -I --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
