class Mcp < Formula
  desc "Command-line interface for interacting with MCP (Model Context Protocol) servers"
  homepage "https://github.com/f/mcptools"
  url "https://github.com/f/mcptools/archive/refs/tags/v0.3.6.2.tar.gz"
  sha256 "3a38ab65e989db827a83e21423cab909414e6042c84bd7812a24037008130d31"
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
    system "make", "install-templates"
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
