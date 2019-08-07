require 'package'

class Rsu_client < Package
  description 'RSU-Client is a RuneScape Client Launcher written for the now Legacy client and now OldSchool.'
  homepage 'https://github.com/rsu-client/rsu-client'
  version '4.3.8'
  source_url 'https://github.com/rsu-client/rsu-client/archive/v4.3.8.tar.gz'
  source_sha256 'a84d27f2775ceef3bf0f715504ba41f3776c5374b61f9820993a26f350e4fa3d'

  depends_on 'jdk8'
  depends_on 'p7zip'
  depends_on 'wxwidgets'
  depends_on 'xdg_utils'
  depends_on 'sommelier'

  def self.patch
    Dir.chdir 'runescape' do
      system "for f in \$(grep -r /usr/bin .|egrep -v '^Binary'|egrep -o '^[^:]+');do
                sed -i 's,/usr/local,/usr,g' \${f}
              done"
      system "for f in \$(grep -r /usr/bin .|egrep -v '^Binary'|egrep -o '^[^:]+');do
                sed -i 's,/usr,#{CREW_PREFIX},g' \${f}
              done"
    end
  end

  def self.build
    system 'cpan -T install Archive::Extract exit'
  end

  def self.install
    system 'mkdir', '-p', "#{CREW_DEST_PREFIX}/share"
    system 'cp', '-a', 'runescape', "#{CREW_DEST_PREFIX}/share/"
    system 'mkdir', '-p', "#{CREW_DEST_PREFIX}/bin"
    system 'ln', '-s', "#{CREW_PREFIX}/share/runescape/runescape", "#{CREW_DEST_PREFIX}/bin/runescape"
  end
end
