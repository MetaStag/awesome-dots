/* Configuration for Glava (Radial Mode) */

/* center radius (pixels) */
#define C_RADIUS 150
/* center line thickness (pixels) */
#define C_LINE 5
/* width (in pixels) of each bar*/
#define BAR_WIDTH 6
/* outline width (in pixels, set to 0 to disable outline drawing) */
#define BAR_OUTLINE_WIDTH 0
/* number of bars (use even values for best results) */
#define NBARS 800

/* Bar color */ 
#define COLOR #5d62E7
/* outline color */
#define OUTLINE #1B1D27
/* bar outline color */
#define BAR_OUTLINE #1B1D27

/* Amplify magnitude of the results each bar displays */
#define AMPLIFY 60

/* Angle (in radians) for how much to rotate the visualizer */
#define ROTATE (PI / 3)
/* Whether to switch left/right audio buffers */
#define INVERT 0
/* Aliasing factors. Higher values mean more defined and jagged lines.
   Note: aliasing does not have a notable impact on performance, but requires
   `xroot` transparency to be enabled since it relies on alpha blending with
   the background. */
#define BAR_ALIAS_FACTOR 1.0
#define C_ALIAS_FACTOR 1.0

/* Offset (Y) of the visualization */
#define CENTER_OFFSET_Y 0
/* Offset (X) of the visualization */
#define CENTER_OFFSET_X 0
