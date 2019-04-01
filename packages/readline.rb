require 'package'

class Readline < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  version '6.3-8.0'

  if ARGV[0] == 'install'
    ver = ''
    ver = '6' if File.Exists? "#{CREW_LIB_PREFIX}/libreadline.so.6"
    ver = '7' if File.Exists? "#{CREW_LIB_PREFIX}/libreadline.so.7"
    ver = '8' if File.Exists? "#{CREW_LIB_PREFIX}/libreadline.so.8"
    abort "readline version #{ver} already installed.".lightgreen unless "#{ver}" == ""
    puts
    puts "Enter the readline version to install:"
    puts "6 = readline 6.3"
    puts "7 = readline 7.0"
    puts "8 = readline 8.0"
    puts "0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '6'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-2-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-2-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-2-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-2-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '83218261c09120972d87c9710a251e22e1456fc19bd6bf4d0d111e445f9496a7',
           armv7l: '83218261c09120972d87c9710a251e22e1456fc19bd6bf4d0d111e445f9496a7',
             i686: 'cae31632449c2e5530f02d74377d2d61772bf4793fb8aea14e00550f7c9f18da',
           x86_64: '0b6095eabde0211a03f4af71e1497ba06cad8c20a075425d1fae69f0948ce27a',
        })
        break
      when '7'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/readline7-7.0p5-1-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/readline7-7.0p5-1-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/readline7-7.0p5-1-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/readline7-7.0p5-1-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '9c301f9f269c3ffb8962939d2e6b6d6fd0d62db273440f19e090504f53d2211e',
           armv7l: '9c301f9f269c3ffb8962939d2e6b6d6fd0d62db273440f19e090504f53d2211e',
             i686: '3686aaf9c93d69f3ec4ada1acd625f20c16b2165ffe92df1998a6f124d8e4ff0',
           x86_64: '4e6e13afa0d02688b3431efdbed4f89dc90d8d504adb97eea35fbfbb5ed17688',
        })
        break
      when '8'
        binary_url ({
        })
        binary_sha256 ({
        })
        break
      when '0'
        abort
        break
      else
        puts "Please select from one of the options or enter 0 to cancel."
      end
    end
  end
end
