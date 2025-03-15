//
//  Home.swift
//  3DCard
//
//  Created by Shota Sakoda on 2025/03/15.
//

import SwiftUI

struct Home: View {
    @State var offset: CGSize = .zero
    var body: some View {
        GeometryReader {
            let size = $0.size
            let imageSize = size.width * 0.8
            VStack{
                Image("Shoe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize)
                    .rotationEffect(.init(degrees: -30))
                    .zIndex(1)
                    .offset(x: -20)
                    .offset(x: offsetToAngle().degrees * 5, y: offsetToAngle(true).degrees * 5)
                
                Text("NEW WING")
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .padding(.top,-60)
                    .padding(.bottom,55)
                    .zIndex(0)
                
                VStack(alignment: .leading, spacing: 10){
                    Text("BRAND")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .fontWidth(.compressed)
                    
                    HStack{
                        BlendedText("SAMPLE SHOES MODEL")
                        
                        Spacer(minLength: 0)
                        
                        BlendedText("$118")
                    }
                    
                    HStack{
                        BlendedText("YOUR NEXT SHOES")
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            
                        } label: {
                            Text("BUY")
                                .fontWeight(.bold)
                                .foregroundColor(Color("BG"))
                                .padding(.vertical, 12)
                                .padding(.horizontal, 15)
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color("Orange"))
                                        .brightness(0.1)
                                        
                                }
                        }
                    }
                    .padding(.top, 14)
                    
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 10)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(.white)
            .padding(.top, 80)
            .padding(.horizontal, 30)
            .frame(width: imageSize)
            .background(content: {
                ZStack(alignment: .topTrailing){
                    Rectangle()
                        .fill(Color("BG"))
                    
                    Circle()
                        .fill(Color("Orange"))
                        .frame(width: imageSize, height: imageSize)
                        .scaleEffect(1.2, anchor: .leading)
                        .offset(x: imageSize * 0.3, y: -imageSize * 0.1)
                        
                }
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            })
            .rotation3DEffect(offsetToAngle(true), axis: (x: -1, y: 0, z: 0))
            .rotation3DEffect(offsetToAngle(), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(offsetToAngle(true) * 0.1, axis: (x: 0, y: 0, z: 1))
            .scaleEffect(0.9)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onChanged({value in
                            offset = value.translation
                    }).onEnded ({ _ in
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.32, blendDuration: 0.32)) {
                            offset = .zero
                        }
                    })
            )
        }
    }
    
    func offsetToAngle(_ isVertical: Bool = false)->Angle{
        let progress = (isVertical ? offset.height: offset.width) / (isVertical ? screenSize.height: screenSize.width)
        return .init(degrees: progress * 10)
    }
    
    var screenSize: CGSize = {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        return window.screen.bounds.size
    }()
    
    @ViewBuilder
    func BlendedText(_ text: String) -> some View {
        Text(text)
            .font(.title3)
            .fontWeight(.semibold)
            .fontWidth(.condensed)
            .blendMode(.difference)
    }
}

#Preview {
    Home()
}
