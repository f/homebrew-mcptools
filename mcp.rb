class Mcp < Formula
  desc "Command-line interface for interacting with MCP (Model Context Protocol) servers"
  homepage "https://github.com/f/mcptools"
  url "https://github.com/f/mcptools/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "53dbdca0116b2af761841d59b4c1c92463fb431bc99a70a5052584922c37bc4c"
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
