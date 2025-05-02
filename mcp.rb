class Mcp < Formula
  desc "Command-line interface for interacting with MCP (Model Context Protocol) servers"
  homepage "https://github.com/f/mcptools"
  url "https://github.com/f/mcptools/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "MIT"

  depends_on "go" => :build

  def install
    # Use the version that Homebrew already parsed
    version_str = version.to_s.sub(/^v/, "")
    
    # Add version to ldflags
    ldflags = %W[
      -s -w
      -X main.Version=#{version_str}
      -X main.TemplatesPath=#{prefix}/templates
    ]
    
    system "go", "build", *std_go_args(ldflags: ldflags.join(" ")), "./cmd/mcptools"

    prefix.install Dir["templates"]
    
    # Create symlink for alternative name
    bin.install_symlink "mcp" => "mcpt"
  end

  test do
    assert_match "MCP is a command line interface", shell_output("#{bin}/mcp --help")
  end
end
