require 'package'

class Raptor < Package
  description 'Raptor is a free software / Open Source C library that provides a set of parsers and serializers that generate Resource Description Framework (RDF) triples by parsing syntaxes or serialize the triples into a syntax.'
  homepage 'http://librdf.org/raptor/'
  version '2.0.15'
  source_url 'http://download.librdf.org/source/raptor2-2.0.15.tar.gz'
  source_sha256 'ada7f0ba54787b33485d090d3d2680533520cd4426d2f7fb4782dd4a6a1480ed'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
