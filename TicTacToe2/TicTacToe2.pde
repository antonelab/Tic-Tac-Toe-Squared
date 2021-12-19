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
               
               
char [][] AllLegal= {{'N','E','M'},
                     {'O','G','U'},
                     {'C','A','O'}};
char [][] D = {};
               
char [][][][] Velika = {{A0,A1,A2},{B0,B1,B2},{C0,C1,C2}};    
char[][] VelikaRez = {{' ',' ',' '},
                    {' ',' ',' '},
                    {' ',' ',' '}};  
char Player = 'x'; //koji je igrac trenutno na potezu 
char znak = ' ';  //koji je pobjednicki znak
boolean flag = false;

//-------(dodano)
String player1_name = "";
String player2_name = "";
int move_count = 0;
PImage bgX;
PImage bgO;
int must_play;
int mess = 0; //dodatna varijabla koja govori da li imamo poruku o greski
int name = 1; // ako je 1, postavlja se prvi, ako je 2 postavlja se drugi, ako je 0 onda su svi postavljeni 
//-------

void setup(){

  //-----(povecala na desno)
  size(1000,640); 
  /*  ideja s unosom u datoteci
  if(player1_name.length() == 0 || player1_name.length() > 10 || player2_name.length() == 0 || player2_name.length() > 10){
    String[] player1 = loadStrings("firstPlayerName.txt");
    player1_name = player1[0];
    if(player1_name.length() == 0 || player1_name.length() > 10) e = 0;
    else e = 1;
    String[] player2 = loadStrings("secondPlayerName.txt");
    player2_name = player2[0];
    if(player2_name.length() == 0 || player2_name.length() > 10) e *= 0;
    else e *= 1;
    println(player1_name, player2_name);
  }
  */
  //-----(msm da nije potrebno ovdje)
  //stroke (50);
  strokeWeight (8);
  SetLegal(AllLegal);
  //-----(dodano)
  bgX = loadImage("xx.jpg");
  bgO = loadImage("oo.jpg");
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
       line(w/3+w*i,0+h*j+20,w/3+w*i,h+h*j-20);
       line(2*w/3+w*i,0+20+h*j,2*w/3+w*i,h+h*j-20);
       line(0+w*i+20,h/3+h*j,w+w*i-20,h/3+h*j);
       line(0+w*i+20,2*h/3+h*j,w+w*i-20,2*h/3+h*j);}}
 
 //male popuna
 textSize(30);
  for(int i=0; i<3; i++){
    for(int j=0;j<3; j++){
      for(int k=0; k<3; k++){
        for(int l=0; l<3; l++){
      text(Velika[l][k][j][i],w/3*i+w*k+w/6,h/3*j+h*l+h/5);
    
    }}}}
    
  //velika popuna
  textSize(280);
   for(int i=0; i<3; i++){
    for(int j=0; j<3; j++){
      fill(255,0,0,90);
      text(VelikaRez[j][i],_width/3*i+_width/6,height/3*j+height/3-28);
    }}
  

  if(flag){
    textSize(50);
    fill(100);
    rect(0, 0, width, height);
    
    //-----(dodat pozadinu u ovisnosti o tome tko je pojedio(x/o.jpg))
    if(znak == 'x'){
      background(bgX);
      fill(0);
      text("Game Over\nPobijedio je igrač:\n"+player1_name, width/2, height/3);
    }
    else{
      background(bgO);
      fill(0);
      text("Game Over\nPobijedio je igrač:\n"+player2_name, width/2, height/3);
    }
  }
  
  //-----(dodano)
  textSize(40);
  fill(255);
  if(Player=='x') fill(255,0,0);
  text("X: "+player1_name, 800, height/3);
  fill(255);
  text("   vs   ",800, height/3+50);
  if(Player=='o') fill(255,0,0);
  text("O: "+player2_name, 800, height/3+100);
  fill(255);
  text("Broj poteza: "+move_count, 800, height-100);
  if(mess == 1){
    textSize(20);
    fill(255,0,0);
    text("Potez nije valjan, pokušajte ponovo.", 800, height-150); 
    fill(255);
  }
  } 
  
}

void SetLegal(char [][] polje){
  D = polje;
}

boolean IsLegal(char [][] polje){
  if (D == AllLegal) return true;
  if (polje == D) return true;
  return false;
}

void ChechWinSmall(char[][] Small, char[][] Velika, int i, int j, int stup, int red){
  if (Small[i][j]==Small[(i+1)%3][j] && Small[i][j]==Small[(i+2)%3][j] && Velika[stup][red] == ' ') Velika[stup][red] = Small [i][j];
  else if (Small[i][j]==Small[i][(j+1)%3] && Small[i][j]==Small[i][(j+2)%3] && Velika[stup][red] == ' ') Velika[stup][red] = Small [i][j];
  else if (i==j && Small[i][j]==Small[(i+1)%3][(j+1)%3] && Small[i][j]==Small[(i+2)%3][(j+2)%3] && Velika[stup][red] == ' ') Velika[stup][red] = Small [i][j];
  else if (i+j == 2 && Small[i][j]==Small[(i+1)%3][(j+2)%3] && Small[i][j]==Small[(i+2)%3][(j+1)%3] && Velika[stup][red] == ' ') Velika[stup][red] = Small [i][j];

}

boolean CheckWinBig(int i, int j){


      if(VelikaRez[i][j]==VelikaRez[(i+1)%3][j] && VelikaRez[i][j]==VelikaRez[(i+2)%3][j] && VelikaRez[i][j]!=' ')return true;
      else if(VelikaRez[i][j]==VelikaRez[i][(j+1)%3] && VelikaRez[i][j]==VelikaRez[i][(j+2)%3] && VelikaRez[i][j]!=' ') return true;
      else if(i==j && VelikaRez[i][j]==VelikaRez[(i+1)%3][(j+1)%3] && VelikaRez[i][j]==VelikaRez[(i+2)%3][(j+2)%3] && VelikaRez[i][j]!=' ') return true;
      else if(i+j == 2 && VelikaRez[i][j]==VelikaRez[(i+1)%3][(j+2)%3] && VelikaRez[i][j]==VelikaRez[(i+2)%3][(j+1)%3] && VelikaRez[i][j]!=' ') return true;
    return false;
}

void GameOver(char znakic){
  znak = znakic;
  flag=true;

}


void mousePressed(){
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
 

 
 if(coY>0 && coY<_width/3){stup = 0;mala += "A";}
else if(coY>_width/3 && coY<2*_width/3){stup = 1;mala += "B";}
else {stup=2;mala += "C";}

if(coX>0 && coX<height/3){red = 0; mala += "0";}
else if(coX>height/3 && coX<2*height/3){red = 1;mala += "1";}
else {red=2;mala += "2";}


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



if (Player=='x' && Mala[malastup][malared]==' ' && IsLegal(Mala)){
  Mala[malastup][malared]='x'; 
  Player = 'o'; 
  //-----(dodano)
  move_count++;
  mess = 0;
  
  ChechWinSmall(Mala, VelikaRez, malastup, malared, stup, red);
  if (CheckWinBig(stup, red)) GameOver(VelikaRez[stup][red]);
  if(VelikaRez[malastup][malared] == 'x' || VelikaRez[stup][red] == 'o') SetLegal(AllLegal);
  else SetLegal(Velika[malastup][malared]); 
}

else if(Player=='o' && Mala[malastup][malared]==' ' && IsLegal(Mala)){
  Mala[malastup][malared]='o';
  Player = 'x';
  //-----(dodano)
  move_count++;
  mess = 0;
  
  ChechWinSmall(Mala, VelikaRez, malastup, malared, stup, red);
  if (CheckWinBig(stup, red)) GameOver(VelikaRez[stup][red]);
  if(VelikaRez[malastup][malared] == 'x' || VelikaRez[stup][red] == 'o') SetLegal(AllLegal);
  else SetLegal(Velika[malastup][malared]); 

}
else{
  mess = 1;
}  
 }
}


//-----dodano(unos dok se ne stisne ENTER)
void keyPressed() {
  if (key != CODED) {
    if(key != ENTER && key != BACKSPACE && key != TAB && key != RETURN && key != ESC && key != DELETE){
       if(name == 1 && player1_name.length() < 10) player1_name += key;
       else if(name == 2 && player2_name.length() < 10) player2_name += key;
    }
    if(key == ENTER){
      if(name == 1 && player1_name != "") name = 2;
      else if(name == 2 && player2_name != "") name = 0; 
    } 
  }
} 
