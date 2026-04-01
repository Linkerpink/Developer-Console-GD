
# Welcome to the console made by Linkerpink!
This is a console / terminal window you can put into your project. This console will be able to run some pre made commands, but you can also add your own commands to it if you please.

## inspiration:
this console / terminal is mostly inspired by the source engine's console, but also a bit by classic terminal windows like command prompt or the linux terminal.

# Getting started:
To get started you have to add the Input Map for opening and closing the Console. 

---
To do this you need to open the project settings and switch to the tab: **Input Map**. 
![enter image description here](https://linkerpink.github.io/public/console/console_open_project_settings.jpg)

When you're there you can add a new action, give it a name and click on **+ Add**. It should appear in the window down below.
 ![enter image description here](https://linkerpink.github.io/public/console/console_input_map_setup.jpg)

Then you can press the **+** button after the name of the new **Input Map** and add a key, mouse button, controller button or touch for the Input.

---

## Add these commands:
 - **console_open** -- Opens the console window
 - **console_close** -- Closes the console window

### Recommended Inputs:

![enter image description here](https://linkerpink.github.io/public/console/console_input_recommended.jpg)

---

# Language support
When importing the language commands are commented out in the code, that's because I can't guess how your language code will work. If you want the language support you can uncomment all the language commands and see which ones you have supported. 

I have used a script called **globals** where I have stuff like language settings. But if you have a dedicated script for languages, you can replace every mention of **globals** with your script.
