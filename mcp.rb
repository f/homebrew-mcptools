class Mcp < Formula
  desc "Command-line interface for interacting with MCP (Model Context Protocol) servers"
  homepage "https://github.com/f/mcptools"
  url "https://github.com/f/mcptools/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "650dd7e393155399de50e07981a4267d39b91442ef871b5281b259638c27a05e"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/mcptools"
  end

  test do
    assert_match "MCP is a command line interface", shell_output("#{bin}/mcp --help")
  end
end
