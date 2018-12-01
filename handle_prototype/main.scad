// Prototype for a parametric handle
use <curved_neck.scad>
use <grip.scad>

grip_len = 120;
grip_dia = 40;


union() {
    curved_neck();
    grip_clipped(len = grip_len, dia = grip_dia);
}
