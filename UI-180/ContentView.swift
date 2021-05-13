//
//  ContentView.swift
//  UI-180
//
//  Created by にゃんにゃん丸 on 2021/05/13.
//

import SwiftUI

struct ContentView: View {
    @State var txt = ""
    @State var todolist : [String] = []
    @State var showAlert = false
    var body: some View {
        VStack{
            
            Text("New Sceduel")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            HStack{
                
                TextField("Enter Task", text: $txt)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    
                    todolist.append(txt)
                    txt = ""
                    UserDefaults.standard.set(todolist, forKey: "Key")
                    
                }, label: {
                   
                        Text("Add")
                            .foregroundColor(.white)
                            .background(
                            
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 50, height: 35)
                                    .foregroundColor(.black)
                                    
                            
                            )
                            
                        
                        
                })
                .disabled(txt == "")
                .opacity(txt == "" ? 0.8 : 1)
                .padding(.leading,5)
                
                
            }
            
            
            HStack{
                
                
                Text("ToDoList")
                    .font(.title)
                    .fontWeight(.heavy)
                
                Spacer()
                
                
                EditButton()
                
                    
                    
            }
            .padding(.top,20)
            
            
            List{
                
                ForEach(todolist,id:\.self){index in
                    
                    Text(index)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                }
                .onDelete(perform: { indexSet in
                    todolist.remove(atOffsets: indexSet)
                    UserDefaults.standard.set(todolist, forKey: "Key")
                })
                .onMove(perform: { indices, newOffset in
                    todolist.move(fromOffsets: indices, toOffset: newOffset)
                    UserDefaults.standard.set(todolist, forKey: "Key")
                })
                
            }
            .listStyle(PlainListStyle())
            
           
            
            
            Spacer()
        }
        .padding()
        .onAppear(perform: {
            guard let defaultitem = UserDefaults.standard.array(forKey: "Key") as? [String] else{
                
                
                return
                
            }
            todolist = defaultitem
            
            
        })
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
