PImage bg, sheep, topFence, botFence ;
int bgx, bgy, kx, ky, g, Vky;
int[] pipeX, pipeY; //Declare two arrays
int gameState, score;
void setup()
{
  size(800,600);
  bg = loadImage("./img/bg.png");
  sheep = loadImage("./img/sheep.png");
  botFence = loadImage("./img/botFence.png");
  topFence = loadImage("./img/topFence.png");
  kx = 100;
  ky = 50;
  g = 1; //gravity
  pipeX = new int[5]; //[0,0,0,0]
  pipeY = new int[pipeX.length];
  //populate the array with values
  for (int i =0; i < pipeX.length; i++)
  {
   pipeX[i] = width + 200*i;
   pipeY[i] = (int)random(-350, 0);
  }
  gameState = -1;
}

void draw()
{
  if (gameState == -1)
  {
   startScreen(); 
  }
  else if(gameState==0)
  {
    setBg(); 
    setPipes();
    sheep();
    score();
  }
  else
  {
    text("YOU LOSE", 20,100);
  }
}

void score()
{
  fill(0);
 textSize(32);
 text("Score: " + score, width - 170, 40); 
}

void startScreen()
{
  image(bg, 0,0);
  textSize(40);
  text("Welcome to Flappy Sheep!", 40, 100);
  text("Click the mouse to begin...", 40, 200);
  if(mousePressed)
  {
    ky = height/2;
    gameState = 0;
  }
}
void setPipes()
{
  for (int i =0; i < pipeX.length; i++)
  {
  image(botFence, pipeX[i], pipeY[i]);
  image(topFence, pipeX[i], pipeY[i] + 680);
  pipeX[i]-= 4;
  if(pipeX[i] < -200)
  {
   pipeX[i] = width; 
  }
  if(kx > (pipeX[i]-100) && kx < pipeX[i] + 78)
  {
    if(!(ky > pipeY[i] + 300 && ky < pipeY[i] + 300 + 380))
      {
        gameState = 1;
      }
      else if(kx ==pipeX[i] || kx == pipeX[i] + 1)
      {
       score++; 
      }
  }
 } 
}
 



void sheep()
{
  image(sheep, kx, ky);
  ky = ky + Vky; 
  Vky = Vky + g;
  if(ky > height || ky < 0)
  {
    text("OH NO!!!! THE SHEEP FELL OFF THE SCREEN...", 40,300);
    gameState=1;
  }
  
}

void mousePressed()
{
  Vky = -15;
}
void setBg()
{
  image(bg, bgx, bgy);
  image(bg, bgx +bg.width, bgy);
  bgx = bgx - 1;
  if(bgx < -bg.width)
  {
    bgx = 0;
  }
}
