cask "pikapik" do
  version "1.30.13"
  sha256 "71eef40243ba951fd819bbdbd8c65732f8767c75918693f2784368329d52f0af"

  url "https://github.com/dev-pikapik/pika-tools/releases/download/v#{version}/pikapik.zip"
  name "pikapik"
  desc "Menu bar tools for keys, windows and the Dock, plus Keep Awake"
  homepage "https://github.com/dev-pikapik/pika-tools"

  auto_updates true
  depends_on macos: :sonoma

  app "pikapik.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/pikapik.app"], must_succeed: false
    remove "{{appdir}}/pika-tools.app", recursive: true
  end

  uninstall_preflight_steps do
    run "{{appdir}}/pikapik.app/Contents/MacOS/pika-tools", args: ["--uninstall"], must_succeed: false
  end

  uninstall_postflight_steps do
    remove "{{appdir}}/pika-tools.app", recursive: true
  end

  uninstall quit: "com.pesotchi.pika-tools"

  zap trash: [
    "~/Library/Application Scripts/com.pesotchi.pika-tools.compress",
    "~/Library/Application Scripts/com.pesotchi.pika-tools.convert",
    "~/Library/Application Scripts/com.pesotchi.pika-tools.new-file",
    "~/Library/Caches/com.pesotchi.pika-tools",
    "~/Library/Containers/com.pesotchi.pika-tools.compress",
    "~/Library/Containers/com.pesotchi.pika-tools.convert",
    "~/Library/Containers/com.pesotchi.pika-tools.new-file",
    "~/Library/HTTPStorages/com.pesotchi.pika-tools",
    "~/Library/Preferences/com.pesotchi.pika-tools.plist",
  ]

  caveats <<~EOS
    pikapik needs two permissions in System Settings › Privacy & Security:
      Accessibility and Input Monitoring
    The app opens a window that walks you through them.
  EOS
end
