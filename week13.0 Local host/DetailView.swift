import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentaionMode
    @EnvironmentObject var viewModel:ViewModel
    @State var title = ""
    @State var content  = ""
    
    let item : PostModel
    var body: some View {
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
                
                Spacer()
            }
            .padding()
            .onAppear {
                self.title = item.title
                self.content = item.content
            }
            
        }
        .navigationBarTitle("Edit Post",displayMode: .inline)
        .navigationBarItems(trailing: trailing)
        
    }
    
    var trailing:some View{
        Button {
            //update post
            if title != "" && content != ""{
                let para:[String:Any] = ["data":["id":item.id ,"title":title,"content":content ]]
                viewModel.updatePost(parameters:para)
                viewModel.fetchPosts()
                presentaionMode.wrappedValue.dismiss()
                
            }
        } label: {
            Text("Save")
        }
        
    }
    
}

