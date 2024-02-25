class Page extends StatefulWidget {
  Header? header;
  Pagination pagination;
  Navbar navbar;
  String title;
  Content content;

  Page(String title){
    this.title = title;
  }

  State<Page> createState() {
    PageState();
  }

  build(BuildContext context){
    //TODO
  }
}

class _PageState extends State<Page> {
  int pageIndex;
}