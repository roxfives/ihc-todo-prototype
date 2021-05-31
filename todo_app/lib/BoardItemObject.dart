class BoardItemObject{

  String title;

  BoardItemObject({required this.title}){
    if(this.title == null){
      this.title = "";
    }
  }

}