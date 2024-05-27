require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://www.libpng.org/pub/png/libpng.html'
  version '1.6.43'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://git.code.sf.net/p/libpng/code.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea5f9f73bd232972fdbf3c6d3d14da99c03af1b6d4e547e6faf59ad7ad73c3e2',
     armv7l: 'ea5f9f73bd232972fdbf3c6d3d14da99c03af1b6d4e547e6faf59ad7ad73c3e2',
       i686: '209b1a2196ce57bf7d6fffc53ddb30825ec80278e105e07d09cc19c1ad0f6571',
     x86_64: 'cc55bf8441e29ac7bcfb0b80d7903cbb5816df85ffd052376de6396b18c80cf5'
  })

  depends_on 'zlibpkg'
  depends_on 'glibc' # R
  depends_on 'glibc_lib' # R

  gnome

  def self.build
    system "cmake \
      -B builddir -G Ninja \
      #{CREW_CMAKE_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
      -DPNG_STATIC=OFF \
      -Wno-dev"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    # Imagemagick wants a libtool file.
    @libname = name.to_s.start_with?('lib') ? name.downcase : "lib#{name.downcase}"
    @libnames = Dir["#{CREW_DEST_LIB_PREFIX}/#{@libname}.so*"]
    @libnames = Dir["#{CREW_DEST_LIB_PREFIX}/#{@libname}-*.so*"] if @libnames.empty?
    @libnames.each do |s|
      s.gsub!("#{CREW_DEST_LIB_PREFIX}/", '')
    end
    @dlname = @libnames.grep(/.so./).first
    @dlname = @libnames.grep(/.so/).first if @dlname.nil?
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
