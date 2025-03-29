class Mcp < Formula
  desc "Command-line interface for interacting with MCP (Model Context Protocol) servers"
  homepage "https://github.com/f/mcptools"
  url "https://github.com/f/mcptools/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "37517c9f181c8965ab3e2b8fcb48d8db6b62ae726b90a86572019d2c3e54d570"
  license "MIT"

  depends_on "go" => :build

  def install
    # Extract version from URL (v0.2.0)
    version_str = url.to_s.match(/\/v(\d+\.\d+\.\d+)\.tar\.gz/)[0]
    version_str = version_str.sub("/v", "").sub(".tar.gz", "")
    
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
