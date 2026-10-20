class Aegis < Formula
  desc "Heuristic shell guardrail for AI agent command execution"
  homepage "https://github.com/IliasAlmerekov/aegis-shellguard"
  version "0.7.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IliasAlmerekov/aegis-shellguard/releases/download/v0.7.1/aegis-macos-aarch64", using: :nounzip
      sha256 "ac5363cf985a07e2f070c1c8c159aeb547c17bed5439a6de0a634c9e635025ab"
    else
      url "https://github.com/IliasAlmerekov/aegis-shellguard/releases/download/v0.7.1/aegis-macos-x86_64", using: :nounzip
      sha256 "2bba880f365f7c5b9a933a5d21bce0dcf24559422d8d41f64472e99dcda44a9d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IliasAlmerekov/aegis-shellguard/releases/download/v0.7.1/aegis-linux-aarch64", using: :nounzip
      sha256 "2dc8a9425b2184941484e060a5a29a33637fc02479546a3336c62d0c7c80a74a"
    else
      url "https://github.com/IliasAlmerekov/aegis-shellguard/releases/download/v0.7.1/aegis-linux-x86_64", using: :nounzip
      sha256 "57e3564a00df79c40981f354c7072623718cb852ab037356d171e9143c69af26"
    end
  end

  resource "third_party_notices" do
    url "https://github.com/IliasAlmerekov/aegis-shellguard/releases/download/v0.7.1/THIRD_PARTY_NOTICES.md"
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
