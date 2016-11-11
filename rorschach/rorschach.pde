int state;

void setup() {
  state = 0;
}

void draw() {
  switch(state) {
    case 0:
      title();
      break;
    case 1:
      game();
      break;
  }
}

void title() {
}

void game() {
}