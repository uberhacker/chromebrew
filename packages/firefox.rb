require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '61.0.2'
  source_url 'https://www.mozilla.org/en-US/firefox/61.0.2/releasenotes/index.html'
  source_sha256 '7db7dd912d9c8c3e48aec0cb20b53ec6b79d448d9a0b1d1e48dea569c8555c01'

  binary_url ({
    aarch64: '',
     armv7l: '',
       i686: 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/61.0.2/linux-i686/en-US/firefox-61.0.2.tar.bz2',
     x86_64: 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/61.0.2/linux-x86_64/en-US/firefox-61.0.2.tar.bz2',
  })
  binary_sha256 ({
    aarch64: '',
     armv7l: '',
       i686: '829c8d38b05212b82e1c340c1467ea3c2690184cd319d682b865b97f8d4b2da6',
     x86_64: '3a729ddcb1e0f5d63933177a35177ac6172f12edbf9fbbbf45305f49333608de',
  })

  depends_on 'mercurial' => :build
  depends_on 'python27' => :build

  def self.build
    # For detailed build instructions, see https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Simple_Firefox_build/Linux_and_MacOS_build_preparation.
    #FileUtils.mkdir 'src'
    #Dir.chdir 'src' do
    #  system 'wget https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py'
    #  abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('bootstrap.py') ) == '93d8cb10d31e6f6faaca1ae76b2c0d77f0d6d7398cd5bb7cb12ecda4b78bd695'
    #end
    system 'hg clone https://hg.mozilla.org/mozilla-central'
    Dir.chdir "mozilla-central" do
      system './mach build'
    end
  end

  def self.install
    #Dir.chdir 'src' do
    #  system "python bootstrap.py"
    #end
  end
end
