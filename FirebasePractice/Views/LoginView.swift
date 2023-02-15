//
//  LoginView.swift
//  FirebasePractice
//
//  Created by Victor Andres Marcial on 11/02/23.
//

import SwiftUI

struct LoginView: View {
	let ipHosting:String = try! Configuration.value(for: .IP)
    var body: some View {
			VStack{
				Text("Este es el login \(ipHosting)")
				Button("meow"){
					print("mewo")
				}
			}
				
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
			LoginView()
				.previewDevice("iPhone 14 Pro Max")
    }
}
