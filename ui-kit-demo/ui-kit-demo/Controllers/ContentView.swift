//
//  ContentView.swift
//  ui-kit-demo
//
//  Created by Phạm Công on 11/09/2023.
//

import SwiftUI

fileprivate struct ContentView: View {
    fileprivate func popupError() -> some View {
        return VStack{
            Image("warning_icon")
                .frame(width: 40, height: 40)
            Text("Lưu thông tin không thành công!")
                .font(
                    Font.custom("Averta", size: 18)
                        .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.95, green: 0.13, blue: 0.13))
                .padding(.top, 20)
            Text("Vui lòng thử lại!")
                .font(Font.custom("Averta", size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                .padding(.top, 15)
            Button{
                
            }label: {
                Text("Thử lại")
                    .font(
                        Font.custom("Averta", size: 16)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                
            }.buttonStyle(BorderedButtonStyle())
                .padding(.top, 25)
                .padding(.horizontal, 20)
            
            
            Button{}label: {
                Text("Quay lại trang chủ")
                    .font(
                        Font.custom("Averta", size: 16)
                            .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0, green: 0.55, blue: 0.27))
            }
            .padding(.top, 30)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 34)
        .padding(.bottom, 50)
        .background(Color.white)
        .cornerRadius(8)
        .padding(.horizontal, 20)
    }
    
    fileprivate func popUpNotFound() -> some View {
        return VStack{
            Text("Khách hàng chưa có thông tin trên hệ thống!")
                .font(
                    Font.custom("Averta", size: 18)
                        .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.08, green: 0.07, blue: 0.07))
            
            Text("Vui lòng tiếp tục định danh Khách hàng")
                .font(Font.custom("Averta", size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.08, green: 0.07, blue: 0.07))
                .padding(.top, 20)
            
            Button{}label: {
                Text("Định danh khách hàng")
                    .font(
                        Font.custom("Averta", size: 16)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
            .buttonStyle(.bordered)
            .padding(.top, 22)
            Text("hoặc liên hệ với bộ phận support")
                .font(Font.custom("Averta", size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.08, green: 0.07, blue: 0.07))
                .padding(.top, 30)
            
            Button{}label: {
                HStack{
                    Image("headset_icon")
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text("Hỗ trợ 24/7")
                        .font(
                            Font.custom("Averta", size: 16)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0, green: 0.55, blue: 0.27))
                }
            }
            .buttonStyle(ButtonBorderStyle())
            Button{
                
            }label: {
                Text("Quay lại trang chủ")
                    .font(
                        Font.custom("Averta", size: 16)
                            .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0, green: 0.55, blue: 0.27))
            }
            .padding(.top, 30)
        }
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(8)
        .padding(.horizontal, 20)
    }
    
    fileprivate func popUpSupport() -> some View {
        return VStack{
            Text("Trung tâm trợ giúp")
              .font(
                Font.custom("Averta", size: 22)
                  .weight(.bold)
              )
              .foregroundColor(Color(red: 0, green: 0.55, blue: 0.27))
            
            Group {
                ItemSupportRow(title: "OCB Hotline", value: "0989.475.895", icon: .init("headset_icon"))
                ItemSupportRow(title: "OCB Hotline", value: "0989.475.895", icon: .init("headset_icon"))
                ItemSupportRow(title: "OCB Hotline", value: "0989.475.895", icon: .init("headset_icon"))
            }
            
            Button{}label: {
                Text("Quay lại trang chủ")
                  .font(
                    Font.custom("Averta", size: 16)
                      .weight(.bold)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(.white)
            }
            .buttonStyle(.bordered)
            .padding(.top, 40)
        }
        .padding(.bottom, 40)
        .padding(.top, 80)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(8)
        .padding(.horizontal, 20)
        .overlay(
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 100, height: 100)
              .background(.white)
              .cornerRadius(100)
              .overlay(
                RoundedRectangle(cornerRadius: 100)
                  .inset(by: 2.5)
                  .stroke(Color(red: 0, green: 0.55, blue: 0.31), lineWidth: 5)
                  .overlay(
                    Image("headset_icon")
                    .frame(width: 60, height: 60)
                  )
              ).padding(.top, -40), alignment: .top
        )
    }
    @State var show: Bool = false
    var body: some View {
        ZStack{
            Color.green
            VStack{
                Button{
                    withAnimation {
                        show.toggle()
                    }
                }label: {
                    Text("Show")
                }
            }
            if show {
                PopUpView1(isActive: $show)
//                CustomDialog(isActive: $show, title: "", message: "", buttonTitle: "") {
//
//                }
            }
        }
    }
    
    var exampleInfo: some View {
        VStack{
            ItemStatusVerifyView(isValid: true, title: "Xác thực khuôn mặt hợp lệ!")
            
            ItemStatusVerifyView(isValid: false, title: "Xác thực khuôn mặt không hợp lệ!")
            
            HStack{
                ImageItermView(title: "Ảnh trong CSDL")
                ImageItermView(title: "Ảnh hiện tại")
            }
            
            CustomerLabel(name: "NGUYỄN THỊ A", description: "Khách hàng cá nhân")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ItemSupportRow: View {
    var title: String
    var value: String
    var icon: Image
    var body: some View {
        VStack{
            HStack(spacing: 15){
                Image("headset_icon")
                    .resizable()
                .frame(width: 30, height: 30)
                VStack(alignment: .leading, spacing: 8){
                    Text(title)
                      .font(
                        Font.custom("Averta", size: 14)
                          .weight(.semibold)
                      )
                      .foregroundColor(Color(red: 0.19, green: 0.19, blue: 0.19))
                    Text(value)
                      .font(
                        Font.custom("Averta", size: 18)
                          .weight(.bold)
                      )
                      .kerning(0.9)
                      .foregroundColor(.black)
                }
                Spacer()
            }
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: .infinity, height: 1)
              .background(Color(red: 0.91, green: 0.91, blue: 0.91))
        }
        .padding(.horizontal, 25)
    }
}

struct ItemStatusVerifyView: View {
    var isValid: Bool
    var title: String
    var body: some View{
        ZStack {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 295, height: 42)
              .background(Color(hex: isValid ? 0xF4FFFA : 0xFFF4F4))
              .cornerRadius(5)
              .overlay(
                RoundedRectangle(cornerRadius: 5)
                  .inset(by: 0.5)
                  .stroke(Color(hex: isValid ? 0xD8FAEB :  0xFFDBDB), lineWidth: 1)
              )
            HStack{
                Image(isValid ? "check_icon" : "warning_icon")
                    .resizable()
                .frame(width: 20, height: 20)
                Text(title)
                  .font(
                    Font.custom("Averta", size: 14)
                      .weight(.bold)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(hex: isValid ? 0x008C4F : 0xF22222))
            }
        }
    }
}

struct ImageItermView: View {
    var title: String
    var body: some View {
        ZStack(alignment: .bottom){
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 134, height: 168)
              .background(
                Image("image_demo")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 134, height: 168)
                  .clipped()
              )
              .cornerRadius(5)
            
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 134, height: 24)
              .background(Color(red: 0, green: 0.55, blue: 0.31))
              .cornerRadius(5)
            Text(title)
              .font(
                Font.custom("Averta", size: 13)
                  .weight(.semibold)
              )
              .multilineTextAlignment(.center)
              .foregroundColor(.white)
              .padding(.vertical, 5)
        }
    }
}


struct ButtonBorderStyle: ButtonStyle {
    var foregroundColor: Color = Color(hex: 0x008C44)
    var backgroundColor: Color = .white
    var strokeColor: Color = Color(red: 0, green: 0.55, blue: 0.27)
    var strokeWidth: CGFloat = 1.0
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.red)
            .padding(.vertical, 15)
            .padding(.horizontal)
            .background(backgroundColor)
            .overlay(
                Rectangle()
                    .foregroundColor(.clear)
                    .background(.clear)
                    .cornerRadius(5)
                    
                    .shadow(color: Color(red: 0, green: 0.55, blue: 0.27).opacity(0.05), radius: 2, x: 2, y: 3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .inset(by: strokeWidth/2)
                            .stroke(strokeColor, lineWidth: strokeWidth)
                    ))
    }
    
}

struct CustomerLabel: View {
    var name: String
    var description: String
    var body: some View {
        VStack(spacing: 10){
            Text(name)
              .font(
                Font.custom("Averta", size: 16)
                  .weight(.bold)
              )
              .foregroundColor(Color(red: 0, green: 0.55, blue: 0.27))
            Text(description)
              .font(Font.custom("Averta", size: 13))
              .foregroundColor(Color(red: 0.19, green: 0.19, blue: 0.19))
        }
    }
}


extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct PopUpView: View {
    var body: some View {
        ZStack {
            Color(hex: 0x000000).opacity(0.8)
            VStack(spacing: 20){
                Text("Thông báo!")
                    .font(.system(size: 18, weight: .bold))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.08, green: 0.07, blue: 0.07))
                Text("[Errors messages]")
                    .font(.system(size: 18, weight: .regular))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.9, green: 0.24, blue: 0.33))
                
                Button{}label: {
                    HStack{
                        Image("headset_icon")
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text("Hỗ trợ 24/7")
                            .font(
                                Font.custom("Averta", size: 16)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0, green: 0.55, blue: 0.27))
                    }
                }
                .buttonStyle(ButtonBorderStyle())
                
                Text("Đóng")
                    .font(.system(size: 14, weight: .bold))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.08, green: 0.07, blue: 0.07))
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 34)
            .padding(.bottom, 50)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea()
    }
}


struct PopUpView2: View {
    var body: some View {
        ZStack {
            Color(hex: 0x000000).opacity(0.8)
            VStack(spacing: 20){
                Text("Thiết bị không hỗ trợ NFC!")
                    .font(.system(size: 18, weight: .bold))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.08, green: 0.07, blue: 0.07))
                Text("Vui lòng sử dụng thiết bị hỗ trợ NFC\nĐể xác thực CCCD gắn chip")
                  .font(.system(size: 18, weight: .regular))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.08, green: 0.07, blue: 0.07))
                
                Button{}label: {
                    HStack{
                        Image("headset_icon")
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text("Đồng ý")
                            .font(.system(size: 16, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0, green: 0.55, blue: 0.27))
                    }
                }
                .buttonStyle(ButtonBorderStyle())
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 34)
            .padding(.bottom, 50)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea()
    }
}

struct PopUpView1: View {
    var primaryAction: (()->())?
    @Binding var isActive: Bool
    
    @State private var offset: CGFloat = 1000
    var body: some View {
        BasePopupView({
            VStack(spacing: 20){
                Text("Thiết bị không hỗ trợ NFC!")
                    .font(.system(size: 18, weight: .bold))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.08, green: 0.07, blue: 0.07))
                Text("Vui lòng sử dụng thiết bị hỗ trợ NFC\nĐể xác thực CCCD gắn chip")
                  .font(.system(size: 18, weight: .regular))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.08, green: 0.07, blue: 0.07))
                
                Button{
                    withAnimation {
                        close()
                    }
                }label: {
                    HStack{
                        Image("headset_icon")
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text("Đồng ý")
                            .font(.system(size: 16, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0, green: 0.55, blue: 0.27))
                    }
                }
                .buttonStyle(ButtonBorderStyle())
            }
        }, alignment: .center, primaryAction: primaryAction, isActive: $isActive, offset: $offset)
    }
    
    func close() {
        withAnimation(.spring()) {
            offset = 1000
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isActive = false
            })
        }
    }
}

struct BasePopupView<Content: View>: View {
    let content: Content
    let alignment: Alignment
    var primaryAction: (()->())?
    @Binding var isActive: Bool
    @Binding var offset: CGFloat
    init(@ViewBuilder _ content: ()-> Content, alignment: Alignment, primaryAction: (()->())? = nil, isActive: Binding<Bool> = .constant(false), offset: Binding<CGFloat> = .constant(1000)) {
        self.alignment = alignment
        self.content = content()
        self._isActive = isActive
        self._offset = offset
    }
    @State var completedShow: Bool = false
    
    var body: some View {
        ZStack(alignment: alignment) {
            Color(hex: 0x000000).opacity(0.8)
                .ignoresSafeArea()
                .onTapGesture {
                    close()
                }
            content
                .frame(maxWidth: .infinity)
                .padding(.top, 34)
                .padding(.bottom, 50)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 20)
        }
        .offset(x: 0, y: offset)
        .onAppear {
            withAnimation(.spring()) {
                offset = 0
            }
        }
    }
    
    func close() {
        withAnimation(.spring()) {
            offset = 1000
            isActive = false
        }
    }
}



import SwiftUI

struct CustomDialog: View {
    @Binding var isActive: Bool

    let title: String
    let message: String
    let buttonTitle: String
    let action: () -> ()
    @State private var offset: CGFloat = 1000

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.8)
                .onTapGesture {
                    close()
                }

            VStack {
                Text(title)
                    .font(.title2)
                    .bold()
                    .padding()

                Text(message)
                    .font(.body)

                Button {
                    action()
                    close()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.red)

                        Text(buttonTitle)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .padding()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(alignment: .topTrailing) {
                Button {
                    close()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                .tint(.black)
                .padding()
            }
            .shadow(radius: 20)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
        .ignoresSafeArea()
    }

    func close() {
        withAnimation(.spring()) {
            offset = 1000
            isActive = false
        }
    }
}

struct CustomDialog_Previews: PreviewProvider {
    static var previews: some View {
        CustomDialog(isActive: .constant(true), title: "Access photos?", message: "This lets you choose which photos you want to add to this project.", buttonTitle: "Give Access", action: {})
    }
}
