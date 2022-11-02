class Button {
    PVector location;
    PVector size;
    String text;
    PFont font;
    float textsize;
    boolean hover = false;
    Runnable action;
    
    Button(PVector location, PVector size, String text, Runnable run) {
        this.location = location.get();
        this.size = size.get();
        this.text = text;
        this.action = run;
        this.font = createFont("fonts/dejaRegular.ttf", size.y / 4 * 3, true);
    }
    
    void update() {
        //Mouse hover?
        hover();
        
        //Click?
        if (mouseClick) {
            if (hover) {
                ownAction();
                action.run();
                mouseClick = false;
            }
        }
        
        //Draw button
        draw();
    }
    
    void ownAction() {
    }
    
    void draw() {
        fill(255);
        if(hover) fill(200);
        rect(location.x, location.y, size.x, size.y);
        fill(0);
        noStroke();
        textFont(font);
        textSize(size.y / 4 * 3);
        textAlign(CENTER, CENTER);
        text(text, location.x, location.y);
        textAlign(LEFT);
    }
    
    void hover() {
        if (mouseX >= location.x - (size.x / 2) && mouseX <= location.x + (size.x / 2) && mouseY >= location.y - (size.y / 2) && mouseY <= location.y + (size.y / 2)) {
            hover = true;
        } else {
            hover = false;
        }
    }
}

ArrayList<Button> buttons = new ArrayList<Button>();
int amount = 0;

void setupButton(Sattelit sat) {
    println(sat.name);
    if(sat == null) return;
    Button button = new Button(new PVector(100, 25 + amount * 25), new PVector(200, 25), sat.name, () -> {
        println("Clicked sattelite button for: " + sat.name);
    });
    buttons.add(button);
    amount++;
}
void displayButtons() {
    rectMode(CENTER);
    for(int i = 0; i < buttons.size(); i++) {
        buttons.get(i).update();
    }
}
