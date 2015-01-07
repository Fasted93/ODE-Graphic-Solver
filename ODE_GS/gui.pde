/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void GUI_draw(GWinApplet appc, GWinData data) { //_CODE_:GUI:419809:
  appc.background(230);
} //_CODE_:GUI:419809:

public void restart_simulation(GButton source, GEvent event) { //_CODE_:button1:887050:
  F1_str = F1_GUI;
  F2_str = F2_GUI;
  simulation_start();
} //_CODE_:button1:887050:

public void textarea1_change1(GTextArea source, GEvent event) { //_CODE_:textarea1:826290:
  F1_GUI = source.getText().trim();
} //_CODE_:textarea1:826290:

public void textarea2_change1(GTextArea source, GEvent event) { //_CODE_:textarea2:713103:
  F2_GUI = source.getText().trim();
} //_CODE_:textarea2:713103:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  if(frame != null)
    frame.setTitle("Sketch Window");
  GUI = new GWindow(this, "GUI", 600, 100, 240, 300, false, JAVA2D);
  GUI.setActionOnClose(G4P.CLOSE_WINDOW);
  GUI.addDrawHandler(this, "GUI_draw");
  label1 = new GLabel(GUI.papplet, 17, 25, 80, 20);
  label1.setText("F1");
  label1.setOpaque(false);
  label2 = new GLabel(GUI.papplet, 12, 101, 80, 20);
  label2.setText("F2");
  label2.setOpaque(false);
  button1 = new GButton(GUI.papplet, 12, 185, 80, 30);
  button1.setText("Restart Simulation");
  button1.addEventHandler(this, "restart_simulation");
  textarea1 = new GTextArea(GUI.papplet, 14, 53, 160, 40, G4P.SCROLLBARS_NONE);
  textarea1.setOpaque(true);
  textarea1.addEventHandler(this, "textarea1_change1");
  textarea2 = new GTextArea(GUI.papplet, 13, 131, 160, 40, G4P.SCROLLBARS_NONE);
  textarea2.setOpaque(true);
  textarea2.addEventHandler(this, "textarea2_change1");
}

// Variable declarations 
// autogenerated do not edit
GWindow GUI;
GLabel label1; 
GLabel label2; 
GButton button1; 
GTextArea textarea1; 
GTextArea textarea2; 

