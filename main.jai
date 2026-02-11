#import "Basic";
#import "Math";

rl :: #import "raylib";

SCREEN_FACTOR :: 80;
WINDOW_WIDTH  :: 16 * SCREEN_FACTOR;
WINDOW_HEIGHT :: 9  * SCREEN_FACTOR;

BRANCH_COUNT :: 7;
BRANCH_ANGLE :: (2.0 * PI) / BRANCH_COUNT;
BRANCH_LEN   :: SCREEN_FACTOR * 2;
BRANCH_THICC :: 10.0;

RECURSION_LEVEL :: 3;

SCALE_FACTOR :: 0.5;

draw_snowflake :: (center: Vector2, branch_len: float, branch_thicc: float, hue: float, count: s64) {
	if count <= 0 then return;

	for 0..BRANCH_COUNT-1 {
		// I don't understand how this math works! 
		//
		// --- njs, 10 Jan 2026.
		branch := Vector2.{ center.x + cos(BRANCH_ANGLE * it) * branch_len, center.y + sin(BRANCH_ANGLE * it) * branch_len };
		color := rl.ColorFromHSV(hue, 1.0, 1.0);
		rl.DrawLineEx(center, branch, branch_thicc, color);

		draw_snowflake(branch, branch_len * SCALE_FACTOR, branch_thicc * SCALE_FACTOR, hue + 70.0, count - 1);
	}
}

main :: () {
	rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Snowflake!");

	while !rl.WindowShouldClose() {
		rl.BeginDrawing();
		rl.ClearBackground(.{0x18, 0x18, 0x18, 0xFF});

		center := Vector2.{ rl.GetScreenWidth() * 0.5, rl.GetScreenHeight() * 0.5 };
		draw_snowflake(center, BRANCH_LEN, BRANCH_THICC, 0.0, RECURSION_LEVEL);

		rl.EndDrawing();
	}

	rl.CloseWindow();
}
