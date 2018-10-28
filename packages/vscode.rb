require 'package'

class Vscode < Package
  description 'Visual Studio Code'
  homepage 'https://code.visualstudio.com/'
  version '1.28.0'
  source_url 'https://raw.githubusercontent.com/Microsoft/vscode/1.28.0/README.md'
  source_sha256 'd06715446bc74818ec71962b35e409f026a0c06e9106084b08926bb22ef0c9d0'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libgconf'
  depends_on 'libsecret'
  depends_on 'sommelier'
  depends_on 'yarn'

  def self.build
    vscode_version='1.28.0'
    case ARCH
    when 'aarch64'
      build_arch='arm64'
    when 'armv7l'
      build_arch='arm'
    when 'i686'
      build_arch='ia32'
    when 'x86_64'
      build_arch='x64'
    else
      build_arch='unknown'
    end
    system "yarn add global gulp gulp-watch"
    system "curl -L https://github.com/microsoft/vscode/archive/#{vscode_version}.tar.gz > vscode.tar.gz"
    FileUtils.mkdir 'vscode'
    system "tar --strip-components=1 -C vscode -xf vscode.tar.gz"
    system "curl -L https://go.microsoft.com/fwlink/?LinkID=620884 > vscode-official.tar.gz"
    system "tar --strip-components=1 -xf vscode-official.tar.gz VSCode-linux-x64/resources/app/resources/linux/code.png VSCode-linux-x64/resources/app/product.json"
    Dir.chdir 'vscode' do
      system "cp -rv ../resources/app/* ."
      system "sed -i 's/.*darwinCredits.*//' product.json"
      system "sed -i 's/.*electronRepository.*//' product.json"
      # Fix for segfault while running 'yarn'.  See https://github.com/Microsoft/vscode/issues/53634.
      system "sed -i 's, --max_old_space_size=4095,,g' package.json"
      system 'yarn'
      # Fix for /usr/lib/libpthread_nonshared.a file not found.  See https://github.com/Microsoft/node-pty/issues/209.
      system "sed -i '31d' node_modules/node-pty/binding.gyp"
      system "yarn run gulp vscode-linux-#{build_arch}-min"
      system "echo '#!/bin/bash' > code"
      system "echo 'cd #{CREW_PREFIX}/share/vscode' >> code"
      system "echo 'scripts/code.sh' >> code"
    end
  end

  def self.install
    Dir.chdir 'vscode' do
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/vscode"
      system "cp -r . #{CREW_DEST_PREFIX}/share/vscode"
      system "install -Dm755 code #{CREW_DEST_PREFIX}/bin/code"
    end
  end
end
