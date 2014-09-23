x = 1;
y = 1;

module foot()
{
    height = 2.7;
    radius = 6;

    translate([0, 0, height * -1]) intersection() {
        cylinder(h = height, r1 = radius, r2 = radius, $fn = 100);
        cube(radius + 1, radius + 1, height + 1);
    }
}

module feet(w, l)
{
    foot();
    translate([w, l, 0]) rotate([0, 0, 180]) foot();
    translate([0, l, 0]) rotate([0, 0, -90]) foot();
    translate([w, 0, 0]) rotate([0, 0, 90]) foot();
}

module bin(x, y)
{
    w = (39 * x) + (x - 1);
    l = (54 * y) + (y - 1);
    outside = [w, l, 40];
    inside = outside - [2, 2, 0];
    difference() {
        cube(outside);
        translate([1, 1, 1]) cube(inside);
    }
    feet(w, l);
}

bin(x, y);