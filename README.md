# Hole in the Wall (HITW)
A remake of MCC's Hole in the Wall mini game. The player can jump, move, crouch, or slide to get through the gaps in the walls. When the game starts, 1-4 walls will come at the player fast and then all except one will dissapear, then the remaining wall will start moving across the platform and the player needs to quickly align themselves to fit through the gap before the wall pushes them off. The objective is to survive as long as possible without being pushed off.

## Week 1:
Added 9 more wall variants, crouch mechanic, and altered the player physics. Added a pause, options, and title screen menus.

## Week 2:
Massive visual progress, added: panorama sky, virtual sun (directionlight3d), ocean planemesh, ocean animation shader, and multiple lighting/quality settings added to the options menu.

## Week 3:
Added 2 game modes: Levels (which currently is the same as infinite on easy difficulty but has a 5 minute timer), and Infinite which has 4 difficulties (easy, medium, hard, and impossible). Also added a custom font to most text, and styled all of the buttons, checkboxes, and sliders.

## Week 4:
Lots of bug fixes, wall queue system that lets multiple walls go accross the platform instead of one per wave like before. Levels; there are 20 levels ranging from level 1 (easiest) to level 20 (hardest) with the difficulty being measured by time needed to survive, wall speed, and amount of walls per wave, also completed levels have a green background and the next level wont unlock until the previous one has been beaten. Textures: added a semi transparent "slime" texture that is supposed to look semi realistic and reworked the sea to look slightly lighter since the brightness of the water doesn't match the lighting. Lastly the biggest feature is a free falling animation combined with wind audio, when the player falls of the platform their mouse will be disconnected and the camera will roll like you have no control while a wind noise starts playing and its loudness is relative to the speed the player is falling.

Demo is available on itch however it is currently in development:
https://alloymvp.itch.io/hitw

## CONTROLS (default keybinds):
- Forwards: W
- Backwards: S
- Left: A
- Right: D
- Jump: SPACE
- Crouch: SHIFT
- Slide: M
- Sprint(toggle): CRTL (not supported in the web build, so its toggled on by default)

This game is being made in the Godot Game Engine

Screenshots ⬇⬇⬇
<img width="1366" height="768" alt="Screenshot 2026-11-16 19 12 17" src="https://github.com/user-attachments/assets/ee567347-bd75-488a-8c31-60a9ddf80d93" />
<img width="1366" height="768" alt="Screenshot 2026-11-16 19 12 28" src="https://github.com/user-attachments/assets/9b73a004-09a2-4b73-80b8-323ceeb7516f" />
<img width="1366" height="768" alt="Screenshot 2026-11-16 19 12 37" src="https://github.com/user-attachments/assets/9c556903-6a5e-4c66-8733-ca58fe1d5423" />
<img width="1321" height="736" alt="Screenshot 2026-11-05 15 23 53" src="https://github.com/user-attachments/assets/13ec1a03-e60c-4116-a32b-14440da8430b" />



Credits:
- Wind audio: https://freesound.org/people/Huggy13ear/sounds/138970/

