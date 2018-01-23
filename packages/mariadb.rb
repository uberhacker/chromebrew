require 'package'

class Mariadb < Package
  description "MariaDB Server is one of the most popular database servers in the world. It's made by the original developers of MySQL and guaranteed to stay open source."
  homepage 'https://mariadb.org/'
  version '10.2.12'
  source_url 'https://downloads.mariadb.org/interstitial/mariadb-10.2.12/source/mariadb-10.2.12.tar.gz'
  source_sha256 '2ab22d7fbacfabc30fe18f71a8afb173250074502d889457e3cde2e203d341ec'

  depends_on 'acl'
  depends_on 'glibc223'
  depends_on 'gnutls'
  depends_on 'jemalloc'
  depends_on 'libaio'
  depends_on 'libarchive'
  depends_on 'libevent'
  depends_on 'ncurses'
  depends_on 'openssl'
  depends_on 'zlibpkg'

  def self.build
    #system "BUILD/autorun.sh"
    #system "BUILD/SETUP.sh"
    #system "touch libmariadb/CMakeLists.txt"
    #system "./configure --prefix=#{CREW_PREFIX}/mysql --enable-assembler \
    #--with-extra-charsets=complex  --enable-thread-safe-client  --with-big-tables \
    #--with-plugin-maria --with-aria-tmp-tables --without-plugin-innodb_plugin \
    #--with-mysqld-ldflags=-static --with-client-ldflags=-static --with-readline \
    #--with-ssl --with-plugins=max-no-ndb --with-embedded-server --with-libevent \
    #--with-mysqld-ldflags=-all-static  --with-client-ldflags=-all-static \
    #--with-zlib-dir=bundled --enable-local-infile"
    system "rm -f CMakeCache.txt"
    system "cmake . \
	    -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}/mysql \
            -DINSTALL_LIBDIR=#{ARCH_LIB} \
            -DCURSES_FORM_LIBRARY=#{CREW_LIB_PREFIX}/libform.so \
            -DCURSES_NCURSES_LIBRARY=#{CREW_LIB_PREFIX}/libncurses.so \
            -DOPENSSL_SSL_LIBRARY=#{CREW_LIB_PREFIX}/libssl.so \
            -DOPENSSL_CRYPTO_LIBRARY=#{CREW_LIB_PREFIX}/libcrypto.so \
            -DZLIB_LIBRARY_RELEASE=#{CREW_LIB_PREFIX}/libz.so \
            -DBUILD_CONFIG=mysql_release CMakeCache.txt"
    system "cp -r CMakeFiles/ #{CREW_PREFIX}/tmp"
    system "make all"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    #system "mkdir -p #{CREW_DEST_PREFIX}"
    #system "cp -r . #{CREW_DEST_PREFIX}"
    #system "ln -s #{CREW_DEST_PREFIX}/mariadb-10.2.12-linux-#{ARCH} #{CREW_DEST_PREFIX}/mysql"
    #system "./scripts/mysql_install_db --user=#{USER} --basedir=#{CREW_DEST_PREFIX}/mysql --defaults-file=#{CREW_DEST_PREFIX}/mysql/my.cnf"
    #system "./scripts/mysql_install_db --user=#{USER} --basedir=#{CREW_DEST_PREFIX}/mysql"
  end
end
