class Mcp < Formula
  desc "Command-line interface for interacting with MCP (Model Context Protocol) servers"
  homepage "https://github.com/f/mcptools"
  url "https://github.com/f/mcptools/archive/refs/tags/v0.3.6.3.tar.gz"
  sha256 "d02e4518161c8c888f978fd538baa17cb0f2917f186a3a25208e85eee8818f41"
  license "MIT"

  depends_on "go" => :build

  def install
    # Use the version that Homebrew already parsed
    version_str = version.to_s.sub(/^v/, "")
    
    # Add version to ldflags
    ldflags = %W[
      -s -w
      -X main.Version=#{version_str}
    ]
    
    system "go", "build", *std_go_args(ldflags: ldflags.join(" ")), "./cmd/mcptools"
    
    # Create symlink for alternative name
    bin.install_symlink "mcp" => "mcpt"
    
    # Install templates to user's home directory
    templates_dir = "~/.mcpt/templates"
    templates_source = "./templates"

    puts "Build Path: #{buildpath}"
    puts "Home Path: #{templates_dir}"
    
    if Dir.exist?(templates_source)
      FileUtils.mkdir_p templates_dir
      FileUtils.cp_r Dir["#{templates_source}/*"], templates_dir
    end
  end

  def caveats
    <<~EOS
      MCP Tools has been installed as "mcp" and "mcpt".
      Templates have been installed to ~/.mcpt/templates/
    EOS
  end

  test do
    assert_match "MCP is a command line interface", shell_output("#{bin}/mcp --help")
  end
end
