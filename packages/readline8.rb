require 'package'

class Readline8 < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  version '8.0'
  source_url 'https://ftpmirror.gnu.org/gnu/readline/readline-8.0.tar.gz'
  source_sha256 'e339f51971478d369f8a053a330a190781acb9864cf4c541060f12078948e461'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-static',
           '--with-curses'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
