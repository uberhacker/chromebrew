require 'package'

class Mariadb < Package
  version '10.2.12'
  case ARCH
  when 'x86_64'
    source_url 'https://downloads.mariadb.org/interstitial/mariadb-10.2.12/bintar-linux-x86_64/mariadb-10.2.12-linux-x86_64.tar.gz'
    source_sha256 '39c0d4a2cdfddadf5dc161291617365ce42a39a5d77ef7b6ddc1d7e7402fbd42'
  when 'i686'
    source_url 'https://downloads.mariadb.org/interstitial/mariadb-10.2.12/bintar-linux-x86/mariadb-10.2.12-linux-i686.tar.gz'
    source_sha256 '769a26c20d13ba13e36541795b0be74a68b0400cc0e1e8e6fd3ae2159d771740'
  end

  depends_on 'acl'
  depends_on 'glibc223'
  depends_on 'libaio'
  depends_on 'libarchive'
  depends_on 'libevent'
  depends_on 'zlibpkg'
  depends_on 'jemalloc'
  depends_on 'ncurses'
  depends_on 'openssl'

  def self.build
    #system "BUILD/autorun.sh"
    #system "BUILD/SETUP.sh"
    #system "touch libmariadb/CMakeLists.txt"
    #system "./configure --prefix=/usr/local/mysql --enable-assembler \
    #--with-extra-charsets=complex  --enable-thread-safe-client  --with-big-tables \
    #--with-plugin-maria --with-aria-tmp-tables --without-plugin-innodb_plugin \
    #--with-mysqld-ldflags=-static --with-client-ldflags=-static --with-readline \
    #--with-ssl --with-plugins=max-no-ndb --with-embedded-server --with-libevent \
    #--with-mysqld-ldflags=-all-static  --with-client-ldflags=-all-static \
    #--with-zlib-dir=bundled --enable-local-infile"
    #system "rm -f CMakeCache.txt"
    #system "cmake . -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}/mysql -DCURSES_LIBRARY=#{CREW_LIB_PREFIX}/libncurses.so -DCURSES_INCLUDE_PATH=#{CREW_PREFIX}/include -DBUILD_CONFIG=mysql_release CMakeCache.txt"
    #system "make all"
  end

  def self.install
    #system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "cp -r . #{CREW_DEST_PREFIX}"
    system "ln -s #{CREW_DEST_PREFIX}/mariadb-10.2.12-linux-#{ARCH} #{CREW_DEST_PREFIX}/mysql"
    system "./scripts/mysql_install_db --user=#{USER} --basedir=#{CREW_DEST_PREFIX}/mysql --defaults-file=#{CREW_DEST_PREFIX}/mysql/my.cnf"
  end
end
