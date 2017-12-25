require 'package'

class Jarvis < Package
  description 'Personal Assistant for Linux and macOS'
  homepage 'https://github.com/sukeesh/Jarvis'
  version 'dd3f45'
  source_url 'https://github.com/sukeesh/Jarvis/archive/dd3f45ccd78fcb1cd842a735f4e377e1941108d6.tar.gz'
  source_sha256 '10dcf2b3270bc6a488093fef72fb85981429850c124d7371819d96c59a2cb819'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27'
  depends_on 'dbus_glib'

  def self.install
#system "cp setup.sh /tmp"
#abort
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share"
    system "cp -r jarviscli/ #{CREW_DEST_PREFIX}/share"
    system "sed -i '89d' setup.sh"
    system "sed -i '79d' setup.sh"
    system "sed -i '25d' setup.sh"
    system "sed -i '26d' setup.sh"
    #system "sed -i '9d' setup.sh"
    system "sed -i 's,\$PWD,#{CREW_PREFIX}/share/jarviscli,' setup.sh"
    system "sed -i 's,source \$jarvispath,source #{CREW_PREFIX},' setup.sh"
    system "sed -i 's,jarviscli/,,' setup.sh"
    system "sed -i 's,cd jarvispath,cd -,' setup.sh"
    system "sed -i 's,x86_64,#{ARCH},g' setup.sh" unless "#{ARCH}" == "x86_64"
    system "sed -i '25irm phantomjs-2.1.1-linux-i686.tar.bz2' setup.sh"
    system "sed -i '25ichmod +x phantomjs-2.1.1-linux-#{ARCH}/bin/phantomjs' setup.sh"
    system "sed -i 's,cd /usr/local/share,cd #{CREW_DEST_PREFIX}/share,' setup.sh"
    system "sed -i 's,/usr/local/bin,#{CREW_DEST_PREFIX}/bin,g' setup.sh"
    system "sed -i 's,/usr/local/share,#{CREW_PREFIX}/share,' setup.sh"
    system "sed -i 's,/usr/bin,#{CREW_DEST_PREFIX}/bin,g' setup.sh"
    system "sed -i 's,cd jarvispath,cd #{CREW_DEST_PREFIX}/share/jarviscli,' setup.sh"
    system "sed -i 's,echo \"Operating system not supported\",install_phantomjs,' setup.sh"
    system "sed -i 's,sudo ,,g' setup.sh"
    system "sed -i 's,chown root,chown #{USER},g' setup.sh"
    system "sed -i 's,requirements.txt,requirements.txt --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR},g' setup.sh"
    system "sed -i 's,pip install virtualenv,pip install virtualenv --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR},g' setup.sh"
    system "sed -i 's,^virtualenv,python #{CREW_DEST_PREFIX}/lib/python2.7/site-packages/virtualenv.py,' setup.sh"
    system "sed -i 's,dbus-python,dbus-python --build #{CREW_PREFIX}/tmp --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR},' setup.sh"
    system "sed -i '88icp -r env/ #{CREW_DEST_PREFIX}' setup.sh"
    #system "sed -i '89icd -' setup.sh"
#system "cp setup.sh /tmp"
#abort
    system "bash setup.sh"
  end
end
