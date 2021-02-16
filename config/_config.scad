/***********************
* PROJECT CONFIG
* This file defines all project config and global config variables
***********************/

include <../utils/arduino.scad>

explode = true;
show_enclosure = true;
show_arduino = true;
show_screen = true;
show_lid = true;

resolution = 100;

/***********************
* GLOBAL CONFIG VARIABLES
***********************/
wall_thickness = 3;
height_extension = 30;
standoff_height = 5;

board_position = boardPosition();
board_dimensions = boardDimensions();
pcb_position = pcbPosition();
pcb_dimensions = pcbDimensions();