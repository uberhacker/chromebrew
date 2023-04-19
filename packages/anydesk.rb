require 'package'

class Anydesk < Package
  description 'Access any device at any time. From anywhere. Always secure and fast.'
  homepage 'https://anydesk.com/en'
  version '6.2.1'
  license 'AnyDesk Terms and Conditions'
  compatibility 'x86_64'
  source_url 'https://download.anydesk.com/linux/anydesk-6.2.1-amd64.tar.gz'
  source_sha256 '96a7ded2144ecdaff381c34e49eee3275caaaac00847e91abf5e7783706c989c'

  no_compile_needed

  depends_on 'glib'
  depends_on 'cairo'
  depends_on 'pango'
  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'libxrandr'
  depends_on 'libxtst'
  depends_on 'libxfixes'
  depends_on 'libxdamage'
  depends_on 'libinput'
  depends_on 'libxrender'
  depends_on 'polkit'
  depends_on 'gtk2'
  depends_on 'sommelier'

  def self.patch
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,' anydesk.desktop"
  end

  def self.install
    FileUtils.install 'anydesk', "#{CREW_DEST_PREFIX}/bin/anydesk", mode: 0o755
    FileUtils.install 'anydesk.desktop', "#{CREW_DEST_PREFIX}/share/applications/anydesk.desktop", mode: 0o644
    FileUtils.mv 'icons/', "#{CREW_DEST_PREFIX}/share"
  end

  def self.postinstall
    puts "\nType 'anydesk' to get started.\n".lightblue
  end
end
