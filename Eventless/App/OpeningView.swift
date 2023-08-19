// Create an animated opening view screen for the app

// Imports and configuration
import SwiftUI

// Define the main visual component of the app's opening screen
struct OpeningView: View {
    // Properties
    @State private var labelYPosition: CGFloat = UIScreen.main.bounds.height / 2 - 50
    @State private var pinYPosition: CGFloat = 0
    @State private var animationIsActive = false
    @State private var globeAnimationIsActive = false
    @State private var pinAnimationIsActive = false
    @State private var rotationAngle: Double = 0.0
    @State private var displayMainView = true
    @State private var textColor: Color = .gray
    
    var body: some View {
        ZStack {
            // Check if animation is active
            if !animationIsActive {
                ZStack {
                    // Check if globe animation is active
                    if globeAnimationIsActive {
                        VStack {
                            // Check if pin animation is active
                            if pinAnimationIsActive {
                                Image(systemName: "mappin")
                                    .resizable()
                                    .frame(width: 8, height: 24)
                                    .foregroundColor(.white)
                                    .position(x: UIScreen.main.bounds.width / 2, y: pinYPosition)
                                    .scaleEffect(1.0)
                                    .onAppear {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            pinYPosition = UIScreen.main.bounds.height / 2 - 165
                                        }
                                    }
                            }
                        }
                        // Create a delay for the start of the animation
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
                                pinAnimationIsActive = true
                            }
                        }
                            
                        Image(systemName: "globe.asia.australia")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .font(.system(size: 80, weight: .thin))
                            .rotationEffect(.degrees(rotationAngle))
                            .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 - 100)
                            .onAppear {
                                withAnimation(Animation.linear(duration: 2.0)) {
                                    rotationAngle = 360
                                }
                            }
                    }
                }
                // Create a delay for the start of the animation
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                        globeAnimationIsActive = true
                    }
                }
                    
                Text("Eventless")
                    .font(.system(size: 40, weight: .regular))
                    .foregroundColor(textColor)
                    .position(x: UIScreen.main.bounds.width / 2, y: labelYPosition)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.5).delay(2.0)) {
                            labelYPosition = UIScreen.main.bounds.height / 2
                            self.textColor = .white
                        }
                        // Create a delay for the start of the animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                            animationIsActive = true
                        }
                    }
            } else {
                // Trigger 'MainView()' when annimation ends (navigate actual app)
                if displayMainView {
                    MainView()
                }
            }
        }
    }
}

// Rrovide a preview of the 'OpeningView'
struct OpeningView_Previews: PreviewProvider {
    static var previews: some View {
        OpeningView()
            .preferredColorScheme(.dark)
    }
}
