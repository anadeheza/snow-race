# Carrera Nevada

A snow bike racing minigame made in Godot, inspired by the "Carrera de Jetski" minigame from Mundo Gaturro, built to practice using Godot (scenes, signals, autoloads, groups, timers, tweens, UI)

## Gameplay
The first thing you'll see is a start menu, by pressing "Jugar", you enter the game, where a 3-2-1-Ya! countdown plays before the race starts so that you can get ready :)

During the race the time is counted, the idea is to cover the 100000m distance and cross the finish line, the faster you do it, the better

You can move between the 4 lanes of the track with the Up and Down arrow keys to avoid obstacles and collect stars, the goal is to reach the finish line as fast as you can.

- Hitting an obstacle slows you down in different levels depending of the type of the obstacle, the puddles slow you down to half the speed while the snowmen slow you down to a 10% of it, then, it gradually speeds back up but it may become tedious if you go too slow so you better avoid them both

- Stars add to your score and make you faster on the race by adding a 200m/s to the current speed, they are cumulative so, the more stars you get, the faster you go, ergo, the sooner you win

When you reach the finish line, you gradually slow down to a stop, then you'll see a victory panel that shows your final time and score and a "Salir" button that takes you back to the menu

## Running the Game locally

1. Clone or download the repo
2. Open the project folder in Godot (i did it in Godot 4 so it'll be better if you get that version).
3. The project's Main Scene should be `main.tscn` 
4. F5 to run.
