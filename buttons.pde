class Button {
    PVector location;
    PVector size;
    String text;
    PFont font;
    float textsize;
    boolean hover = false;
    Runnable action;
    color colour;
    
    Button(PVector location, PVector size, String text, color colour, Runnable run) {
        this.location = location.get();
        this.size = size.get();
        this.text = text;
        this.action = run;
        this.font = createFont("fonts/dejaRegular.ttf", size.y / 4 * 3, true);
        this.colour = colour;
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
        noFill();
        //fill(colour);
        noStroke();
        if(hover) stroke(colour);
        rect(location.x, location.y, size.x, size.y);
        fill(colour);
        noStroke();
        textFont(font);
        textSize(size.y / 4 * 3);
        if(textWidth(text) > size.x) {
            textAlign(LEFT, CENTER);
            text(text, location.x - size.x/2, location.y);
        } else {
            textAlign(CENTER, CENTER);
            text(text, location.x, location.y);
        }
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
    Button button = new Button(new PVector(100, 13 + amount * 25), new PVector(200, 25), sat.name, sat.colorValue, () -> {
        println("Clicked sattelite button for: " + sat.name);
        selectedSattelite = sat;
        selectedSattelite.size=200;
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

void displayInfo(Sattelit sat) {
    fill(sat.colorValue);
    textAlign(RIGHT, CENTER);
    textSize(20);
    text(sat.name, width - 10, 25);
    textSize(17);
    text("Id: " + sat.id, width - 10, 45);
    textSize(13);
    text("Position: " + sat.drawPosition, width - 10, 65);
}
