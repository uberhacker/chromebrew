require 'package'

class Telegram < Package
  description "Telegram is a messaging app with a focus on speed and security, it's super-fast, simple and free."
  homepage 'https://telegram.org/'
  version '4.13.1'
  license 'BSD, LGPL-2+ and GPL-3-with-openssl-exception'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url 'https://updates.tdesktop.com/tlinux/tsetup.4.13.1.tar.xz'
  source_sha256 '237b72d36cb1e0850fb613cde10b8f67df5ea0ae2fecf27279d8d0f84c4afac2'

  depends_on 'mesa'

  no_compile_needed
  no_shrink

  def self.build
    telegram = <<~EOF
      #!/bin/bash
      DISPLAY=
      GDK_BACKEND=wayland
      WAYLAND_DISPLAY=wayland-0
      QT_QPA_PLATFORM=wayland-egl
      Telegram "$@"
    EOF
    File.write('telegram', telegram)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'Telegram', "#{CREW_DEST_PREFIX}/bin/Telegram", mode: 0o755
    FileUtils.install 'telegram', "#{CREW_DEST_PREFIX}/bin/telegram", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'telegram' to get started.\n".lightblue
  end
end
