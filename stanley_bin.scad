$fn=120;

x = 1;
y = 1;


BIN_W=40;
BIN_L=55;
BIN_H=40.8;
FOOT_H=3;
FOOT_R=15/2;


module rounded_square(dim, r)
{
    offset(r) offset(-r) square(dim);
}

module foot()
{
    intersection() {
        circle(r = FOOT_R, $fn = 100);
        square([FOOT_R + 1, FOOT_R + 1]);
    }
}

module feet(w, l)
{
    foot();
    translate([w, l]) rotate([0, 0, 180]) foot();
    translate([0, l]) rotate([0, 0, -90]) foot();
    translate([w, 0]) rotate([0, 0, 90]) foot();
}

module bin(x, y, thickness=1.5, spacing=0.5, r=1, chamfer=3)
{
    w = BIN_W * x - spacing;
    l = BIN_L * y - spacing;

    outside = [w, l];
    inside = outside - [2 * thickness, 2 * thickness];

    translate([spacing/2, spacing/2, 0]) {
        difference() {
            linear_extrude(BIN_H) rounded_square(outside, r=r+thickness);
            //translate([thickness, thickness, thickness]) linear_extrude(BIN_H) rounded_square(inside, r=r);
            hull() {
                translate([thickness, thickness, thickness+chamfer]) linear_extrude(BIN_H) rounded_square(inside, r=r);
                translate([thickness+chamfer, thickness+chamfer, thickness]) linear_extrude(BIN_H) rounded_square(inside - [2*chamfer, 2*chamfer], r=r);
            }
        }

        translate([0, 0, -FOOT_H]) linear_extrude(FOOT_H) intersection() {
            feet(w, l);
            rounded_square(outside, r=r+thickness);
        }
    }
}



bin(x, y);
