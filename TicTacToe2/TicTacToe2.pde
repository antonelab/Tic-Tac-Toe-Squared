import processing.sound.*;
import java.io.BufferedWriter;
import java.io.FileWriter;




char[][] A0 = {{' ',' ',' '},
               {' ',' ',' '},
               {' ',' ',' '}};
char[][] A1 = {{' ',' ',' '},
               {' ',' ',' '},
               {' ',' ',' '}};
char[][] A2 = {{' ',' ',' '},
               {' ',' ',' '},
               {' ',' ',' '}};
char[][] B0 = {{' ',' ',' '},
               {' ',' ',' '},
               {' ',' ',' '}};
char[][] B1 = {{' ',' ',' '},
               {' ',' ',' '},
               {' ',' ',' '}};
char[][] B2 = {{' ',' ',' '},
               {' ',' ',' '},
               {' ',' ',' '}};
char[][] C0 = {{' ',' ',' '},
               {' ',' ',' '},
               {' ',' ',' '}};
char[][] C1 = {{' ',' ',' '},
               {' ',' ',' '},
               {' ',' ',' '}};
char[][] C2 = {{' ',' ',' '},
               {' ',' ',' '},
               {' ',' ',' '}};  
               
//maknuto zbog redukcije               
/*char [][] AllLegal= {{'N','E','M'},
                     {'O','G','U'},
                     {'C','A','O'}};
*/
//char [][] D = {};
               
char [][][][] BigTable = {{A0,A1,A2},{B0,B1,B2},{C0,C1,C2}};    
char[][] BigTableResults = {{' ',' ',' '},
                    {' ',' ',' '},
                    {' ',' ',' '}};  
char player = 'x'; //koji je igrac trenutno na potezu 
char label = ' ';  //koji je pobjednicki label
//----maknuto(zbog redukcije koda)
// boolean flag = false; 

//-------(dodano)
String player1_name = "";
String player2_name = "";
int move_count = 0;
PImage bgXgreen;
PImage bgOpink;
PImage bgXblue;
PImage bgOred;
PImage bgXmagenta;
PImage bgOyellow;
int must_play;
int mess = 0; //dodatna varijabla koja govori da li imamo poruku o greski
int name = 1; // ako je 1, postavlja se prvi, ako je 2 postavlja se drugi, ako je 0 onda su svi postavljeni 
int info = 0; //ako je 1 onda se mora prikazat zaslon s pravilima
int legal_red = 3; //0->1,1->2,2->3, 3->bilo koji
int legal_stup = 3; //0->1,1->2,2->3, 3->bilo koji
//u paru gornje dvoje sluzi da se oznaci polje na koje igrac mora igrat
int time = 0;
int start_time = 0;
String table = ""; //prazno za proizvoljno polje, inače olabela polja kao što je kolega označio 
PFont font;
int stat = 0;
String[] winners = {};
//dodane varijable za boje
color label_color = color(134, 194, 116);
color name_color = color(199, 78, 92);
String bg_theme = "rg"; //red-green combination
int rule_over = 0;
SoundFile music;
//-------

void setup(){

  //-----(povecala na desno)
  size(1000,640); 
  /*  ideja s unosom u datoteci
  if(player1_name.length() == 0 || player1_name.length() > 10 || player2_name.length() == 0 || player2_name.length() > 10){
    String[] player1 = loadStrings("firstplayerName.txt");
    player1_name = player1[0];
    if(player1_name.length() == 0 || player1_name.length() > 10) e = 0;
    else e = 1;
    String[] player2 = loadStrings("secondplayerName.txt");
    player2_name = player2[0];
    if(player2_name.length() == 0 || player2_name.length() > 10) e *= 0;
    else e *= 1;
    println(player1_name, player2_name);
  }
  */
  //-----(msm da nije potrebno ovdje)
  //stroke (50);
  strokeWeight (8);
  SetLegal(3, 3);
  //-----(dodano)
  font = createFont("FFF_Tusj.ttf",50);
  bgXgreen = loadImage("x-green.jpg");
  bgOred = loadImage("o-red.jpg");
  bgXblue = loadImage("x-blue.jpg");
  bgOpink= loadImage("o-pink.jpg");
  bgXmagenta = loadImage("x-magenta.jpg");
  bgOyellow = loadImage("o-yellow.jpg");
  music = new SoundFile(this, "Hozier - NFWMB.mp3");
  music.loop();
}

void draw(){
  if( name == 0){
    background(100);
    textSize(280);
    textAlign(CENTER);
  
    //-----(dodana nova varijabla umjesto koristene width)
    int _width = width - 360;
  
    //-----(svuda umjesto width ide _width)
    //velika
    stroke(28);
    line(_width/3,0+20,_width/3,height-20);
    line(2*_width/3,0+20,2*_width/3,height-20);
    line(0+20,height/3,_width-20,height/3);
    line(0+20,2*height/3,_width-20,2*height/3);
  
    //-----(svuda umjesto width ide _width)
    //male
    stroke(50);
    int w = _width/3;
    int h = height/3;
    for (int i =0; i<3;i++){
       for (int j =0; j<3; j++){
         if(legal_red == i && legal_stup == j){
           stroke(label_color);
         }
           line(w/3+w*i,0+h*j+20,w/3+w*i,h+h*j-20);
           line(2*w/3+w*i,0+20+h*j,2*w/3+w*i,h+h*j-20);
           line(0+w*i+20,h/3+h*j,w+w*i-20,h/3+h*j);
           line(0+w*i+20,2*h/3+h*j,w+w*i-20,2*h/3+h*j);
           stroke(50);  
     }}
 
   //male popuna
   textSize(30);
   for(int i=0; i<3; i++){
     for(int j=0;j<3; j++){
       for(int k=0; k<3; k++){
        for(int l=0; l<3; l++){
          text(BigTable[l][k][j][i],w/3*i+w*k+w/6,h/3*j+h*l+h/5);
    }}}}
    
  //velika popuna
  textSize(280);
  for(int i=0; i<3; i++){
    for(int j=0; j<3; j++){
      fill(name_color, 90);
      text(BigTableResults[j][i],_width/3*i+_width/6,height/3*j+height/3-28);
    }}
  
  //-----(dodano)
  textSize(40);
  fill(255);
  if(player=='x') fill(name_color);
  text("X: "+player1_name, 800, height/3);
  fill(255);
  text("   vs   ",800, height/3+50);
  if(player=='o') fill(name_color);
  text("O: "+player2_name, 800, height/3+100);
  fill(255);
  text("Broj poteza: "+move_count, 800, height-100);
  //-----dodano(sat)
  textSize(18);
  text("Vrijeme potrošeno na prijašnji potez: " + str(time/1000)+ " s", 810, height-50);
  
  if(label != ' '){
    textSize(50);
    fill(100);
    rect(0, 0, width, height);
    
    //-----(dodat pozadinu u ovisnosti o tome tko je pojedio(x/o.jpg))
    if(label == 'x'){
      if(bg_theme == "rg") background(bgXgreen);
      else if(bg_theme == "ym") background(bgXmagenta);
      else if(bg_theme == "pb") background(bgXblue);
      fill(0);
      text("Game Over\nPobijedio je player:\n"+player1_name, width/2, height/3);
      text("u "+move_count+" poteza", width/2, height/3+200);
    }
    else{
      if(bg_theme == "rg") background(bgOred);
      else if(bg_theme == "ym") background(bgOyellow);
      else if(bg_theme == "pb") background(bgOpink);
      fill(0);
      text("Game Over\nPobijedio je player:\n"+player2_name, width/2, height/3);
      text("u "+move_count+" poteza", width/2, height/3+200);
    }
  }
  else if(mess == 1){
    textSize(20);
    fill(label_color);
    text("Potez nije valjan, pokušajte ponovo.", 800, height-150); 
    fill(255);
  }

  } 
  else if(info == 0){
    background(100);
    fill(255);
    textSize(40);
    textFont(font);
    textAlign(CENTER);
    text("DOBRODOŠLI U IGRU!", width/2, height/4);
    textSize(20);
    textAlign(CENTER);
    text("Upišite ime za X playera i stisnite Enter, zatim ponovite postupak za ime O playera.", width/2, height/3);
    strokeWeight(2);
    //sjencanje gumba
    if(overRule(width*3/7, height/2, 150, 50)) fill(168, 168, 168);
    rect(width*3/7, height/2, 150, 50, 20);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text("Pravila", width*3/7+75, height/2+30);
    fill(255);
    textSize(15);
    textAlign(LEFT);
    text("Napomena: Imena neka imaju 10 znakova,  višak znakova se ignorira. ", 50, 4* height/5);
    text("Napomena: Tipkama $, %, & mjenjaju se teme u igri. ", 50, 4* height/5+50);
    strokeWeight (8);
  }
  else if (info ==1){
    background(100);
     textSize(20);
     fill(255);
     textAlign(LEFT);
     text("Cilj ove igre je zauzeti svojim znakom (X ili O)\n        jedan redak, stupac ili dijagonalu na velikoj ili maloj tabeli.", 50, 50);
     text("Svakim je potezom potrebno staviti X ili O na tabelu tako da pokušate ostvariti cilj, \n      ovisno o tome gdje je dozvoljeno odigrati potez.", 50, 120);
     text("Potez treba odigrati u onom polju na velikoj tabli gdje je u prošlom potezu stavljen znak. \n       Obavezno polje za potez je obojano crvenkastom bojom, \n                 kada niti jedno polje nije obojano, svaki je potez dozvoljen. ", 50, 190);
     text("Pobjedom na polju, na velikoj tabli upisuje se veliki znak playera koji je pobjedio na tom polju. \n     Igra je gotova kada se pobjedi znakovima na velikoj tabli (veliki znakovi). ", 50, 290);
     textAlign(CENTER);
     fill(label_color);
     text("Za pokretanje igre, upišite ime prvog playera, pritisnite Enter \n      i zatim opet upišite ime za drugog playera i pritisnite Enter.", 500, 450);
     text("Kada su oba imena upisana, igra starta. \n      Pripazite da imena imaju do 10 znakova, ostali se znakovi zanemaruju. Sretno!", 500, 550); 
     fill(255);
  }
  if(stat > 0){
    background(100);
    fill(255);
    textSize(50);
    textAlign(CENTER);
    if(stat == 3 && name == 0){
      text(winners[0], width/2, 100);
      textSize(30);
      fill(name_color);
      text(winners[1], width/2, 160);
      fill(label_color);
      text(winners[2], width/2, 200);
    }
    else if(stat == 3 && name != 0){
      textSize(20);
      text("Upišite ime playera pa pokušajte ponovo vidjeti statistiku! ", width/2, 100);
    }
    else{
      if(stat == 1) text("Najbolji X playeri:", width/2, 100);
      if(stat == 2) text("Najbolji O playeri:", width/2, 100);
      textSize(30);
      fill(label_color);
      for(int i = 0; i < winners.length && i < 10; i++){
        text(str(i+1)+ ".  " + winners[i], width/2, 160 + i*50);
      }
    }
  }
}

void SetLegal(int red, int stupac){
  //D = polje;
  legal_red = red;
  legal_stup = stupac;
}

boolean IsLegal(int red, int stupac){
  //if (D == AllLegal) return true;
  //if (polje == D) return true;
  if(legal_red == 3 && legal_stup == 3) return true;
  else if(legal_red == red && legal_stup == stupac) return true;
  else return false;
}

void CheckWinSmall(char[][] Small, char[][] BigTable, int i, int j, int stup, int red){
  if (Small[i][j]==Small[(i+1)%3][j] && Small[i][j]==Small[(i+2)%3][j] && BigTable[stup][red] == ' ') BigTable[stup][red] = Small [i][j];
  else if (Small[i][j]==Small[i][(j+1)%3] && Small[i][j]==Small[i][(j+2)%3] && BigTable[stup][red] == ' ') BigTable[stup][red] = Small [i][j];
  else if (i==j && Small[i][j]==Small[(i+1)%3][(j+1)%3] && Small[i][j]==Small[(i+2)%3][(j+2)%3] && BigTable[stup][red] == ' ') BigTable[stup][red] = Small [i][j];
  else if (i+j == 2 && Small[i][j]==Small[(i+1)%3][(j+2)%3] && Small[i][j]==Small[(i+2)%3][(j+1)%3] && BigTable[stup][red] == ' ') BigTable[stup][red] = Small [i][j];

}

boolean CheckWinBig(int i, int j){
  if(BigTableResults[i][j]==BigTableResults[(i+1)%3][j] && BigTableResults[i][j]==BigTableResults[(i+2)%3][j] && BigTableResults[i][j]!=' ')return true;
  else if(BigTableResults[i][j]==BigTableResults[i][(j+1)%3] && BigTableResults[i][j]==BigTableResults[i][(j+2)%3] && BigTableResults[i][j]!=' ') return true;
  else if(i==j && BigTableResults[i][j]==BigTableResults[(i+1)%3][(j+1)%3] && BigTableResults[i][j]==BigTableResults[(i+2)%3][(j+2)%3] && BigTableResults[i][j]!=' ') return true;
  else if(i+j == 2 && BigTableResults[i][j]==BigTableResults[(i+1)%3][(j+2)%3] && BigTableResults[i][j]==BigTableResults[(i+2)%3][(j+1)%3] && BigTableResults[i][j]!=' ') return true;
  return false;
}

boolean CheckSmallFull(int col, int row){
  char[][] Small;
  if(col == 0){
    if(row == 0)Small = A0;
    else if(row == 1)Small = A1;
    else Small = A2;
  }
  else if(col == 1){
    if(row == 0)Small = B0;
    else if(row == 1)Small = B1;
    else Small = B2;
  }
  else{
    if(row == 0)Small = C0;
    else if(row == 1)Small = C1;
    else Small = C2;
  }
  for(int i = 0; i < 3; i++){
    for(int j = 0; j < 3; j++){
      if(Small[i][j] == ' ')return false;
    }
  }
  return true;
}

void GameOver(char labelic){
  label = labelic;
  //----maknuto(msm da je visak)
  //flag = true;
  //-----dodano(pisanje u datoteku)
  File f = new File(dataPath("results.txt"));   //pretpostavljamo da vec postoji file uz projekt
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
    out.println(player1_name + "," + player2_name + "," + labelic + "," + move_count);
    out.close();
  }catch (IOException e){
      e.printStackTrace();
  }
}


void mousePressed(){
  if(label != ' ') return;
 //-----(dodana nova varijabla umjesto koristene width)
 int _width = width - 360;
  
 //-----dodano(zbog toga sto se nista ne dogada dok imena nisu unesena)
 if(name == 0){
 int coX = mouseX;
 int coY = mouseY;
 int red = 0;
 int stup = 0;
 int malastup = 0;
 int malared = 0;
 String mala = "";
 char[][] Mala = {};
 

 if(coY>0 && coY<_width/3){stup = 0; mala += "A";}
 else if(coY>_width/3 && coY<2*_width/3){stup = 1; mala += "B";}
 else {stup=2; mala += "C";}

 if(coX>0 && coX<height/3){red = 0; mala += "0";}
 else if(coX>height/3 && coX<2*height/3){red = 1; mala += "1";}
 else {red = 2; mala += "2";}
 
 switch (mala){
    case "A0":
      Mala = A0;
      if(coY>0 && coY<_width/9){malastup = 0;}
      else if(coY>_width/9 && coY<2*_width/9){malastup = 1;}
      else if(coY>2*_width/9 && coY<3*_width/9){malastup=2;}

      if(coX>0 && coX<height/9){malared = 0;}
      else if(coX>height/9 && coX<2*height/9){malared = 1;}
      else if(coX>2*height/9 && coX<3*height/9){malared=2;}
      break;
    case "B0":
      Mala = B0;
      if(coY>_width/3 && coY<4*_width/9){malastup = 0;}
      else if(coY>4*_width/9 && coY<5*_width/9){malastup = 1;}
      else if(coY>5*_width/9 && coY<6*_width/9){malastup=2;}

      if(coX>0 && coX<height/9){malared = 0;}
      else if(coX>height/9 && coX<2*height/9){malared = 1;}
      else if(coX>2*height/9 && coX<3*height/9){malared=2;}
      break;
    case "C0":
      Mala = C0;
      if(coY>2*_width/3 && coY<7*_width/9){malastup = 0;}
      else if(coY>7*_width/9 && coY<8*_width/9){malastup = 1;}
      else if(coY>8*_width/9 && coY<9*_width/9){malastup=2;}

      if(coX>0 && coX<height/9){malared = 0;}
      else if(coX>height/9 && coX<2*height/9){malared = 1;}
      else if(coX>2*height/9 && coX<3*height/9){malared=2;}
      break;
    case "A1":
      Mala = A1;
      if(coY>0 && coY<_width/9){malastup = 0;}
      else if(coY>_width/9 && coY<2*_width/9){malastup = 1;}
      else if(coY>2*_width/9 && coY<3*_width/9){malastup=2;}

      if(coX>height/3 && coX<4*height/9){malared = 0;}
      else if(coX>4*height/9 && coX<5*height/9){malared = 1;}
      else if(coX>5*height/9 && coX<6*height/9){malared=2;}

      break;
    case "B1":
      Mala = B1;
      if(coY>_width/3 && coY<4*_width/9){malastup = 0;}
      else if(coY>4*_width/9 && coY<5*_width/9){malastup = 1;}
      else if(coY>5*_width/9 && coY<6*_width/9){malastup=2;}

      if(coX>height/3 && coX<4*height/9){malared = 0;}
      else if(coX>4*height/9 && coX<5*height/9){malared = 1;}
      else if(coX>5*height/9 && coX<6*height/9){malared=2;}
      break;
    case "C1":
       Mala = C1;
       if(coY>2*_width/3 && coY<7*_width/9){malastup = 0;}
       else if(coY>7*_width/9 && coY<8*_width/9){malastup = 1;}
       else if(coY>8*_width/9 && coY<9*_width/9){malastup=2;}

       if(coX>height/3 && coX<4*height/9){malared = 0;}
       else if(coX>4*height/9 && coX<5*height/9){malared = 1;}
       else if(coX>5*height/9 && coX<6*height/9){malared=2;}
       break;
    case "A2":
      Mala = A2;
      if(coY>0 && coY<_width/9){malastup = 0;}
      else if(coY>_width/9 && coY<2*_width/9){malastup = 1;}
      else if(coY>2*_width/9 && coY<3*_width/9){malastup=2;}

      if(coX>2*height/3 && coX<7*height/9){malared = 0;}
      else if(coX>7*height/9 && coX<8*height/9){malared = 1;}
      else if(coX>8*height/9 && coX<9*height/9){malared=2;}
      break;
    case "B2":
      Mala = B2;
      if(coY>_width/3 && coY<4*_width/9){malastup = 0;}
      else if(coY>4*_width/9 && coY<5*_width/9){malastup = 1;}
      else if(coY>5*_width/9 && coY<6*_width/9){malastup=2;}

      if(coX>2*height/3 && coX<7*height/9){malared = 0;}
      else if(coX>7*height/9 && coX<8*height/9){malared = 1;}
      else if(coX>8*height/9 && coX<9*height/9){malared=2;}
      break;
    case "C2":
      Mala = C2;
      if(coY>2*_width/3 && coY<7*_width/9){malastup = 0;}
      else if(coY>7*_width/9 && coY<8*_width/9){malastup = 1;}
      else if(coY>8*_width/9 && coY<9*_width/9){malastup=2;}

      if(coX>2*height/3 && coX<7*height/9){malared = 0;}
      else if(coX>7*height/9 && coX<8*height/9){malared = 1;}
      else if(coX>8*height/9 && coX<9*height/9){malared=2;}
      break;
  }

  if (player=='x' && Mala[malastup][malared]==' ' && IsLegal(red, stup)){
    Mala[malastup][malared]='x'; 
    player = 'o'; 
    //-----(dodano)
    move_count++;
    mess = 0;
    time = millis()-start_time;
    start_time = millis();
  
    CheckWinSmall(Mala, BigTableResults, malastup, malared, stup, red);
    if (CheckWinBig(stup, red)) GameOver(BigTableResults[stup][red]);
    if(BigTableResults[malastup][malared] == 'x' || BigTableResults[malastup][malared] == 'o') SetLegal(3, 3);
    else if(CheckSmallFull(malastup, malared)) SetLegal(3, 3);
    else SetLegal(malared, malastup); 
  }

  else if(player=='o' && Mala[malastup][malared]==' ' && IsLegal(red, stup)){
    Mala[malastup][malared]='o';
    player = 'x';
    //-----(dodano)
    move_count++;
    mess = 0;
    time = millis()-start_time;
    start_time = millis();
  
    CheckWinSmall(Mala, BigTableResults, malastup, malared, stup, red);
    if (CheckWinBig(stup, red)) GameOver(BigTableResults[stup][red]);
    if(BigTableResults[malastup][malared] == 'x' || BigTableResults[malastup][malared] == 'x') SetLegal(3, 3);
    else if(CheckSmallFull(malastup, malared)) SetLegal(3, 3);
    else SetLegal(malared, malastup); 
  }
  else{
    mess = 1;
  }  
 }
 else{   //-----dodano(zato da se provjeri li se kliknulo na info igre)
   int coX = mouseX;
   int coY = mouseY;
   if(coX > width*3/7 && coX <width*3/7+150 && coY > height/2 && coY < height/2+50){
     info = 1;
   }
 }
}


//-----dodano(unos dok se ne stisne ENTER)
void keyPressed() {
  if (key != CODED) {
    if(key != ENTER && key != BACKSPACE && key != TAB && key != RETURN && key != ESC && key != DELETE && key != '$' && key != '%' && key != '&'){
       if(name == 1 && player1_name.length() < 10) player1_name += key;
       else if(name == 2 && player2_name.length() < 10) player2_name += key;
    }
    else if(key == ENTER){
      if(name == 1 && player1_name != "") name = 2;
      else if(name == 2 && player2_name != "") {
        name = 0;
        start_time =  millis();
      }
    } 
    else if(key == TAB ) stat = 0;
    else if(key == '$'){
      label_color =  color(134, 194, 116);
      name_color =  color(199, 78, 92);
      bg_theme = "rg";
    }
    else if(key == '%'){
      label_color = color(224, 219, 146);
      name_color = color(168, 112, 224);
      bg_theme = "ym";
    }
    else if(key == '&'){
      label_color = color(230, 172, 229);
      name_color = color(59, 182, 219);
      bg_theme = "pb";
    }
  }
  else if(keyCode == UP) { //gledamo samo x koji su pobjedili
    String[] lines = loadStrings("results.txt");
    String[] line;
    IntDict results = new IntDict();
    for (int i = 0 ; i < lines.length; i++) {
      line = split(lines[i],',');
      if(line[2].equals( "x" ) && results.hasKey(line[0])) results.increment(line[0]);
      else if(line[2].equals( "x" ) && !results.hasKey(line[0])) results.set(line[0], 1);
    }
    results.sortValuesReverse();
    winners = new String[]{};
    for(String s : results.keys()){
       winners = append(winners,  s + "  ->  "+ str(results.get(s)));
    }   
    stat = 1;
  }
  else if(keyCode == DOWN) { //gledamo samo o koji su pobjedili
    String[] lines = loadStrings("results.txt");
    String[] line;
    IntDict results = new IntDict();
    for (int i = 0 ; i < lines.length; i++) {
      line = split(lines[i],',');
      if(line[2].equals( "o" ) && results.hasKey(line[1])) results.increment(line[1]);
      else if(line[2].equals( "o" ) && !results.hasKey(line[1])) results.set(line[1], 1);
    }
    results.sortValuesReverse();
    winners = new String[]{};
    for(String s : results.keys()){
       winners =append(winners,  s + "  ->  "+ str(results.get(s)));
    }   
    stat = 2;
  }
  else if(keyCode == LEFT || keyCode == RIGHT) { //gledamo samo o koji su pobjedili
    String[] lines = loadStrings("results.txt");
    String[] line;
    int x_win = 0;
    int o_win = 0;
    for (int i = 0 ; i < lines.length; i++) {
      line = split(lines[i],',');
      if(keyCode == LEFT){
        if(line[2].equals("x") && line[0].equals(player1_name)) x_win++;
        if(line[2].equals("o") && line[1].equals(player1_name)) o_win++;
      }
      if(keyCode == RIGHT){
        if(line[2].equals("x") && line[0].equals(player2_name)) x_win++;
        if(line[2].equals("o") && line[1].equals(player2_name)) o_win++;
      }
    }
    winners = new String[]{};
    if(keyCode == LEFT) winners = append(winners, "Statistika playera "+ player1_name);
    if(keyCode == RIGHT) winners = append(winners, "Statistika playera "+ player2_name);
    winners = append(winners, "Pobjede kao X player:  " + str(x_win));
    winners = append(winners, "Pobjede kao O player:  " + str(o_win));
    stat = 3;
  }
} 

boolean overRule(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
