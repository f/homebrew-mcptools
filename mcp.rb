class Mcp < Formula
  desc "Command-line interface for interacting with MCP (Model Context Protocol) servers"
  homepage "https://github.com/f/mcptools"
  url "https://github.com/f/mcptools/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "4d5d959cc469482335669189003e5f58ce99dd9d134b6fcec08496cfa155256d"
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
