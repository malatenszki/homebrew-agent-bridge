class AgentBridgeDaemon < Formula
  desc "Control CLI agents (like Claude Code) remotely from iOS"
  homepage "https://github.com/malatenszki/agent-bridge-daemon"
  url "https://github.com/malatenszki/agent-bridge-daemon.git", tag: "v1.0.0"
  license "MIT"

  depends_on "tmux"
  depends_on xcode: ["14.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/agent-bridge-daemon"
  end

  def caveats
    <<~EOS
      To start agent-bridge-daemon:
        agent-bridge-daemon

      Then scan the QR code with the Agent Bridge iOS app.

      Make sure your iPhone is on the same WiFi network as this Mac.
    EOS
  end

  test do
    assert_match "Agent Bridge", shell_output("#{bin}/agent-bridge-daemon --help 2>&1", 1)
  end
end
