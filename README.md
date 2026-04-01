
# Developer Console for Godot
This is a developer console / terminal window you can put into your Godot project. This console will be able to run some pre made commands, but you can also add your own commands to it if you please.

## inspiration:
this console / terminal is mostly inspired by the Source Engine's Developer Console, but also a bit by classic terminal Windows like command prompt or the Linux terminal.

# Getting started:

## Adding Developer Console as a Global Scene
Adding a global script or scene in Godot is a way for a script or scene to run in every scene in the entire project. The console is supposed to be runnable in every scene so you won't have to add it manually in every scene.
To add the Development Console as a Global Scene go to: **Project/Project Settings/Globals**.
![Open Project Settings](https://linkerpink.github.io/public/console/console_open_project_settings.jpg)

![Make Global](https://linkerpink.github.io/public/console/make_global.jpg)


As the path you'll have to choose the path to the **console.tscn** scene. Default path = **res://console/assets/console.tscn**. Make sure you don't accidentally add the **console.gd** script. The console relies on everything that's in the scene, like the console window and layout.

As the name you can do whatever you want, then click on **+ Add**

## Adding Inputs in Input Map
To get started you have to add the Input Map for opening and closing the Console.  To do this you need to open the project settings and switch to the tab: **Input Map**. 
![Open Project Settings](https://linkerpink.github.io/public/console/console_open_project_settings.jpg)

When you're there you can add a new action, give it a name and click on **+ Add**. It should appear in the window down below.
 ![enter image description here](https://linkerpink.github.io/public/console/console_input_map_setup.jpg)

Then you can press the **+** button after the name of the new **Input Map** and add a key, mouse button, controller button or touch for the Input.

---

## Add these commands:
 - **console_open** -- Opens the console window
 - **console_close** -- Closes the console window
 - **console_enter** -- Enters the user's input to the Console

### Recommended Inputs:

![Recommended Inputs](https://linkerpink.github.io/public/console/recommended_inputs.jpg)

---
# Adding Custom Commands:
Let's say that you'd want to make a custom command that isn't in the Developer Console yet, you can do that. This example will show a simple command that will print epic things to the screen.

First you'll have to create a new **Command** Resource file. To do this, go to the console folder and then to the commands folder. Right click the commands folder, hover over: **+Create New** and then click on **Resource**.
![Recommended Inputs](https://linkerpink.github.io/public/console/add_resource.jpg)

Once you've clicked on **Resource**, search for **command** in the search bar. Then click on **Create**.
![Recommended Inputs](https://linkerpink.github.io/public/console/command_resource.jpg)

Once you did that you'll have to give your new command a name and click on **Save**.
![Recommended Inputs](https://linkerpink.github.io/public/console/resource_name.jpg)

Double click your new command in the **commands** folder. In the inspector (usually on the right) you'll see a few values you can fill in.
 - **Name** -- The name of the command. This is also what the user has to fill in the Console to activate the command.
 - **Description** -- The basic description of the command. This will be the text that shows up when the user sees this when using the command: **commands**.
 - **Detailed Explaination** -- A more detailed explaination of the command. Shows up when the user enters the command: **explain** *insert command here*.
 - **Function to Trigger** -- This is the name of the function you want to trigger inside if the **console.gd** script. This can be any function that doesn't use parameters. For this example we will make something very simple, using the already existing function: **print_to_console**. You can add your new function anywhere inside of the **console.gd** script, but I'd recommend putting it inside of the **Game Specific Commands** region. That will help it be more organized.


![Recommended Inputs](https://linkerpink.github.io/public/console/making_epic_command.jpg)

once you did everything correctly, it should work automatically inside of the Console.
## End result:
![Recommended Inputs](https://linkerpink.github.io/public/console/epic_console_command.gif)


# Language support
When importing the language commands are commented out in the code, that's because I can't guess how your language code will work. If you want the language support you can uncomment all the language commands and see which ones you have supported. 

I have used a script called **globals** where I have stuff like language settings. But if you have a dedicated script for languages, you can replace every mention of **globals** with your script.
