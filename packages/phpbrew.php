require 'package'

class Phpbrew < Package
  description 'phpbrew builds and installs multiple version php(s) in your $HOME directory.'
  homepage 'https://github.com/phpbrew/phpbrew'
  version '1.23.1'
  source_url 'https://github.com/phpbrew/phpbrew/blob/1.23.1/phpbrew'
  source_sha256 '49eaf48443c86b78b96b0b7b71d9d0ced39ed6f89145d18267fa1859c5a7c36a'

  def self.install
    system "install -Dm755 phpbrew #{CREW_DEST_PREFIX}/bin/phpbrew"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/phpbrew"
  end

  def self.postinstall
    system "phpbrew init --root=#{CREW_PREFIX}/share/phpbrew"
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts
    puts "Add these lines to your .bashrc or .zshrc file:".lightblue
    puts "echo '[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
    puts "For fish shell users, add following lines to your ~/.config/fish/config.fish file:".lightblue
    puts "echo 'source ~/.phpbrew/phpbrew.fish' >> ~/.config/fish/config.fish && source ~/.config/fish/config.fish".lightblue
    puts
    puts "To install any version of php, execute:".lightblue
    puts "phpbrew install 7.3.1 +default".lightblue
    puts "Replace 7.3.1 with the version you need.".lightblue
    puts
    puts "To uninstall, execute the following:".lightblue
    puts "crew remove phpbrew".lightblue
    puts "rm -rf #{CREW_PREFIX}/share/phpbrew".lightblue
    puts
    puts "For more information, see https://github.com/phpbrew/phpbrew#basic-usage.".lightblue
    puts
  end
end
