float[] x = new float[3];
float[] y = new float[3];
float[] speed = new float[3];
boolean[] active = {true, true, false}; // De derde kubus komt later pas

int score = 0;

void setup() {
  size(500, 500);
  textSize(50);
  for (int i = 0; i < 2; i++) { // start met alleen de eerste twee kubussen
    x[i] = random(width);
    y[i] = 0;
    speed[i] = random(4, 6);
  }
  speed[2] = 5; // Snelheid van de derde kubus
}

void draw() {
  background(80, 200, 250);
  if (score >= 15) {
    background(20, 300, 100); //achtergrond kleur veranderd 
  }

  if (score < 50) {
    tekenKubussen(); // kubus spawned als de score niet 50 is
    controleerBotsing(); // check op botsing, dus platform onder raakt een kubus aan
    text("score " + score, 15, 50); // score wordt toegevoegd als het nit 50 is
    rect(mouseX - 50, 450, 100, 20); 
  } else {
    background(0, 255, 0);
    text("Victory", width / 2 - 100, height / 2); // als 50 punten bereikt zijn, victory scherm
  }
}

void tekenKubussen() {
  for (int i = 0; i < 3; i++) {
    if (active[i]) {
      y[i] += speed[i];
      rect(x[i], y[i], 20, 20);
      if (y[i] > height) {
        resetKubus(i, false);
      }
    }
  }
}

void controleerBotsing() {
  for (int i = 0; i < 3; i++) {
    if (active[i] && y[i] + 20 >= 450 && y[i] <= 470 && x[i] + 20 >= mouseX - 50 && x[i] <= mouseX + 50) {
      resetKubus(i, true);
      score++;
      if (score >= 15) {
        active[2] = true; //spawn de derde kubus bij 15 punten
      }
    }
  }
}

void resetKubus(int i, boolean caught) {
  y[i] = 0;
  x[i] = random(width);
  speed[i] = random(1, 10);
  if (!caught && i < 2) { // Alleen opnieuw als de kubus gemist wordt
    score = 0;
    active[2] = false; // Derde kubus wordt gedespawned
    println("Score Reset, Try Again");
  }
}
