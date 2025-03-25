class Mcp < Formula
  desc "Command-line interface for interacting with MCP (Model Context Protocol) servers"
  homepage "https://github.com/f/mcptools"
  url "https://github.com/f/mcptools/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "f2ce8ac316393e1276b839ee59e2ab39b3932755fbd2bee4f64dca084f4d23f0"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/mcptools"
  end

  test do
    assert_match "MCP is a command line interface", shell_output("#{bin}/mcp --help")
  end
end
