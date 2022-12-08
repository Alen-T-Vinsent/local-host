import SwiftUI

struct NewPostView: View {
    @EnvironmentObject var viewModel:ViewModel
    
    @Binding var isPresentedNew:Bool
    @Binding var title:String
    @Binding var content:String
    @Binding var idText:String
    var body: some View {
        NavigationView {
            ZStack{
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack(alignment:.leading){
                    Text("Create new post")
                        .font(Font.system(size:16,weight: .bold))
                    
                    TextField("Title",text: $title)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                        
                    TextField("Write something....",text: $content)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    TextField("idddd....",text: $idText)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                        
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle("New Post",displayMode: .inline)
            .navigationBarItems(leading: leading,trailing: trailing)
        }
    }
    var leading:some View{
        Button {
            
            isPresentedNew = false
        } label: {
            Text("Cancel")
        }

    }
    
    var trailing:some View{
        Button {
            var para:[String:Any] = [:]
             para = ["data":["id":"\(UUID())","title":title ,"content" : content]]
            viewModel.createPost(parameters: para)
            viewModel.fetchPosts()
            isPresentedNew = false
        } label: {
            Text("Post")
        }

    }
    
}

 
