require 'package'

class Telegram < Package
  description "Telegram is a messaging app with a focus on speed and security, it's super-fast, simple and free."
  homepage 'https://telegram.org/'
  version '4.5.2'
  license 'BSD, LGPL-2+ and GPL-3-with-openssl-exception'
  compatibility 'x86_64'
  source_url 'https://github.com/telegramdesktop/tdesktop/releases/download/v4.5.2/tsetup.4.5.2.tar.xz'
  source_sha256 '36b69c8550d5f212614743bb227c0378ba54bbce1c6e3f0980ff55d7a24fe71e'

  depends_on 'mesa'

  no_compile_needed

  def self.build
    telegram = <<~EOF
      #!/bin/bash
      QT_QPA_PLATFORM=wayland-egl DISPLAY= WAYLAND_DISPLAY=wayland-0 Telegram "$@"
    EOF
    File.write('telegram', telegram)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'Telegram', "#{CREW_DEST_PREFIX}/bin/Telegram", mode: 0o755
    FileUtils.install 'telegram', "#{CREW_DEST_PREFIX}/bin/telegram", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'telegram' to get started.\n".lightblue
  end
end
