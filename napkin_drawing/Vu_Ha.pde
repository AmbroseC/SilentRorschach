/*
 * Vu Ha - vha3
 * Napkin drawing
 */

void setup(){
  size(500,500);
  smooth();
  liquid = choice1;
  flvl = fmax;
  offset = strawOffset;
  noCursor();
  frameRate(60);
  
}

// Instance variables
  // colors
color liquid;
color choice1 = color(255,223,128);
color choice2 = color(102,68,0);
color choice3 = color(51,0,0);
color choice4 = color(153,0,77);
color choice5 = color(229,255,255);

// Effects Tracker
ArrayList effects = new ArrayList();

// Straw Variables
int strawOffset = 8;
int offset;
int flvl;
int fmax = 80;
int fmin = 0;

// Color Menu Variables
int xalign = 460;
int yalign = 300;
int boxSize = 40;

// Effect Variables
int dOffset = 8;
int w =  232;

/*
 * === Main Draw Method ===
 */
void draw(){
  
  drawBackground(); 
  drawColorMenu();
      
   // Draw effects  
  if(effects.size() > 0){
    for(int i = 0; i < effects.size(); i++){
      Effect e = (Effect)effects.get(i);
      
      // color blend
      if(effects.size() > 1){
      for(int j = 0; j < effects.size();j++){
        if(j == i){
          continue;
        }
        Effect e2 = (Effect)effects.get(j);
        
        if(dist(e.getX(),e.getY(),e2.getX(),e2.getY()) < 10 && 
            (e.isBlended() == false ||
            e2.isBlended() == false))
        {
          color mix1 = e.getColor();
          color mix2 = e2.getColor();
          float r,g,b,r2,g2,b2,nr,ng,nb;
          color newColor;
         
          
          r = red(mix1);
          g = green(mix1);
          b = blue(mix1);
          r2 = red(mix2);
          g2 = green(mix2);
          b2 = blue(mix2);
               
          nr = max(r,r2) - (min(r,r2)/10);
          ng = max(g,g2) - (min(g,g2)/10);
          nb = max(b,b2) - (min(b,b2)/10);
      
          newColor = color(nr,ng,nb);
                  
          effects.set(i,new Effect(e.getX(),e.getY(),e.getXOffset(),e.getYOffset(),newColor,e.getSpread(),true));
          effects.set(j,new Effect(e2.getX(),e2.getY(),e2.getXOffset(),e2.getYOffset(),newColor,e2.getSpread(),true));
        }
      }
      }
      
      e.drawEffect();
    } 
  }
  
  drawStraw();
  
  // Bounding boxes
  /*
  noFill();
  stroke(0);
  rect(25,65,290,370);
  rect(180,160,230,310);
  */
  
  // Mouse conditionals
  if(mousePressed){
    offset = 0;
    
    // Make effect
    if( ((mouseX > 25 && mouseX < 315) && (mouseY > 65 && mouseY < 435)) ||
        ((mouseX > 180 && mouseX < 410) && (mouseY > 160 && mouseY < 470)) )
    {
       flvl--;
       if(flvl < fmin){
         flvl = fmin;
       }
       if(flvl > fmin){
         effects.add(new Effect(mouseX,mouseY,liquid,0,false));
       }         
    }
    
    
    // Refill
    if(mouseX > 360 && mouseX < 500){
       if(mouseY > 0 && mouseY < 100){
         flvl+=4;
         if(flvl >= fmax){
           flvl = fmax;
         }
       }
    }
    
    
    // Color Change
    if(mouseX > xalign && mouseX < xalign+boxSize){
       // Color choice 1
       if(mouseY > yalign && 
           mouseY < yalign+boxSize){
         liquid = choice1;
       }
       // Color choice 2
       if(mouseY > yalign+boxSize*(3/2) && 
           mouseY < yalign+boxSize*(5/2)){
         liquid = choice2;
       }
       // Color choice 3
       if(mouseY > yalign+boxSize*(5/2) && 
           mouseY < yalign+boxSize*(7/2)){
         liquid = choice3;
       }
       // Color choice 4
       if(mouseY > yalign+boxSize*(7/2) && 
           mouseY < yalign+boxSize*(9/2)){
         liquid = choice4;
       }
       // Color choice 5
       if(mouseY > yalign+boxSize*(9/2) && 
           mouseY < yalign+boxSize*(11/2)){
         liquid = choice5;
       }
       
    }
    
  }
  else{
    offset = strawOffset;
  }
  
  // Reseter
  if(keyPressed)
  {
    if(key == ' '){
      effects.clear();
    }
  }

  
} // --- End of Draw ---

void drawStraw() {
  fill(225);
  noStroke();
  ellipse(mouseX,mouseY,13,13);
  fill(255);
  stroke(0);
  quad(mouseX-5+offset,mouseY-5-offset,
      mouseX+60+offset,mouseY-120-offset,
      mouseX+77+offset,mouseY-92-offset,
      mouseX+5+offset,mouseY+5-offset);
  for(int i=0; i<5;i++){
    ellipse(mouseX+70+offset+i*3,mouseY-105-offset-i*2,28,38);
  }
  quad(mouseX+80+offset,mouseY-132-offset,
      mouseX+120+offset,mouseY-151-offset,
      mouseX+120+offset,mouseY-109-offset,
      mouseX+83+offset,mouseY-94-offset);
  noStroke();
  quad(mouseX+79+offset,mouseY-130-offset,
      mouseX+120+offset,mouseY-150-offset,
      mouseX+120+offset,mouseY-108-offset,
      mouseX+82+offset,mouseY-94-offset);
  stroke(0);
  ellipse(mouseX+120+offset,mouseY-offset-130,32,42);
  if(flvl <= fmin){
    fill(255);
  }
  else{
    fill(liquid);
  }
  ellipse(mouseX+offset,mouseY-offset,13,13);
  
  // fill level indicator
  noStroke();
  quad(mouseX-5+offset,mouseY-2-offset,
      mouseX+(flvl/2)+offset,mouseY-(flvl)-offset,
      mouseX+(flvl*3/4)+offset,mouseY-(flvl*7/8)-offset,
      mouseX+5+offset,mouseY+5-offset);
  
} // -- End of DrawStraw --

void drawColorMenu(){
   // shadow
  int shadowOffset = 4;
  fill(225);
  noStroke();
  rect(xalign+shadowOffset,yalign+shadowOffset,boxSize,boxSize*(11/2));
  
    // choices
  stroke(0);
  fill(choice1);
  rect(xalign,yalign,boxSize,boxSize);
  fill(choice2);
  rect(xalign,yalign+boxSize*(3/2),boxSize,boxSize);
  fill(choice3);
  rect(xalign,yalign+boxSize*(5/2),boxSize,boxSize);
  fill(choice4);
  rect(xalign,yalign+boxSize*(7/2),boxSize,boxSize);
  fill(choice5);
  rect(xalign,yalign+boxSize*(9/2),boxSize,boxSize); 
  
} // -- End of drawColorMenu

void drawBackground(){
  background(color(102,51,0));
  
  // napkin
  fill(175);
  stroke(175);
  quad(10,50,460,14,450,530,10,480);
  fill(255);
  stroke(255);
  quad(10,50,460,14,430,530,-30,450);
  
  // cup
  for (int i=0; i<10; i++){
    color cupColor = color(153-i*10,179-i*10,204-i*10);
    fill(cupColor);
    stroke(cupColor);
    ellipse(475-i*2,0-i*5,300,300);
  }
  fill(255);
  ellipse(460,-20,280,280);
  fill(color(79,119,156));
  stroke(80);
  ellipse(460,-20,270,270);
  fill(liquid);
  stroke(160);
  ellipse(460,-2,237,230);
    
} // --- End of drawBackground ---

class Effect{
  private int x;
  private int y;
  private float xOffset;
  private float yOffset;
  private int spread;
  private float d;
  private color baseColor;
  private float bRed;
  private float bGreen;
  private float bBlue;
  private float redShift;
  private float greenShift;
  private float blueShift;
  private int t;
  private boolean blended;
  
  
  Effect(int x, int y, color baseColor, int spread, boolean blended){
   this.x = x;
   this.y = y;
   this.xOffset = random(dOffset*2)-dOffset;
   this.yOffset = random(dOffset*2)-dOffset;
   this.spread = spread;
   this.d = random(dOffset*2)+dOffset;
   this.baseColor = baseColor; 
   this.bRed = red(baseColor);
   this.bGreen = green(baseColor);
   this.bBlue = blue(baseColor);
   this.blended = blended;
  }
  
  Effect(int x, int y, float xOffset, float yOffset, color baseColor, int spread, boolean blended){
   this.x = x;
   this.y = y;
   this.xOffset = xOffset;
   this.yOffset = yOffset;
   this.spread = spread;
   this.d = random(dOffset*2)+dOffset;
   this.baseColor = baseColor; 
   this.bRed = red(baseColor);
   this.bGreen = green(baseColor);
   this.bBlue = blue(baseColor);
   this.blended = blended;
  }
  
  void drawEffect(){
    noStroke();
    
   if(spread < 90){
     spread++;
   }
   int f = spread/10;
   
   if(blended){
     t = 4;
   }
   else{
     t = 2;
   }
   // spread effect
   //for(int t=0; t < 9; t++){
     redShift = (f-t)*(w-bRed)/9;
     greenShift = (f-t)*(w-bGreen)/9;
     blueShift = (f-t)*(w-bBlue)/9;
   
     baseColor = color(bRed+redShift,bGreen+greenShift,bBlue+blueShift);
     fill(baseColor);
   
     ellipse(x+xOffset,y+yOffset,d+(f-t)*2,d+(f-t)*2);
     ellipse(x,y,d,d);
   //}
  }
  
  int getX(){
    return this.x;
  }
  
  int getY(){
    return this.y;
  }
  
  float getXOffset(){
    return this.xOffset;
  }
  
  float getYOffset(){
    return this.yOffset;
  }

  
  color getColor(){
    return this.baseColor;
  }
  
  boolean isBlended(){
    return this.blended;
  }
  
  int getSpread(){
    return this.spread;
  }
  
  
} // --- End of Effect Class ---
