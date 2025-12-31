class AgentBridge < Formula
  desc "Control CLI agents (like Claude Code) remotely from iOS"
  homepage "https://github.com/malatenszki/agent-bridge"
  url "https://github.com/malatenszki/agent-bridge.git", tag: "v1.2.1"
  license "MIT"

  depends_on "tmux"
  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/agent-bridge"
  end

  def caveats
    <<~EOS
      To start agent-bridge:
        agent-bridge

      Then scan the QR code with the Agent Bridge iOS app.

      Make sure your iPhone is on the same WiFi network as this Mac.

      If build fails with 'memory' file not found, run:
        sudo xcode-select --reset
    EOS
  end

  test do
    assert_match "Agent Bridge", shell_output("#{bin}/agent-bridge --help 2>&1", 1)
  end
end
