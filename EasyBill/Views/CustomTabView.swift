//
//  CustomTabView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab: TabItem = .home
    @Namespace private var animationNamespace
    
    var body: some View {
        ZStack {
            // Content
            VStack(spacing: 0) {
                switch selectedTab {
                case .home:
                    HomeView()
                case .clients:
                    ClientsView()
                case .business:
                    BusinessView()
                case .settings:
                    SettingsView()
                }
                Spacer()
            }
            .padding(.bottom, 80)
            
            // Floating Tab Bar
            VStack {
                Spacer()
                HStack {
                    ForEach(TabItem.allCases, id: \.self) { tab in
                        VStack(spacing: 4) {
                            ZStack {
                                if selectedTab == tab {
                                    Rectangle()
                                        .fill(Color.cyan)
                                        .frame(height: 3)
                                        .matchedGeometryEffect(id: "indicator", in: animationNamespace)
                                        .padding(.horizontal, 10)
                                } else {
                                    Color.clear.frame(height: 3)
                                        .padding(.horizontal, 10)
                                }
                            }

                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    selectedTab = tab
                                }
                            }) {
                                VStack(spacing: 4) {
                                    Image(systemName: tab.icon)
                                        .font(.system(size: 20))
                                    Text(tab.rawValue)
                                        .font(.caption2)
                                }
                                .foregroundColor(selectedTab == tab ? .cyan : .gray)
                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.cyan.opacity(0.1))
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
                .background(selectedTab == .settings ? .gray.opacity(0.1) : Color.clear)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
#Preview {
    CustomTabView()
}
