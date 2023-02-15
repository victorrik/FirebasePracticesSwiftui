//
//  SignUpView.swift
//  FirebasePractice
//
//  Created by Victor Andres Marcial on 12/02/23.
//

import SwiftUI

struct SignUpView: View {
	
	//@EnvironmentObject var globalValues:GlobalValuesModel
	//@Binding var rootView : RootView
	@ObservedObject var inputEmailRef:VInputRef = VInputRef()
	@ObservedObject var inputPasswordRef:VInputRef = VInputRef()
	@ObservedObject var buttonLoginRef:VButtonRef = VButtonRef()
	
	@State private var email : String = ""
	@State private var password : String = ""
	@State private var showPass : Bool = false
	
	func verifyData() -> Bool {
		inputEmailRef.resetCaption()
		inputPasswordRef.resetCaption()
		if (email.isEmpty) {
			inputEmailRef.showCaption("meow")
			return true
		}
		if (password.isEmpty) {
			inputPasswordRef.showCaption("meow meow")
			return true
		}
		return false
	}
	func loginAccount()async {
		if verifyData() {
			return
		}
		
		buttonLoginRef.handleLoading(true)
		
		print("Lanzando function uwu")
		let accountData = await VFunctions.callFunction(location: .handleAuths, operation: "checkAccount", dataObject: ["email":email])
		print("accountData \(accountData)")
		buttonLoginRef.handleLoading(false)
		
	}
    var body: some View {
			ScrollView{
					
					Image("logo")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 150)
					VFont("Iniciar sesión",type: .h4)
						.padding(.bottom,16)
					
					VStack(spacing: 16){
						VInput(value: $email,
										labelPlaceholder: "Correo electronico",
										autocapitalization: .never,
										keyboardType: .emailAddress,
										ref: inputEmailRef)
						
						VInput(value: $password,
										labelPlaceholder: "Contraseña",
										type: showPass ? .text : .password,
										iconPrefix: .lock,
										iconSuffix: showPass ? .eyeSlash : .eye,
										iconSuffixAction: {showPass.toggle()},
										ref: inputPasswordRef)
						
					}
					.padding(.bottom,16)
					
					VStack(spacing:16){
						VButton("Iniciar sesión",action: {
							Task{
								await self.loginAccount()
							}
						},ref: buttonLoginRef)
						
						HStack{
							Text("¿Olvidaste tu contraseña?")
							Button("Recuperala"){
								print("meow meo")
							}
							
							
							
							
						}
						.frame(minWidth: 0,maxWidth: .infinity)
						VButton("Crear cuenta",type: .secondary,action: {
							withAnimation(.default){
							 
							}
						})
					}
			}
			.padding(24)
			.onAppear{
				UIScrollView.appearance().alwaysBounceVertical = false
			}
			

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
