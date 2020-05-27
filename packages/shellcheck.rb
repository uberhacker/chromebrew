require 'package'

class Shellcheck < Package
  description 'A static analysis tool for shell scripts'
  homepage 'https://www.shellcheck.net/'
  version '0.7.1'
  #compatibility 'all'
  source_url 'https://github.com/koalaman/shellcheck/archive/v0.7.1.tar.gz'
  source_sha256 '50a219bde5c16fc0a40e2e3725b6c192ff589bc8a2569c32b62dcaece0495896'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'stack' => :build
  depends_on 'pandoc' => :build

  def self.build
    system 'stack build'
    system 'pandoc -s -f markdown-smart -t man shellcheck.1.md -o shellcheck.1'
  end

  def self.install
    system "stack install --local-bin-path #{CREW_DEST_PREFIX}/bin"
    system "install -Dm644 shellcheck.1 #{CREW_DEST_MAN_PREFIX}/man1/shellcheck.1"
  end
end
