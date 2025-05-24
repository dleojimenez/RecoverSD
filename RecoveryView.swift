import SwiftUI

struct RecoveryView: View {
    @State private var sourceDisk: String = "/dev/disk2"
    @State private var outputPath: String = "/Users/Shared/recovery.img"
    @State private var logPath: String = "/Users/Shared/recovery.log"
    @State private var outputText: String = ""
    @State private var isRecovering = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recuperación con ddrescue")
                .font(.headline)
                .padding(.bottom, 10)

            TextField("Disco de origen (ej: /dev/disk2)", text: $sourceDisk)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 5)

            TextField("Ruta del archivo de imagen", text: $outputPath)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 5)

            TextField("Ruta del archivo de log", text: $logPath)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)

            Button(action: {
                isRecovering = true
                DispatchQueue.global(qos: .userInitiated).async {
                    RecoveryManager.recoverDisk(sourceDisk: sourceDisk, outputPath: outputPath, logPath: logPath)
                    DispatchQueue.main.async {
                        isRecovering = false
                        outputText = "Recuperación finalizada. Revisa los archivos de salida."
                    }
                }
            }) {
                Text(isRecovering ? "Recuperando..." : "Iniciar recuperación")
            }
            .disabled(isRecovering)
            .padding(.bottom, 10)

            ScrollView {
                Text(outputText)
                    .font(.system(size: 12, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 120)
            .border(Color.gray)
        }
        .padding()
        .frame(width: 480)
    }
}