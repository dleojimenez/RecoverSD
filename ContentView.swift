import SwiftUI

struct ContentView: View {
    @State private var disks: [String] = []

    var body: some View {
        VStack {
            Text("Recuperador de Tarjetas SD")
                .font(.title)
                .padding()

            Button("Detectar Discos") {
                disks = DiskUtility.detectDisks()
            }

            List(disks, id: \.self) { disk in
                Text(disk)
            }
        }
        .frame(width: 400, height: 300)
        .padding()
    }
}