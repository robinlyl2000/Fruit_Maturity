import 'dart:io';


class Imagesaving{
  String path; 
  File file; 
  String filename;
  double ratio = 0.0;
  String url; 
  String comment;
  String userid;
  String time;
  String imageID;
  String username;
  String tag;
  int likenum;
  Imagesaving({this.likenum,this.filename,this.path, this.file, this.ratio, this.url, this.comment,this.userid, this.time, this.username, this.imageID, this.tag});

  int getlevel(){
    if(ratio == 0.0){
      return null;
    }else{
      if(ratio >= 0 && ratio < 16.67){
        return 1;
      }else if(ratio >= 16.67 && ratio < 33.34){
        return 2;
      }else if(ratio >= 33.34 && ratio < 50.01){
        return 3;
      }else if(ratio >= 50.01 && ratio < 66.68){
        return 4;
      }else if(ratio >= 66.68 && ratio < 83.35){
        return 5;
      }else if(ratio >= 83.35 && ratio <= 100){
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

  String gettime(){
    var a = time.split('   ');
    return a[0]+'\n'+a[1];
  }

}