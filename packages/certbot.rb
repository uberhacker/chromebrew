require 'package'

class Certbot < Package
  description 'Automatically enable HTTPS on your website with EFF\'s Certbot'
  homepage 'https://certbot.eff.org/'
  version '0.30.2'
  source_url 'https://github.com/certbot/certbot/archive/v0.30.2.tar.gz'
  source_sha256 '4c411b7d60752259ee9a2d69935a3045ee94ba725febdb1f5f62ed537935fabe'

  depends_on 'augeas'
  depends_on 'six'

  def self.build
    system "echo '#!/bin/bash' > certbot.sh"
    system "echo 'certbot-bin --config-dir=#{CREW_PREFIX}/etc --logs-dir=#{CREW_PREFIX}/var/log --work-dir=.' >> certbot.sh"
  end

  def self.install
    system "pip3 install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX} -r local-oldest-requirements.txt"
    system "pip3 install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX} -r readthedocs.org.requirements.txt"
    system "python3 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
    system "mv #{CREW_DEST_PREFIX}/bin/certbot #{CREW_DEST_PREFIX}/bin/certbot-bin"
    system "install -Dm755 certbot.sh #{CREW_DEST_PREFIX}/bin/certbot"
    system "install -Dm755 certbot-auto #{CREW_DEST_PREFIX}/bin/certbot-auto"
    system "install -Dm755 letsencrypt-auto #{CREW_DEST_PREFIX}/bin/letsencrypt-auto"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/var/log"
    system "touch #{CREW_DEST_PREFIX}/var/log/letsencrypt.log"
  end
end
