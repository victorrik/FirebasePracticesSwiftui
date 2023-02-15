//
//  ContentView.swift
//  FirebasePractice
//
//  Created by Victor Andres Marcial on 11/02/23.
//

import SwiftUI

struct ContentView: View {
	@State private var showMainView = false
	@State private var moveImage = false
	@State private var showLobby = false
	@State private var showHome = false
	
 func startApp() async {
	  
	 let resultAuth = await VAuth.checkExistence()
	 guard let user = resultAuth.info else{
		 withAnimation(.easeOut(duration: 1)) {
			 self.moveImage = true
		 }
		 DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			 self.showLobby = true
		 }
		 return
	 }
	 print("El uusuario esta logueado con \(user.uid)")
		 
 }
    var body: some View {
			if showHome {
				//HomeView()
					//.transition(.backslide)
				Text("meow")
			}
			else if showLobby{
				LoginView()
			}
			else{
				VStack{
					Image("logo")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 150)
						if moveImage{
							Spacer()
						}
				}
				.task {
					await startApp()
				}
				.padding(.vertical)

			}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
