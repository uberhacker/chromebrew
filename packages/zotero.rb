require 'package'

class Zotero < Package
  description 'Zotero is a free, easy-to-use tool to help you collect, organize, annotate, cite, and share research.'
  homepage 'https://www.zotero.org/'
  version '7.0.8'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url "https://download.zotero.org/client/release/#{version}/Zotero-#{version}_linux-x86_64.tar.bz2"
  source_sha256 'bad8aa4b8fcfbe59107aca933b212f8fcbb05b5b03c65aa39e1bfa1857d8e6e9'

  depends_on 'dbus_glib'
  depends_on 'gtk3'

  gnome
  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/zotero"
    FileUtils.mv %w[fonts icons], "#{CREW_DEST_PREFIX}/share"
    FileUtils.install 'zotero.desktop', "#{CREW_DEST_PREFIX}/share/applications/zotero.desktop", mode: 0o644
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/zotero"
    FileUtils.ln_s "#{CREW_PREFIX}/share/zotero/zotero", "#{CREW_DEST_PREFIX}/bin/zotero"
  end

  def self.postinstall
    ExitMessage.add "\nType 'zotero' to get started.\n"
  end
end
