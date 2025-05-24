import Foundation

struct RecoveryManager {
    static func recoverDisk(sourceDisk: String, outputPath: String, logPath: String) {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/opt/homebrew/bin/ddrescue") // o "/usr/local/bin/ddrescue" dependiendo de la instalación
        task.arguments = ["-n", sourceDisk, outputPath, logPath]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe

        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            print("Error ejecutando ddrescue: \(error)")
        }

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = String(data: data, encoding: .utf8) {
            print("Resultado de ddrescue:\n\(output)")
        }
    }
}