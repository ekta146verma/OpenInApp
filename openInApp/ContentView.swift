import SwiftUI

struct ContentView: View {
    @StateObject private var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    
                    // Header
                    HStack {
                        Text("Dashboard")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    ScrollView {
                        if let data = networkManager.responseData {
                            VStack(spacing: 20) {
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text("Good morning")
                                        .foregroundColor(.gray)
                                        .padding(.top, 20.0)
                                        
                                    Text("Ekta Verma 👋")
                                        .font(.title)
                                        .bold()
                                    
                                    // Overview graph placeholder
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .frame(height: 200)
                                        .overlay(Text("Overview Graph").foregroundColor(.gray))
                                }
                                .padding()
                                .background(Color(red: 245/255, green: 245/255, blue: 245/255))
                                .cornerRadius(15)
                                .padding(.horizontal)
                                
                                // Statistics
                                HStack(spacing: 10) {
                                    StatisticView(icon: "cursorarrow.click", count: "\(data.todayClicks)", label: "Today's clicks")
                                    StatisticView(icon: "map.fill", count: data.topLocation, label: "Top Location")
                                    StatisticView(icon: "link.circle.fill", count: data.topSource, label: "Top source")
                                }
                                .padding(.horizontal)
                                
                                // View Analytics Button
                                Button(action: {
                                    // Action here
                                }) {
                                    Text("View Analytics")
                                        .font(.headline)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                }
                                
                                // Top Links Section
                                VStack {
                                    HStack {
                                        Text("Top Links")
                                            .font(.headline)
                                            .padding(.all)
                                            .background(Color(red: 14/255, green: 111/255, blue: 255/255)).cornerRadius(30)
                                        Spacer()
                                        Text("Recent Links")
                                            .padding(.trailing)
                                        Image(systemName: "magnifyingglass")
                                            .padding(.trailing)
                                    }
                                    
                                    ForEach(data.data.recentLinks) { link in LinkView(link: link)
                                    }
                                }
                                .padding(.horizontal)
                                
                                // Additional Buttons
                                Button(action: {
                                    // Button Action
                                }) {
                                    Text("View all Links")
                                        .font(.headline)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.clear
                                            .border(Color.gray, width: 1))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                }
                                
                                Button(action: {
                                    // Button Action
                                }) {
                                    Text("Talk with us")
                                        .font(.headline)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.green.opacity(0.2).border(Color.green, width: 1))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                }
                                
                                Button(action: {
                                    // Button Action
                                }) {
                                    Text("Frequently Asked Questions")
                                        .font(.headline)
                                        .multilineTextAlignment(.leading)
                                        .padding(15.0)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.blue.opacity(0.2)
                                            .border(Color.blue, width: 1))
                                        .cornerRadius(10)
                                        .padding([.leading, .bottom, .trailing])
                                }
                            }
                        } else {
                            ProgressView("Loading...")
                        }
                    }
                    .background(Color(red: 245/255, green: 245/255, blue: 245/255))
                    .cornerRadius(30)
                    
                    
                    Spacer()
                    
                    // Bottom Navigation Bar
                    CustomTabView()
                }
                .background(Color(red: 14/255, green: 111/255, blue: 255/255))
                .onAppear {
                    networkManager.fetchData()
                }
            }
        }
    }
}

struct CustomTabView: View {
    var body: some View {
        HStack {
            Spacer()
            TabBarButton(imageName: "link", text: "Links")
            Spacer()
            TabBarButton(imageName: "book", text: "Courses")
            Spacer()
            CenterButton()
            Spacer()
            TabBarButton(imageName: "megaphone", text: "Campaigns")
            Spacer()
            TabBarButton(imageName: "person", text: "Profile")
            Spacer()
        }
        .padding(.top, 10)
        .background(Color.white.shadow(radius: 2))
    }
}

struct TabBarButton: View {
    var imageName: String
    var text: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 24))
                .foregroundColor(.gray)
            Text(text)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct CenterButton: View {
    var body: some View {
        Button(action: {
            // Button Action
        }) {
            Image(systemName: "plus")
                .font(.system(size: 32))
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .clipShape(Circle())
                .shadow(radius: 10)
        }
        .offset(y: -20)
    }
}

struct StatisticView: View {
    var icon: String
    var count: String
    var label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.blue)
            Text(count)
                .font(.title3)
                .multilineTextAlignment(.leading)
                .bold()
            Text(label)
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }
}

struct LinkView: View {
    let link: Link
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "link.circle.fill")
                    .foregroundColor(.blue)
                VStack(alignment: .leading) {
                    Text(link.title)
                    Text(link.timesAgo)
                        .foregroundColor(.gray)
                }
                Spacer()
                Text("\(link.totalClicks) Clicks")
                    .foregroundColor(.gray)
            }
            Text(link.webLink)
                .foregroundColor(.blue)
            Divider()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
