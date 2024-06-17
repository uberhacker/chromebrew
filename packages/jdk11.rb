require 'package'
require 'uri'

class Jdk11 < Package
  description 'The Oracle JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java'
  @_ver = '11.0.16.1'
  version "#{@_ver}-1"
  license 'Oracle-BCLA-JavaSE'
  compatibility 'x86_64'

  source_url File.join('file://', HOME, 'Downloads', "jdk-#{@_ver}_linux-x64_bin.tar.gz")
  source_sha256 '4edc62ebb4359b276ea33abfd9a54bacb218b8f972603c20be9e415b8a59012c'

  no_compile_needed
  no_patchelf

  def self.preflight
    jdk_exec = File.join(CREW_PREFIX, 'bin', 'java')

    if File.exist?(jdk_exec)
      jdk_ver_str   = `#{jdk_exec} -version 2>&1`
      jdk_ver       = jdk_ver_str[/version "(.+?)"/, 1]
      jdk_major_ver = jdk_ver.match?(/^1.8/) ? '8' : jdk_ver.partition('.')[0]

      is_openjdk   = jdk_ver_str.include?('openjdk')
      pkg_branding = is_openjdk ? 'OpenJDK' : 'Oracle JDK'
      pkg_prefix   = is_openjdk ? 'openjdk' : 'jdk'

      abort <<~EOT.yellow unless jdk_major_ver == name.delete_prefix('jdk') && !is_openjdk

        #{pkg_branding} #{jdk_ver} installed.

        Run "crew remove #{pkg_prefix}#{jdk_major_ver}; crew install #{name}" to install this version of JDK
      EOT
    end

    return if File.exist?(URI(source_url).path)

    # check if we should prompt user to the archive page or download page based on #{@_ver}
    # download page only contains latest version while archive page only contains older versions

    # get latest available version
    latest_jdk_page  = 'https://www.oracle.com/java/technologies/downloads/#java11'
    is_latest_jdk    = `curl -LSs '#{latest_jdk_page}'`.include?(version)
    jdk_download_url = is_latest_jdk ? latest_jdk_page : 'https://www.oracle.com/java/technologies/javase/jdk11-archive-downloads.html'

    abort <<~EOT.orange

      Oracle now requires an account to download the JDK.

      You must login at https://login.oracle.com/mysso/signon.jsp and then visit:
      #{jdk_download_url}

      Download "jdk-#{@_ver}_linux-x64_bin.tar.gz" (Linux x64 Compressed Archive) to Chrome OS download folder to continue.
    EOT
  end

  def self.install
    jdk_dir = File.join(CREW_DEST_PREFIX, 'share', name)
    FileUtils.mkdir_p [jdk_dir, File.join(CREW_DEST_PREFIX, 'bin'), CREW_DEST_MAN_PREFIX]

    FileUtils.rm_f 'lib/src.zip'
    FileUtils.cp_r Dir['*'], jdk_dir

    Dir[File.join(jdk_dir, 'bin', '*')].each do |path|
      filename = File.basename(path)
      symlink  = File.join(CREW_DEST_PREFIX, 'bin', filename)

      FileUtils.ln_s path.sub(CREW_DEST_PREFIX, CREW_PREFIX), symlink
    end

    FileUtils.rm Dir[File.join(jdk_dir, 'man/man1/k{init,list}.1')] # conflicts with krb5 package
    FileUtils.mv Dir[File.join(jdk_dir, 'man', '*')], CREW_DEST_MAN_PREFIX
  end

  def self.postinstall
    # remove jdk archive after installed
    FileUtils.rm_f URI(source_url).path
  end
end
