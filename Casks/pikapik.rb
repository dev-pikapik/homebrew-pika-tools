cask "pikapik" do
  version "1.43.0"
  sha256 "1bf9709c2b270054b2d08f61448dd8434c5311e2cff33a814fd2fdb528b96421"

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

  uninstall_postflight_steps do
    remove "{{appdir}}/pika-tools.app", recursive: true
  end

  uninstall quit:   "com.pesotchi.pika-tools",
            script: {
              executable:   "/usr/bin/env",
              args:         ["#{appdir}/pikapik.app/Contents/MacOS/pika-tools", "--uninstall"],
              must_succeed: false,
            }

  zap launchctl: "com.pesotchi.pika-tools.fans",
      delete:    [
        "/Library/LaunchDaemons/com.pesotchi.pika-tools.fans.plist",
        "/Library/PrivilegedHelperTools/com.pesotchi.pika-tools.fans",
      ],
      trash:     [
    "~/Library/Application Scripts/com.pesotchi.pika-tools.archive",
    "~/Library/Application Scripts/com.pesotchi.pika-tools.compress",
    "~/Library/Application Scripts/com.pesotchi.pika-tools.convert",
    "~/Library/Application Scripts/com.pesotchi.pika-tools.new-file",
    "~/Library/Application Scripts/com.pesotchi.pika-tools.preview",
    "~/Library/Application Support/pika-tools",
    "~/Library/Caches/com.pesotchi.pika-tools",
    "~/Library/Containers/com.pesotchi.pika-tools.archive",
    "~/Library/Containers/com.pesotchi.pika-tools.compress",
    "~/Library/Containers/com.pesotchi.pika-tools.convert",
    "~/Library/Containers/com.pesotchi.pika-tools.new-file",
    "~/Library/Containers/com.pesotchi.pika-tools.preview",
    "~/Library/HTTPStorages/com.pesotchi.pika-tools",
    "~/Library/Preferences/com.pesotchi.pika-tools.plist",
  ]

  caveats <<~EOS
    pikapik needs two permissions in System Settings › Privacy & Security:
      Accessibility and Input Monitoring
    The app opens a window that walks you through them.
  EOS
end
