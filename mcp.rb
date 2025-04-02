class Mcp < Formula
  desc "Command-line interface for interacting with MCP (Model Context Protocol) servers"
  homepage "https://github.com/f/mcptools"
  url "https://github.com/f/mcptools/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "1f9656a1f50d3cb8e1e97d52a7b5a83e233f24c886f5e7ea97dc23383147d061"
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
    bin.install_symlink "mcp" => "mcpt"
  end

  test do
    assert_match "MCP is a command line interface", shell_output("#{bin}/mcp --help")
  end
end
