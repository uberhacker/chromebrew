require 'package'

class X86box < Package
  description 'Emulator of x86-based machines based on PCem.'
  homepage 'https://github.com/86Box/86Box'
  version '4.2.1'
  license 'GPL-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/86Box/86Box/releases/download/v#{version}/86Box-NDR-Linux-arm32-b6130.AppImage",
     armv7l: "https://github.com/86Box/86Box/releases/download/v#{version}/86Box-NDR-Linux-arm32-b6130.AppImage",
       i686: "https://github.com/86Box/86Box/releases/download/v#{version}/86Box-Linux-x86-b6130.AppImage",
     x86_64: "https://github.com/86Box/86Box/releases/download/v#{version}/86Box-Linux-x86_64-b6130.AppImage"
  })
  source_sha256({
    aarch64: '7ebf5517663195114ca56a85d79c66476c214082b4c4369d29b1881a4aefdd45',
     armv7l: '7ebf5517663195114ca56a85d79c66476c214082b4c4369d29b1881a4aefdd45',
       i686: 'ceeba6e7a30f912b3147d9e7d7a5e64e2fc10a2b60064b94a65aa6b57e6ee9c4',
     x86_64: 'e049a364bc50307f7db9703960de7b6b1e3d35a7804800e98ce34ff9ba447e53'
  })

  no_compile_needed
  no_shrink
  print_source_bashrc

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    File.write '86box.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/86box
      ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/86box"
    FileUtils.install '86box.sh', "#{CREW_DEST_PREFIX}/bin/86box", mode: 0o755
    FileUtils.install 'AppRun.env', "#{CREW_DEST_PREFIX}/etc/env.d/x86box.env", mode: 0o644
    FileUtils.mv Dir['usr/share/*'], "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/86box"
  end

  def self.postinstall
    ExitMessage.add "\nType '86box' to get started.\n"
  end
end
