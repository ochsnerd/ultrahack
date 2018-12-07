// Prototype for a parametric handle
use <curved_neck.scad>
use <grip.scad>
use <attachments.scad>
// use <helpers.scad>

// External parameters
// Grip dimensions
grip_len = 120;
grip_dia = 37;

// Attachments
// 0 : nothing
// 1 : 3/8 UNC insert
// 2 : ball
attachments = [2,2,1,0,2];

attachment_spots =
   [[ 35,  30, -76],
    [ 19, -12,   2],
    [-35,  30, -76],
    [-19, -12,   2],
    [  0, -25,   0]];

attachment_orientations =
   [[  0,  90,   0],
    [  0,  90,   0],
    [  0, -90,   0],
    [  0, -90,   0],
    [ 90,   0,   0]];


add_attachments(attachments, attachment_spots, attachment_orientations) {
    union() {
        curved_neck();
        grip_clipped(len = grip_len, dia = grip_dia);
    }
}
