# Exercise-05a-FPS

Exercise for MSCH-C220

A demonstration of this exercise is available at [https://youtu.be/0sw4W00UjdY](https://youtu.be/0sw4W00UjdY)

This exercise is a chance to play with Godot's 3D capability for the first time. We will be creating a simple first-person-controlled character and adding it to a simple 3D scene.

Fork this repository. When that process has completed, make sure that the top of the repository reads [your username]/Exercise-05a-FPS. *Edit the LICENSE and replace BL-MSCH-C220-F22 with your full name.* Commit your changes.

Clone the repository to a Local Path on your computer.

Open Godot. Import the project.godot file and open the "FPS" project.

This exercise is loosely based on the Godot 101: Intro to 3D tutorial by KidsCanCode. It was released as a [YouTube video](https://youtu.be/_55ktNdarxY), and a similar tutorial [has also been written out](http://kidscancode.org/godot_recipes/basics/3d/101_3d_07/). Please follow the directions I provide in this exercise, but if you get stuck or need additional context, feel free to consult the KidsCanCode tutorial.

In res://Game.tscn, I have provided a starting place for the exercise: the scene contains a parent Spatial node (named Game) and a StaticBody Ground node (containing a MeshInstance Plane and a CollisionShape)

Right-click on the Game node, and Add Child Node. Choose KinematicBody (not KinematicBody2D!). Name the new node Player

Right-click on the Player node, and Add Child Node. Choose CollisionShape. Name the new node Body

Right-click on the Player node again, and Add Child Node. Choose CollisionShape. Name the new node Feet

Right-click on the Player node again, and Add Child Node. Choose Spatial. Name the new node Pivot

Right-click on the Pivot node, and Add Child Node. Choose Camera.

Select the Body node. In the Inspector, select a new shape: New CapsuleShape. Edit the Shape; set the Radius to 0.5 and make sure the Height is 1. Go back to the Inspector for the Body node, and open Spatial->Transform. Set Translation->y to 1.1 and Rotation Degrees->x to 90

Select the Feet node. In the Inspector, select a new shape: New BoxShape. Edit the Shape: set the extents to x:0.4, y:0.1, z:0.4. Go back to the Inspector for the Foot node, and open Spatial->Transform. Set Translation->y to 0.2

Select the Pivot node. In the Inspector, Spatial->Transform, set Translation->y to 1.6

Select the Camera node. In the Inspector, set Current to On

Run the project, and make sure everything looks correct. Your perspective should be about two meters above a (relatively) small blue rectangle.

In the Project menu->Project Settings, select the Input Map tab. As previously, set up WASD keyboard controls to the following mappings: forward, left, back, right. Close Project Settings

Right-click on the Player node, and Attach Script. Change the Template to Empty, and set the Path to res://Player/Player.gd

In the resulting Player.gd script, type the following:

```
extends KinematicBody

onready var Camera = $Pivot/Camera					# the camera attached to the player (in a "pivot" node so we rotate the entire player left and right but only move its "head" up and down)

var gravity = -30									# downward (-y) acceleration applied on every frame
var max_speed = 6									# velocity multiplier applied to every movement
var mouse_sensitivity = 0.002						# translating the mouse XY coordinates into angular (radian) movement
var mouse_range = 1.2								# Clamp to about a 140 degree range of motion

var velocity = Vector3()

func get_input():
	var input_dir = Vector3()						# Collect all the inputs into a single vector
	if Input.is_action_pressed("forward"):			# all the inputs are directions relative to where the camera is currently facing
		input_dir += -Camera.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += Camera.global_transform.basis.z
	if Input.is_action_pressed("left"):				# strafe left and right
		input_dir += -Camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += Camera.global_transform.basis.x
	input_dir = input_dir.normalized()				# just get the unit vector (length of 1), which essentially just returns the direction
	return input_dir

func _unhandled_input(event):
	if event is InputEventMouseMotion:											# if the mouse has moved
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)					# up-down motion, applied to the $Pivot
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)	# make sure we can't look inside ourselves :)
		rotate_y(-event.relative.x * mouse_sensitivity)							# left-right motion, applied to the Player

func _physics_process(delta):
	velocity.y += gravity * delta					# apply gravity
	if is_on_floor():
		velocity.y = 0
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x					# just get the XZ components of the velocity (the y is handled purely by gravity)
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)

```
(make sure to indent using tabs instead of spaces)

If you run the game again, you should now be able to move forward, back, strafe left and right, and look around using the mouse. If you leave the platform, you should fall.

Finally, we will add a weapon. Right click on the Pivot node, and Add Child Node. Choose MeshInstance. Name the new node Gun. Select the Gun node.

In the Assets folder (in the FileSystem panel), you should see shotgun.obj. Drag that file to the Mesh property in the Inspector

Under Spatial->Transform, set Translation->x: 0.2, y: -0.15, z: -0.3. Set Rotation Degrees->x: 180 and Rotation Degrees->z: 180. Set Scale->x: 8, y: 8, z: 8

If you run the game again, you should now be holding a blue gun.

Quit Godot. In GitHub desktop, add a summary message, commit your changes and push them back to GitHub. If you return to and refresh your GitHub repository page, you should now see your updated files with the time when they were changed.

Now edit the README.md file. When you have finished editing, commit your changes, and then turn in the URL of the main repository page (https://github.com/[username]/Exercise-0a-FPS) on Canvas.

The final state of the file should be as follows (replacing the "Created by" information with your name):
```
# Exercise-05a-FPS

Exercise for MSCH-C220

The first Godot 3D exercise, a simple first-person-controlled character.

## Implementation

Built using Godot 3.5

The shotgun model is from the [Weapon Pack](https://kenney.nl/assets/weapon-pack) at kenney.nl.

## References

None

## Future Development

None

## Created by 

Jason Francis
```
