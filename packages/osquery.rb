require 'package'

class Osquery < Package
  description 'Osquery uses basic SQL commands to leverage a relational data-model to describe a device.'
  homepage 'https://osquery.io/'
  version '3.3.2'
  source_url 'https://pkg.osquery.io/linux/osquery-3.3.2_1.linux_x86_64.tar.gz'
  source_sha256 '05b0b15bd44e6a85813dd92a567c371031938aedbcd2e64d32229a3ca0c2d509'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/osquery-3.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/osquery-3.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/osquery-3.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/osquery-3.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'eee0c73ad7be1268e92e3cefbc4e1f103f236813f5c98bfc2e76f71a0a657e64',
     armv7l: 'eee0c73ad7be1268e92e3cefbc4e1f103f236813f5c98bfc2e76f71a0a657e64',
       i686: '483a407e87fc40dad9e6a5389f0c910a38e134cc8a365b6ba1667af629caaa12',
     x86_64: '00f13441d30477c438df6a80e25d6cbf094e3d48db11b2a97c75dbd5033b5913',
  })

  def self.patch
    Dir.chdir 'usr/bin' do
      system "sed -i 's,/etc,#{CREW_PREFIX}/etc,' osqueryctl"
      system "sed -i 's,/var,#{CREW_PREFIX}/var,' osqueryctl"
      system "sed -i 's,/usr/lib,#{CREW_PREFIX}/lib,' osqueryctl"
      system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,' osqueryctl"
      system "sed -i 's,/usr/bin/osqueryd,#{CREW_PREFIX}/bin/osqueryd,' osqueryctl"
    end
  end

  def self.install
    FileUtils.mkdir_p(CREW_DEST_PREFIX)
    FileUtils.cp_r('etc', CREW_DEST_PREFIX)
    FileUtils.cp_r('var', CREW_DEST_PREFIX)
    Dir.chdir 'usr' do
      FileUtils.cp_r('bin', CREW_DEST_PREFIX)
      FileUtils.cp_r('lib', CREW_DEST_PREFIX)
      FileUtils.cp_r('share', CREW_DEST_PREFIX)
    end
  end
end
