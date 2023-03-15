require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  @_ver = '2.76.0'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/glib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.76.0_armv7l/glib-2.76.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.76.0_armv7l/glib-2.76.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.76.0_i686/glib-2.76.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glib/2.76.0_x86_64/glib-2.76.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4cf42a0a1cafa5e90770767b47ae1c017b2d5263e843cf2b764f1c62140f308a',
     armv7l: '4cf42a0a1cafa5e90770767b47ae1c017b2d5263e843cf2b764f1c62140f308a',
       i686: '98ac44357d9dc5e09dac89451de90e5abb18e3a33d7a6474f7cb926b974b1bbc',
     x86_64: 'dec2b47aa6487b723e87859a58d77e8c7242a96e56a3d3b597d2b53f2f62b131'
  })

  depends_on 'elfutils' # R
  depends_on 'libffi' # R
  depends_on 'pcre' # R
  depends_on 'py3_pygments' => :build
  depends_on 'shared_mime_info' # L
  depends_on 'util_linux' # R
  depends_on 'zlibpkg' # R
  depends_on 'pcre2' # R

  no_strip if %w[aarch64 armv7l].include? ARCH
  gnome

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS.gsub('strip=true', 'strip=false')} \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman=false \
    -Dtests=false \
    builddir"
    system 'meson configure builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    # Create libtool file. Needed by handbrake build.
    return if File.file?("#{CREW_DEST_LIB_PREFIX}/#{@libname}.la")

    @libname = name.to_s.start_with?('lib') ? name.downcase : "lib#{name.downcase}"
    @libnames = Dir["#{CREW_DEST_LIB_PREFIX}/#{@libname}.so*"]
    @libnames = Dir["#{CREW_DEST_LIB_PREFIX}/#{@libname}-*.so*"] if @libnames.empty?
    @libnames.each do |s|
      s.gsub!("#{CREW_DEST_LIB_PREFIX}/", '')
    end
    @dlname = @libnames.grep(/.so./).first
    @libname = @dlname.gsub(/.so.\d+/, '')
    @longest_libname = @libnames.max_by(&:length)
    @libvars = @longest_libname.rpartition('.so.')[2].split('.')

    @libtool_file = <<~LIBTOOLEOF
      # #{@libname}.la - a libtool library file
      # Generated by libtool (GNU libtool) (Created by Chromebrew)
      #
      # Please DO NOT delete this file!
      # It is necessary for linking the library.

      # The name that we can dlopen(3).
      dlname='#{@dlname}'

      # Names of this library.
      library_names='#{@libnames.reverse.join(' ')}'

      # The name of the static archive.
      old_library='#{@libname}.a'

      # Linker flags that cannot go in dependency_libs.
      inherited_linker_flags=''

      # Libraries that this one depends upon.
      dependency_libs=''

      # Names of additional weak libraries provided by this library
      weak_library_names=''

      # Version information for #{name}.
      current=#{@libvars[1]}
      age=#{@libvars[1]}
      revision=#{@libvars[2]}

      # Is this an already installed library?
      installed=yes

      # Should we warn about portability when linking against -modules?
      shouldnotlink=no

      # Files to dlopen/dlpreopen
      dlopen=''
      dlpreopen=''

      # Directory that this library needs to be installed in:
      libdir='#{CREW_LIB_PREFIX}'
    LIBTOOLEOF
    File.write("#{CREW_DEST_LIB_PREFIX}/#{@libname}.la", @libtool_file)
  end
end
