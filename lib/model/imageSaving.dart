import 'dart:io';


class Imagesaving{
  String path; 
  File file; 
  String filename;
  String ratio = '';
  String url; 
  String comment;
  String userid;
  String time;
  String imageID;
  String username;
  Imagesaving({this.filename,this.path, this.file, this.ratio, this.url, this.comment,this.userid, this.time, this.username, this.imageID});

  int getlevel(){
    if(ratio == ''){
      return null;
    }else{
      double rate = double.parse(ratio);
      if(rate >= 0 && rate < 16.67){
        return 0;
      }else if(rate >= 0 && rate < 16.67){
        return 1;
      }else if(rate >= 16.67 && rate < 33.34){
        return 2;
      }else if(rate >= 33.34 && rate < 50.01){
        return 3;
      }else if(rate >= 50.01 && rate < 66.68){
        return 4;
      }else if(rate >= 66.68 && rate < 83.35){
        return 5;
      }else if(rate >= 83.35 && rate <= 100){
        return 6;
      }else{
        return null;
      }
    }
  }

  int getcolor(){
    int level = getlevel();
    List<int> colorlist = [0xff29af00, 0xff55b600, 0xff75bd00, 0xff92c300, 0xffadc900, 0xffc7ce00, 0xffe0d300];
    if(level == null){
      return 0xff000000;
    }else{
      return colorlist[level];
    }
  }

}