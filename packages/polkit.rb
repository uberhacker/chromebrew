require 'package'

class Polkit < Package
  description 'polkit is a toolkit for defining and handling authorizations.'
  homepage 'https://gitlab.freedesktop.org/polkit/polkit'
  version '0.116'
  source_url 'https://gitlab.freedesktop.org/polkit/polkit/-/archive/0.116/polkit-0.116.tar.bz2'
  source_sha256 '1828e550a79909e4864fbb04d502b9556b7719ce990e6e89a76f50c2fdf3b6a3'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'elogind'
  depends_on 'gtk_doc'
  depends_on 'mozjs60'

  def self.patch
    # Fix /usr/bin/perl: bad interpreter: No such file or directory
    system "for f in \$(grep -rl '/usr/bin/perl'); do sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' \$f; done"
  end

  def self.build
    system './autogen.sh'
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           '--disable-maintenance-mode',
           '--with-os-type=chromeos',
           '--disable-gtk-doc-html',
           '--disable-man-pages',
           '--enable-examples'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system "chmod 700 #{CREW_PREFIX}/etc/polkit-1/rules.d"
    system "sudo chown root:root #{CREW_PREFIX}/bin/pkexec"
    system "sudo chown root:root #{CREW_PREFIX}/lib/polkit-1/polkit-agent-helper-1"
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "sudo chmod 4755 #{CREW_PREFIX}/bin/pkexec".lightblue
    puts "sudo chmod 4755 #{CREW_PREFIX}/lib/polkit-1/polkit-agent-helper-1".lightblue
    puts
  end
end
