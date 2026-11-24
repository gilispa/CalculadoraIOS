//
//  MiCalculadora.swift
//  Calculadora
//
//  Created by MAC on 18/11/26.
//

import SwiftUI

struct MiCalculadora: View {
    @State private var pantalla = ""
    @State private var operacionTexto = ""
    @State private var numero1 = 0.0
    @State private var operacion = ""
    @State private var empezarNuevo = false
    let filas = [
        ["C","DEL"],
        ["7", "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        ["0", ".", "=", "+"]
    ]
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text(operacionTexto)
                .font(.title2)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, minHeight: 30, alignment: .trailing)
            Text(pantalla.isEmpty ? "0" : pantalla)
                .font(.system(size: 64, weight: .light))
                .lineLimit(1)
                .minimumScaleFactor(0.4)
                .frame(maxWidth: .infinity, alignment: .trailing)
            ForEach(filas, id: \.self) { fila in
                HStack(spacing: 12) {
                    ForEach(fila, id: \.self) { tecla in
                        BotonCalc(tecla: tecla) {
                            tocar(tecla)
                        }
                    }
                }
            }
        }
        .padding()
    }
    func tocar(_ tecla: String) {
        switch tecla {
        case "C":
            clicBorrar()
        case "=":
            clicIgual()
        case "+", "-", "*", "/":
            clicOperacion(tecla)
        case "DEL":
            clicDEL()
        default:
            clicNumero(tecla)
        }
    }
    func clicNumero(_ digito: String) {
        if empezarNuevo {
            pantalla = ""
            empezarNuevo = false
        }
        if digito == "." && pantalla.contains(".") {
            return
        }
        
        pantalla += digito
    }
    func clicDEL(){
        pantalla = String(pantalla.dropLast())
    }
    func clicOperacion(_ op: String){
        if !operacion.isEmpty && !pantalla.isEmpty {
            clicIgual()
        }
        if let numero = Double(pantalla) {
            numero1 = numero
        }
        operacion = op
        operacionTexto = formatear(numero1) + " " + op
        pantalla = ""
    }
    func clicIgual() {
        guard let numero2 = Double(pantalla), !operacion.isEmpty else { return }
        var resultadoTexto = ""
        
        switch operacion {
        case "+": resultadoTexto = formatear(numero1 + numero2)
        case "-": resultadoTexto = formatear(numero1 - numero2)
        case "*": resultadoTexto = formatear(numero1 * numero2)
        case "/":
            if numero2 == 0 {
                resultadoTexto = "Error"
            } else {
                resultadoTexto = formatear(numero1 / numero2)
            }
        default: break
        }
        pantalla = resultadoTexto
        operacionTexto = ""
        operacion = ""
        
        empezarNuevo = true     }
    func formatear(_ x: Double) -> String {
        if x == x.rounded() && abs(x) < 1e15 {
            return String(Int(x))
        }
        return String(x)
    }
    func clicBorrar() {
        pantalla = ""
        operacionTexto = ""
        numero1 = 0
        operacion = ""
    }
}

struct BotonCalc: View {
    let tecla: String
    let accion: () -> Void
    var esNumero: Bool {
        Int(tecla) != nil || tecla == "."
    }
    var colorFondo: Color {
        if esNumero {
            return .gray.opacity(0.2)
        } else if tecla == "C" {
            return .red
        } else {
            return .orange
        }
    }
    var body: some View {
        Button(action: accion) {
            Text(tecla)
                .font(.title)
                .frame(maxWidth: .infinity, minHeight: 70)
                .background(colorFondo)
                .foregroundStyle(esNumero ? Color.primary : Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
#Preview {
    MiCalculadora()
}
