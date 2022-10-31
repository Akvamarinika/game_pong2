package objects;

class Vector2d {
    public var x: Float;
    public var y: Float;

    public function new(x = 0., y = 0.) {
        this.x = x;
        this.y = y;
    }

    public static function zero() {
        return new Vector2d(0, 0);
    }

    public static function random(xmin, xmax, ymin, ymax) {
        return new Vector2d(Random.float(xmin, xmax), Random.float(ymin, ymax));
    }

    public function toString() {
        return 'Vector($x, $y)';
    }

    public function add(other: Vector2d) {
        return new Vector2d(x + other.x, y + other.y);
    }

    public function sub(other: Vector2d) {
        return new Vector2d(x - other.x, y - other.y);
    }

    public function mul(value: Float) {
        return new Vector2d(x*value, y*value);
    }

    public function div(value: Float) {
        return new Vector2d(x/value, y/value);
    }

    public function mag() {
        return Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2));
    }

    public function norm() {
        return div(mag());
    }

    public function copy() {
        return new Vector2d(x, y);
    }

    public function limit(max: Float) {
        var m = mag();
        if (m > max) {
            return norm().mul(max);
        }
        return copy();
    }

}