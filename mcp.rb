class Mcp < Formula
  desc "Command-line interface for interacting with MCP (Model Context Protocol) servers"
  homepage "https://github.com/f/mcptools"
  url "https://github.com/f/mcptools/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "5ec5793edfa7f200489aae5cf9cec41efad9f518c3e81fff87e5723bb1be4845"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/mcptools"
  end

  test do
    assert_match "MCP is a command line interface", shell_output("#{bin}/mcp --help")
  end
end
