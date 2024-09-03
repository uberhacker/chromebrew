require 'package'

class Cursor < Package
  description 'The AI Code Editor'
  homepage 'https://www.cursor.com/'
  version '0.40.3'
  license 'Cursor EULA (See https://www.cursor.com/license.txt)'
  compatibility 'x86_64'
  source_url 'https://downloader.cursor.sh/linux/appImage/x64'
  source_sha256 'a85f6fa9fbc64460c9e1d671633bd115d20ac6dea27a2417ba93e23b3905e2eb'

  depends_on 'gtk3'
  depends_on 'sommelier'

  no_shrink
  no_compile_needed

  def self.install
    FileUtils.install 'x64', "#{CREW_DEST_PREFIX}/bin/cursor", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'cursor' to get started.\n"
  end
end
