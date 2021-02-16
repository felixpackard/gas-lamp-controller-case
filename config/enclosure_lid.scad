/***********************
* CONFIG / SCREEN
* The file defines all config variables used by the enclosure lid module
***********************/

include <_config.scad>
include <screen.scad>

lid_thickness = wall_thickness + 1.5;

button_cutout_radius = 8 / 2;
button_spacing = 14;

lid_position = [0, 0, board_dimensions[2] + standoff_height + height_extension + wall_thickness];
lid_center = [pcb_dimensions[0] / 2, (pcb_dimensions[1] + 5) / 2, -2];