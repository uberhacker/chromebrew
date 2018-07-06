require 'package'

class Vscode < Package
  description 'Visual Studio Code'
  homepage 'https://code.visualstudio.com/'
  version '1.25.1'
  source_url 'https://github.com/Microsoft/vscode/archive/1.25.1.tar.gz'
  source_sha256 'af95547a64647d4097c1b45902fc53f45d323f053a7558bfa42e1900621d972c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vscode-1.25.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vscode-1.25.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vscode-1.25.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vscode-1.25.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ab05a0396070853164f97630f102a352965cf93557bd82a5eb5a763e40b9e4aa',
     armv7l: 'ab05a0396070853164f97630f102a352965cf93557bd82a5eb5a763e40b9e4aa',
       i686: '5135955faabcf7b4c9c98dca493afb112991bd30ca102b13922eb3c291d4a58d',
     x86_64: '943b50857968ff88fe6e38212b025b54f1b73f8e142253c31e0dadaf705df0c2',
  })

  depends_on 'libgconf'
  depends_on 'libsecret'
  depends_on 'sommelier'
  depends_on 'yarn'

  def self.build
    system "echo '#!/bin/bash' > code"
    system "echo 'cd #{CREW_PREFIX}/share/vscode' >> code"
    system "echo 'scripts/code.sh' >> code"
    # Fix for segfault while running 'yarn'.  See https://github.com/Microsoft/vscode/issues/53634.
    system "sed -i 's, --max_old_space_size=4095,,g' package.json"
    system 'yarn'
    # Fix for /usr/lib/libpthread_nonshared.a file not found.  See https://github.com/Microsoft/node-pty/issues/209.
    system "sed -i '31d' node_modules/node-pty/binding.gyp"
    system 'yarn run compile'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/vscode"
    system "cp -r . #{CREW_DEST_PREFIX}/share/vscode"
    system "install -Dm755 code #{CREW_DEST_PREFIX}/bin/code"
  end
end
