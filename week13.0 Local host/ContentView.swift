import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

struct HomeView: View {
    @EnvironmentObject var viewModal:ViewModel
    @State var isPresentedNew = false
    @State var title = ""
    @State var content = ""
    @State var idText = ""
    var body: some View {
        NavigationView {
            List{
                ForEach(viewModal.items,id:\.id){item in
                    
                    NavigationLink {
                        DetailView(item: item)
                    } label: {
                        VStack(alignment:.leading){
                            Text(item.title)
                            Text(item.content).font(.caption).foregroundColor(.gray)
                        }
                        
                    }

                }
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Get requests")
            .navigationBarItems(trailing: plusButton)
        }
        .sheet(isPresented: $isPresentedNew) {
            NewPostView(isPresentedNew: $isPresentedNew, title: $title, content:$content, idText: $idText)
        }
    }
    
    var plusButton:some View{
        Button {
            print("press")
            isPresentedNew = true
        } label: {
            Image(systemName: "plus")
        }

    }
}
