//
//  ContentView.swift
//  Calculadora
//
//  Created by MAC on 18/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var texto1 = ""
    @State private var texto2 = ""
    @State private var resultado = "0"
    var body: some View {
        VStack(spacing: 20) {
            Text("Operaciones")
                .font(.largeTitle)
                .bold()
            TextField("Primer número", text: $texto1)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            TextField("Segundo número", text: $texto2)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            HStack(spacing: 12) {
                BotonOperacion(simbolo: "plus") { calcular("+") }
                BotonOperacion(simbolo: "minus") { calcular("-") }
                BotonOperacion(simbolo: "multiply") { calcular("*") }
                BotonOperacion(simbolo: "divide") { calcular("/") }
            }
            Text("Resultado")
                .font(.headline)
                .foregroundStyle(.secondary)
                Text(resultado)
                .font(.system(size: 48, weight: .bold))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Spacer()
        }
        .tint(.orange)
        .padding()
    }
    func calcular(_ operacion: String) {
        guard let a = Double(texto1), let b = Double(texto2) else {
            resultado = "Escribe dos números"
            return
        }
        switch operacion {
        case "+": resultado = formatear(a + b)
        case "-": resultado = formatear(a - b)
        case "*": resultado = formatear(a * b)
        case "/":
            if b == 0 {
                resultado = "No se puede dividir entre 0"
            } else {
                resultado = formatear(a / b)
            }
        default: break
        }
    }
    func formatear(_ x: Double) -> String {
        if x == x.rounded() && abs(x) < 1e15 {
            return String(Int(x))
        }
        return String(x)
        }
    }
struct BotonOperacion: View {
    let simbolo: String
    let accion: () -> Void
    var body: some View {
        Button(action: accion) {
            Image(systemName: simbolo)
                .font(.title2)
                .frame(maxWidth: .infinity, minHeight: 44)
        }
        .buttonStyle(.borderedProminent)
    }
}
#Preview {
    ContentView()
}
