require 'package'

class Libreoffice < Package
  description 'LibreOffice is a powerful office suite - its clean interface and feature-rich tools help you unleash your creativity and enhance your productivity.'
  homepage 'https://www.libreoffice.org/'
  version '6.1.3.2'
  source_url 'https://download.documentfoundation.org/libreoffice/src/6.1.3/libreoffice-6.1.3.2.tar.xz'
  source_sha256 'd46f38f6c48c6d2338fb97c6d0fae9b43802f9849b50817b3bcf9910f1708f44'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ant'
  depends_on 'boost'
  depends_on 'cppunit'
  depends_on 'cups'
  depends_on 'curl'
  depends_on 'dbus_glib'
  depends_on 'glm'
  depends_on 'gst_plugins_base'
  depends_on 'gtk2'
  depends_on 'gtk3'
  depends_on 'hunspell'
  depends_on 'lcms'
  depends_on 'libatomic_ops'
  depends_on 'openldap'
  depends_on 'sane_backends'
  depends_on 'unixodbc'
  depends_on 'sommelier'

  def self.build
    system './autogen.sh',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-junit',
           #'--with-system-altlinuxhyph',
           #'--with-system-apache-commons'
           '--with-system-apr',
           #'--with-system-bluez',
           '--with-system-boost',
           '--with-system-bzip2',
           '--with-system-cairo',
           #'--with-system-clucene',
           #'--with-system-coinmp',
           #'--with-system-cppunit',
           '--with-system-curl',
           '--with-system-epoxy',
           '--with-system-expat',
           #'--with-system-glm',
           #'--with-system-gpgmepp',
           #'--with-system-graphite',
           #'--with-system-harfbuzz',
           '--with-system-headers',
           '--with-system-hunspell',
           '--with-system-icu',
           '--with-system-icu-for-build=yes',
           '--with-system-jpeg',
           '--with-system-lcms2',
           #'--with-system-libabw',
           '--with-system-libatomic_ops',
           #'--with-system-libcdr',
           #'--with-system-libcmis',
           #'--with-system-libebook',
           #'--with-system-libeot',
           #'--with-system-libepubgen',
           #'--with-system-libetonyek',
           #'--with-system-libexttextcat',
           #'--with-system-libfreehand',
           #'--with-system-liblangtag'
           #'--with-system-libmspub',
           #'--with-system-libmwaw',
           #'--with-system-libnumbertext',
           #'--with-system-libodfgen',
           #'--with-system-libpagemaker',
           '--with-system-libpng',
           #'--with-system-libqxp',
           #'--with-system-librevenge',
           #'--with-system-libs',
           #'--with-system-libstaroffice',
           #'--with-system-libvisio',
           #'--with-system-libwpd',
           #'--with-system-libwpg',
           #'--with-system-libwps',
           '--with-system-libxml',
           #'--with-system-libzmf',
           #'--with-system-lpsolve',
           #'--with-system-mdds',
           #'--with-system-mythes',
           #'--with-system-neon',
           #'--with-system-nss',
           '--with-system-odbc',
           '--with-system-openldap',
           '--with-system-openssl',
           #'--with-system-orcus',
           '--with-system-poppler',
           #'--with-system-redland',
           '--with-system-sane',
           '--with-system-serf',
           '--with-system-ucpp',
           #'--with-system-xmlsec',
           '--with-system-zlib',
           '--with-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
