class Aegis < Formula
  desc "Heuristic shell guardrail for AI agent command execution"
  homepage "https://github.com/IliasAlmerekov/aegis-shellguard"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IliasAlmerekov/aegis-shellguard/releases/download/v0.8.0/aegis-macos-aarch64", using: :nounzip
      sha256 "9dd8d289cc07ca5ddb3009b0bac9034146e202a18d140e57c02ef07368c25cba"
    else
      url "https://github.com/IliasAlmerekov/aegis-shellguard/releases/download/v0.8.0/aegis-macos-x86_64", using: :nounzip
      sha256 "f24d808038521d77ed38128f29e06bd5c5f83223a7a3ce04ea8d6e8f6165deea"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IliasAlmerekov/aegis-shellguard/releases/download/v0.8.0/aegis-linux-aarch64", using: :nounzip
      sha256 "b040709f8da75f01ca86359ddbcbaff924b7c54674da6fd589d13f41900f761d"
    else
      url "https://github.com/IliasAlmerekov/aegis-shellguard/releases/download/v0.8.0/aegis-linux-x86_64", using: :nounzip
      sha256 "a8ced0423ab4f496ee837940985a2934c223537438ebd827561e2039b4a7a5a6"
    end
  end

  resource "third_party_notices" do
    url "https://github.com/IliasAlmerekov/aegis-shellguard/releases/download/v0.8.0/THIRD_PARTY_NOTICES.md"
    sha256 "396b704f097977bd1335ad502cc29be4f443a861e445511f275020af24299d59"
  end

  def install
    bin.install Dir["aegis-*"].first => "aegis"

    resource("third_party_notices").stage do
      (share/"doc/aegis").install "THIRD_PARTY_NOTICES.md"
    end
  end

  def caveats
    <<~EOS
      Homebrew installs the aegis binary and its third-party notices
      (share/doc/aegis/THIRD_PARTY_NOTICES.md).

      To install supported Claude Code and Codex hooks after installation:
        aegis install-hooks --all

      To enable shell-proxy mode for tools that launch commands through $SHELL -c:
        aegis setup-shell

      To undo shell-proxy setup:
        aegis setup-shell --remove

      Native Windows shells are not supported; use Aegis from WSL2 on Windows.
    EOS
  end

  test do
    assert_match "brew-test", shell_output("#{bin}/aegis -c 'echo brew-test'")
  end
end
