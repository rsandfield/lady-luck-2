extends Node

var changelog = [

"""


TEST: 
-

WEBSITE: 
- website : update muffintourlegacy.com to include link to steam store page for MOS
- website : update muffintourlegacy.com to include a link to MTL demo
- website : update muffintourlegacy.com to include a link to public Discord


TODO: 
- background : differentiate between foreground and background objects
- window : unlock resize options for app dimensions? 
- cakeboss / projectile : add (in progress)

- files cleanup : 
--- 


BUGS: 
- cover (wall?) can occur after the player has already died
- defence : check that cover and wall still work after collider change
- muffins : check that collisions are still occurring properly with only mask 1


IDEAS: 
- secondary objectives? (a game within the game?)
- level where muffins attack a boss and the team works together, points given on successful attacks
- plinko type level where people start at the top and slide down the screen, repeat until 1 remaining
- candy crush type game where players control what the streamer can do
- a !chomp command that muffins can attack each other
- glass breaking animation on !cover
- shield shattering animation on !wall
- flaming muffin skin
- golden muffin skin
- amish mandalorian helmet




p2: ( low priority / visual issues )
- prompt before exiting the game?
- reset everything on user clicking disconnect? 
- show how many jump/wall/cover/zoom are remaining
- display how much time for cover/wall is remaining
- level / town : update fog layer
- update character chat bubble sprites and animation
- 

p1: ( high priority / not blocking )
- website : update muffintourlegacy.com to include link to steam store page for MOS
- website : update muffintourlegacy.com to include a link to MTL demo
- 

p0: ( blocking / steam release )
- 


2024.10XX.0X: 
- 

2024.10XX.0X: 
- 


- godot : build version 4.2.X
- godot : build version 4.1.1
- godot : build version 3.6.beta2
- godot : build version 3.5.3
- godot : build version 3.5.2


HAVE YOU UPDATED THE BUILD VERSION AND DISABLED DEBUG?



2024.11XX.0X: 
- Final Version



2024.1028.01: 
- dark: added new level
- fort: added new level
- shop: added an easter egg from the mtl demo... quack quack

2024.0428.01: 
- gates: new castle ramparts background with minor perspective change
- shop: fix an issue caused by particles loading in a thread related to projectiles
- debug: disabled hidden debug button

2024.0422.01: 
- debug: re-enabled achievement tracking
- steam: added gate achievements

2024.0418.01: 
- gate: updated bucket projectile gradient
- gate: animated sun background object

2024.0416.01: 
- cleanup: removed some unused art assets
- menu: added emilio entry in the cast section
- gate: added emilio dialog
- gate: background assets and platforms
- gate: emilio and catapult assets
- gate: catapult and bucket triggers
- gate: implemented proper round sequence
- gate: sound effects and music added 

2024.0218.01: 
- shop: changed music track
- shop: removed duplicate particle objects on marvin
- shop: moved object creation of the cauldron fire to the effects loading function
- muffins: minor change to try and address a race condition between moving and deleting muffins
- debug: disabled hidden debug button

2024.0215.01: 
- bug fix: additional checks added to catch attempts to destroy muffins twice
- bug fix: countdown timer less than 10 to always have a leading zero when changing it in afk mode
- menu: lore description scroll will now reset to start position when the page is changed
- shop: changed load order for another particle object to occur after scene load

2024.0212.03: 
- debug: npc muffins names changed to generic identifier
- debug: gave the launch debug buttons a little visual improvement
- forest: changed delay between cakeboss attacks from 2 seconds to 3 seconds
- forest: added a delay between the start of a round and the first projectile 
- castle: changed bearclaw loading method to try and fix an asyncronous shader issue
- castle: moved bearclaw dialog box location to the left from the right
- shop: changed particle implementation to load after scene has started
- shop: new background assets and positioning

2024.0212.02: 
- forest: reenabled cakeboss projectile attack

2024.0212.01: 
- bug fix: resolved an issue that could cause the round counter to go up by two 
- voting: minor fix to properly display the up next selected level 
- shop: added trigger for marvin dialog on first entry

2024.0209.01: 
- shop: added new marvin sprites
- shop: added new cauldron sprites
- shop: added background assets
- shop: added music audio track 
- shop: added sound effects to multiple animations
- shop: implemented animations and full round sequence
- achievements : added shop achievements
- menu: created modular cast nameplates 
- twitch: implemented a serverless connecton method
- forest: added teleportation sound to molly smoke animation
- forest: adjusted sound levels for cake boss projectiles

2024.0105.02: 
- bug fix: made a change to attempt to keep the topping and muffin animations in sync

### note: also include change list from 2023.1109 build as that has not been posted outside of dev
2023.0105.01: 
- shop: added template for new level
- shop: new marvin sprites and animations
- shop: new cauldron sprites and animations

2023.1109.01: 
- godot : build version 3.5.3
- feature : added afk mode
- cakeboss : projectile attack added 

2023.1103.01: 
- commands: added shortened ! commands, !j, !z, !c, !w for jump/zoom/cover/wall

2023.1031.01: 
- bug fix: sewer music bus changed to music from master
- bug fix: made the foreground bricks layers visible again
- croissant: removed spin sound on third bounce before dive and destroying platform
- boomerang: shortened sound when two boomerang collide 
- sound: various sound level balance changes

2023.1013.01: 
- release candidate : all debug feature have been disabled
- build : no other changes 
- steam : achievement icons for sewer 1x/10x/100x have been updated 

2023.1005.01: 
- debug enabled : this has DEBUG launch buttons enabled for testing
- music : added upper and lower level tracks for music 

2023.1004.01: 
- debug enabled : this is a DEBUG build for testing new features
- achievements: removed some overlay functions

2023.1003.01: 
- debug enabled : this is a DEBUG build for testing new features
- achievements : refactored and have been ENABLED in this build
- sound : implemented for most actions in sewer level
- music : added track for sewer level  
- sewer : cogs seen during level transition updated 

2023.0928.01: 
- debug enabled : this has DEBUG launch buttons enabled for testing
- croissant : updated jump and dive  animations for level transitions
- bubbles : blue bubbles spawn on the lower level 
- vote : added !4 command to invoke !vote 4 properly

2023.0921.01: 
- debug enabled : this has DEBUG launch buttons enabled for testing
- sewer: croissant animations implemented
- sewer: level transitions enabled

2023.0804.01: 
- godot : build version 3.5.2
- sewer : updated background assets
- sewer : elevator assets for upper and lower levels
- sewer : added croissant attack animation

2023.0706.01:
- godot : build version 3.5.2
- steam : removed steam code

2023.0705.03:
- godot : build version 4.0.3

2023.0705.02:
- steam : reimported package and refactored control scripts

2023.0705.01:
- godot : build version 3.5.2
- steam : minor changes to steam code

2023.0629.04: 
- godot : build version 3.6.beta2

2023.0629.03: 
- test : 3.5.1

2023.0629.02: 
- test : debug export

2023.0629.01: 
- test : latest

2023.0621.01: 
- debug enabled : this is a DEBUG build for testing new features
- achievements : have been DISABLED in this build
- steam : updated to include the latest steam_api64.dll
- interface : added a single player game control screen
- game : added tic tac toe 
- shader : test waterfall shader for sewer level

2023.0613.01: 
- debug disabled : hid all debug controls, this is a RELEASE candidate build
- achievements : enabled and available for video and forest / town / castle levels
- blocked new features, sewers / etc
- bug : fixed an issue where the commands info when viewed in town would distort the fog layer

2023.0526.01: 
- debug enabled : this is a DEBUG build for testing new features
- godot : update to build version 3.5.2
- sewer : added boomerang, poison, and debris
- sewer : implemented game start and end triggers
- castle : various changes try and fix an intermittent crash
- voting : added placeholder to select sewer level to allow for testing
- croissant : added dialog at game start
- achievements : added framework for interfacing with steam
- achievements : added one achievement for watching the intro video
- achievements : added 1x/10x/100x completion for all game types
- achievements : added 100x/40kx/1Mx muffin kills achievements

2023.0510.01: 
- debug enabled : this is a DEBUG build for testing new features
- muffins : blocked user commands from processing after being destroyed but before freeing object
- muffins : changed shape to be polygon instead of square 
- muffins : disabled the defence collider if wall or cover isn't enabled to improve performance
- muffins : removed layer 1 from colliders to improve performance  
- castle : adusted the background position
- sewers : basic croissant implementation
- sewers : transitioning background with physics and elevators simulating motion


2023.0227.01: 
- twitch : changed client id to use "Muffins On Stream" app
- controls : changed command info button default cursor shape to help 
- sounds : removed duplicate clicking sound on entering the menu
- links : removed export var image and replaced with child texturerect
- commands help : reenabled hide the lightning when outside of the info box
- menu / channel : block changing the channel name if already connected 
- menu / channel : now checking for valid channel before confirmation dialog box instead of after
- twitch / network : updated authentication to use token username instead of default botname

2023.0220.01: 
- menu / links : updated demo link icon

2023.0213.01: 
- website: disabled connection announcement and created opt-in (currently hidden and disabled)
- arena / debug : disabled the ability to manually launch muffins, enabled with debug builds only 
- game / dialog : changed the popup to occur at the start of a round and only once per level
- sound / all : minor changes to db levels and overall sound balance
- menu / links : updated discord link to direct to the new muffin tour legacy server
- menu / links : added a link to muffin tour legacy demo on itch.io 
- menu / links : removed twitch link
- menu / connect : added a dialog box telling the user a browser will open
- menu / sounds : added a click sound to buttons if they were not playing a page turn sound 
- controls / sounds : also added click sound to game control buttons ( menu / start / etc. )


2023.0208.01: 
- intro / video : updated to the latest version with sound and voiceover
- sound / castle / projectile : added bounce sound for lightning ball
- sound / town / projectile : added bounce sound for donut ball
- menu / cast / bearclaw : fixed typo in header
- menu / guide : added entries for common player actions
- dialog : molly, donut, and bear claw have dialog boxes have been added

2023.0203.02: 
- menu / guide : removed the empty command window that was being displayed 

2023.0203.01: 
- added menu button to the game over summary page 
- enabled keyboard "esc" on voting and summary dialogs to close or go to the menu respectively
- added sound button in game next to menu to be able to adjust the volume during a round
- added command information in-game accessible with a button on the right side of the screen
- added help buttons next to the command information that show command animations

2023.0130.02: 
- bug : fix an issue with muffin commands to work with display names

2023.0130.01: 
- bug : fixed an issue causing !join to not work during countdown
- muffins : change to allow user names to contain capitalization, variable username to display-name 

2023.0129.01: 
- bug : fixed an issue which was causing !vote to not work

2023.0127.01: 
- exe / icon : update the image being used for the executable file
- website : added error catching to notify users that ad blockers might cause authentication to fail
- menu / connect : added connection state information and allowed user to cancel or disconnect 

2023.0126.01: 
- bug : will now allow people with underscore "_" characters to connect properly  
- debug : added code and functions to actively change sound levels when debug enabled

2023.0125.01: 
- bug : fixed an issue that allowed people to join while the game was in progress
- menu / arena : changed the default to hide players that are joining while in the menu
- menu / options : added a toggle here to change whether players can be seen in the menu 
- music / forest : updated track to remove break and adjust starting position
- menu / team : added a watermark at the bottom of the page of the current build version

2023.0113.01: 
- menu / connect : added a tooltip and blocked connect if channel string is empty
- menu / guide : added basic information about playing the game 
- menu / team : added image and updated positions of credits and note
- town / donut : disabled debug text buttons
- muffins : changed z-index of name bar from relative +1 to 0
- game over : fixed the positioning of level select buttons
- game summary : fixed an issue where twitch profile images were set incorrectly
- debug / launch : hidden by default and requires three clicks to show

2022.1222.01: 
- menu : added page turning sounds
- menu / setup : added curtains and under development level buttons
- menu / setup : curtain now drops before going up  
- menu / links : added batterycake image
- menu / team : added shelf above team credits
- menu / cast : realigned character frames
- menu / cast / donut : character background updated
- menu / cast / marvin : character background updated
- menu / cast / cake boss : character background added
- menu / cast / muffins : random rows of muffins now walk across shelves
- forest / molly : changed teleportation effect into a single animation
- forest / molly : teleport fade changed to 0.2 seconds from 0.3 seconds
- music : updated music tracks for all levels, menu/forest/town/castle
- voting : updated level select buttons displayed at the end of a round
- muffins / names : added a black border to make the text slightly more crisp

2022.1129.01: 
- intro: changed the initial image to match the first frame of the video
- menu: added a toggle to hide muffins on menu screen
- menu: changes to section headers and button styles
- menu / cast : updated character selection buttons

2022.1113.01: 
- menu: updated ribbons and button links
- intro: added fading effect when played through completely including music

2022.1020.01: 
- rebuild completed
- level 2: dough collisions
- level 2: dough scaling on impact
- level 3: minor changes to embers 
- game over: changed some fonts
- added loading screen for transitions

2022.1018.01: 
- Complete

2022.0820.01: 
- Rebuild


"""

]


