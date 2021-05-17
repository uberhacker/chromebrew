require 'package'

class Balena_etcher < Package
  description 'Flash OS images to SD cards & USB drives, safely and easily.'
  homepage 'https://www.balena.io/etcher/'
  @_ver = '1.5.120'
  version @_ver
  license 'Apache-2.0'
  compatibility 'x86_64, i686'
  case ARCH
  when 'x86_64'
    source_url "https://github.com/balena-io/etcher/releases/download/v#{@_ver}/balena-etcher-electron_#{@_ver}_amd64.deb"
    source_sha256 '9c6214392e0bcdf7976a6713d2e8a06d0b159142c7d91ddb962d030c4a60de7b'
  when 'i686'
    source_url "https://github.com/balena-io/etcher/releases/download/v#{@_ver}/balena-etcher-electron_#{@_ver}_i386.deb"
    source_sha256 '71d3c41e5a7423ebce845f1baef18f12ed84de01bfd0a19f3a94b9d3e39a7377'
  end

  depends_on 'gtk2'
  depends_on 'freetype'
  depends_on 'cairo'
  depends_on 'xzutils'
  depends_on 'libnotify'
  depends_on 'nspr'
  depends_on 'libgconf'
  depends_on 'alien' => :build
  depends_on 'libxss'
  depends_on 'xhost'
  depends_on 'sommelier'

  def self.build
    Dir.chdir('../') do
      system "alien -tc balena-etcher-electron_#{@_ver}_*.deb"
      system "tar xf balena-etcher-electron-#{@_ver}.tgz"
    end
    system "cat <<'EOF'> balena-etcher
#!/bin/sh
xhost si:localuser:root
sudo -E LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} balena-etcher-electron
EOF"
  end

  def self.install
    ENV['CREW_NOT_STRIP'] = '1'
    Dir.chdir('../') do
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
      FileUtils.mv 'usr/share/', CREW_DEST_PREFIX
      FileUtils.mv 'opt/', CREW_DEST_PREFIX
      FileUtils.ln_s "#{CREW_PREFIX}/opt/balenaEtcher/balena-etcher-electron", "#{CREW_DEST_PREFIX}/bin/balena-etcher-electron"
    end
    FileUtils.install 'balena-etcher', "#{CREW_DEST_PREFIX}/bin/balena-etcher", mode: 0755
  end

  def self.postinstall
    puts
    puts "To get started, type 'balena-etcher'.".lightblue
    puts
  end
end
