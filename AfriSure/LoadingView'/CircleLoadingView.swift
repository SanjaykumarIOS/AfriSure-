


import SwiftUI

struct CircleLoadingView: View {
 
    @State private var isLoading = false
 
    var body: some View {
        ZStack {
 
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 3)
                .frame(width: 20, height: 20)
 
            Circle()
                .trim(from: 0, to: 0.3)
                .stroke(fontOrangeColour, lineWidth: 3)
                .frame(width: 20, height: 20)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .onAppear() {
                    self.isLoading = true
            }
        }
    }
}


#Preview {
    CircleLoadingView()
}
