static class MouseUtils {

    MouseUtils() {

    }

    static boolean hitTest(int x, int y, int objectWidth, int objectHeight) {
        return mouseX > x - (objectWidth / 2) &&
            mouseX < x + (objectWidth / 2) &&
            mouseY > y - (objectHeight / 2) &&
            mouseY < y + (objectHeight / 2);
    }

}