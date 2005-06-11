/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Implementation of a base sprite class.
 */

/*
 * What this file includes / needs:
 * - Basic movement variables - location, frame, etc.
 * - Movement functions.
 * - Rendering functions.
 *
 * What this file doesn't include:
 * Player- / item-specific functions.
 */

#include "CSprite.h"
#include "../CPlayer/CPlayer.h"

/*
 * Constructor
 */
CSprite::CSprite(const bool show):
m_bActive(show),
m_staticTileType(NORMAL)
{
	// Better way to do this?
	m_pos.frame = 0;
	m_pos.idle.frameDelay = 0;
	m_pos.idle.frameTime = 0;
	m_pos.idle.time = 0;
	m_pos.loopFrame = -1;
	m_pos.loopSpeed = 1;
	m_pos.stance = WALK_S;
	m_pos.x = 0;
	m_pos.y = 0;

	// Create canvas.
	m_pCanvas = new CGDICanvas();
	m_pCanvas->CreateBlank(NULL, 32, 32, TRUE);
	m_pCanvas->ClearScreen(0);
}

/*
 * Copy constructor
 */
CSprite::CSprite(const CSprite &rhs)
{
	// Copy canvas.
}

/*
 * Assignment operator
 */
CSprite &CSprite::operator=(const CSprite &rhs)
{
	// Copy canvas.
	return CSprite(true);
}

/*
 * Destructor
 */
CSprite::~CSprite() 
{
	delete m_pAttr;
	m_pCanvas->Destroy();
	delete m_pCanvas;
}

/*
 * Movement functions.
 */ 

/*
 * Evaluate the current movement state.
 * Returns: true if movement occurred.
 */ 
bool CSprite::move() 
{
	extern std::vector<CPlayer *> g_players;
	extern int g_selectedPlayer;
	extern CSprite *g_pSelectedPlayer;
	extern int g_gameState;
	extern int g_loopOffset;
	extern double g_movementSize;
	extern int g_renderCount;
	extern double g_renderTime;
	extern int g_selectedPlayer;

	if (!m_bActive) return false;

	// Negative value indicates idle status.
	if (m_pos.loopFrame < 0)
	{
		// Parse the movement queue.
		m_pend.direction = getQueuedMovements();

		if (m_pend.direction != MV_IDLE)
		{
			// Insert target co-ordinates.
			insertTarget(m_pend);

			m_pos.loopFrame = 0;

			// obtainTileType();
			// checkObstruction();
			// checkBoardEdges();

			/*
			 * Determine the number of frames we need to draw to make
			 * the sprite move at the requested speed, considering the fps.
			 * Scale the offset (GameSpeed() setting) to correspond to an
			 * increment of 10%.
			 */
			double avgTime = g_renderTime / g_renderCount; // transMain?
			m_pos.loopSpeed = round(m_pAttr->speed / avgTime) + (g_loopOffset * round(1 / (avgTime * 10)));
			
			// Minimum possible frames = 1.
			if (m_pos.loopSpeed < 1)
			{
				m_pos.loopSpeed = 1;
			}
		}
		else
		{
			// Set g_gamestate to GS_IDLE to accept user input for the selected player.
			// if (this == g_pSelectedPlayer) 
			g_gameState = GS_IDLE;

		} // if (.direction != MV_IDLE)
	} // if (.loopFrame < 0)

	if (m_pend.direction != MV_IDLE)
	{
		if (push()) // || staticTileType == SOLID
		{
			if (m_pos.loopFrame % int(m_pos.loopSpeed / g_movementSize) == 0)
			{
				// Only increment the frame if we're on a multiple of .speed.
				m_pos.frame++;
			}
			m_pos.loopFrame++;

			if (m_pos.loopFrame == framesPerMove() * m_pos.loopSpeed)
			{
				// Movement has ended, update origin, reset counter.
				if (m_staticTileType != SOLID)
				{
					m_pend.xOrig = m_pend.xTarg;
					m_pend.yOrig = m_pend.yTarg;
					m_pend.lOrig = m_pos.l;
					m_pos.x = m_pend.xTarg;
					m_pos.y = m_pend.yTarg;
				}

				// Start the idle timer.
				m_pos.idle.time = GetTickCount();

				// Set to -1 temporarily to flag next loop.
				m_pos.loopFrame = -1;

				// Finish the move for the selected player.
//				if (this == g_pSelectedPlayer) 
				playerDoneMove();

				// Do this only after playerDoneMove().
				m_pend.direction = MV_IDLE;

			} // if (movement ended)

			return true;

		} // if (push)
	} // if (direction != MV_IDLE)

}

/*
 * Complete a single frame's movement of the sprite.
 * Return: true if movement occurred.
 */
bool CSprite::push(void) 
{
	extern double g_movementSize;
	
	// Set the stance.
	switch(m_pend.direction)
	{
		case MV_NORTH: 
			m_pos.stance = WALK_N; break;
		case MV_SOUTH: 
			m_pos.stance = WALK_S; break;
		case MV_EAST: 
			m_pos.stance = WALK_E; break;
		case MV_WEST: 
			m_pos.stance = WALK_W; break;
		case MV_NE: 
			m_pos.stance = WALK_NE; break;
		case MV_NW: 
			m_pos.stance = WALK_NW; break;
		case MV_SE: 
			m_pos.stance = WALK_SE; break;
		case MV_SW: 
			m_pos.stance = WALK_SW; break;
		default:
			m_pos.stance = WALK_S;
	}

	SPRITE_POSITION testPosition = m_pos;
	PENDING_MOVEMENT testPending = m_pend;
    const double moveFraction = g_movementSize / (framesPerMove() * m_pos.loopSpeed);
	
	incrementPosition(testPosition, m_pend, moveFraction);

	//	if (checkObstruction() = SOLID) return false;

	// Scroll the board for players. Either set for all players, or only selected player
	// and create a Scroll RPGCode function so that scrolling can be achieved without having
	// to use invisible players.
/*	Scroll() */

	m_pos = testPosition;
	return true;
}

/*
 * Get the next queued movement and remove it from the queue.
 */
int CSprite::getQueuedMovements(void) 
{
	// Check that we have queued movements before popping!
	if (m_pend.queue.size())
	{
		// Peek.
		int peek = m_pend.queue.front();
		// Pop.
		m_pend.queue.pop_front();
		return peek;
	}
	return MV_IDLE;
}

/*
 * Place a movement in the sprite's queue.
 */
void CSprite::setQueuedMovements(const int queue, const bool bClearQueue) 
{
	// Clear any currently queued movements if requested.
	if (bClearQueue) m_pend.queue.clear();

	// Push the new movements onto the queue.
	m_pend.queue.push_back(queue);
}

/*
 * Run all the movements in the queue.
 */
void CSprite::runQueuedMovements(void) {}

/*
 * Complete the selected player's move.
 */
void CSprite::playerDoneMove(void) 
{
	extern double g_movementSize;
	extern int g_gameState, g_stepsTaken;
	int facing = 0;
	/*
	 * Used to track number of times fighting
	 * *would* have been checked for if not
	 * in pixel movement. In pixel movement,
	 * only check every four steps (one tile).
	 */
	static int checkfight;
		
	/*
	 * Create a temporary player position which is based on
	 * the target location for that players' movement.
	 * lets us test solid tiles, etc.
	 */
	SPRITE_POSITION tempPosition;
	tempPosition.x = m_pend.xTarg;
	tempPosition.y = m_pend.yTarg;
	tempPosition.l = m_pend.lTarg;

//	programTest(tempPosition);

	// Test for a fight.
	checkfight++;
	if (checkfight == (1 / g_movementSize))
	{
//		fightTest();
		checkfight = 0;
	}

	// Update the step count (doesn't take pixel movement into account yet).
	g_stepsTaken++;
/*
	// Convert *STUPID* string positions to numerical
	if(m_pos.stance == WALK_N) facing = NORTH;
	else if(m_pos.stance == WALK_E) facing = EAST;
	else if(m_pos.stance == WALK_W) facing = WEST;
	else facing = SOUTH;
*/
	// Back to idle state (accepting input)
	g_gameState = GS_IDLE;

}

/*
 * Location functions.
 */

// CSprite::insertTarget() {}
// CSprite::incrementPosition() {}

/*
 * Render functions.
 */

/*
 * Determine the current sprite frame to use, and render if the current
 * frame requires updating.
 * Returns: true if frame requires redrawing.
 */
bool CSprite::render(const CGDICanvas* cnv) 
{
	extern int g_gameState;
	extern std::string g_projectPath;

	// Check idleness.
	if ((false) && (m_pend.direction == MV_IDLE) && (g_gameState != GS_MOVEMENT))
	{
		int direction = 0;
		// We're idle, and we're not about to start moving.
/*
		Dim direction As Long
		Select Case LCase$(.stance)
		Case "walk_n", "stand_n": direction = 1        'See CommonPlayer
		Case "walk_s", "stand_s": direction = 0
		Case "walk_e", "stand_e": direction = 3
		Case "walk_w", "stand_w": direction = 2
		Case "walk_nw", "stand_nw": direction = 4
		Case "walk_ne", "stand_ne": direction = 5
		Case "walk_sw", "stand_sw": direction = 6
		Case "walk_se", "stand_se": direction = 7
		Case Else: direction = -1
		End Select

		Dim bIdleGfx As Boolean
		bIdleGfx = (LeftB$(LCase$(.stance), 10) = "stand")
*/
		bool bIdleGfx = false;

		if ((GetTickCount() - m_pos.idle.time >= m_pAttr->idleTime) && (!bIdleGfx))
		{
			// Push into idle graphics if not already.

			// Check that a standing graphic for this direction exists.
			if (direction != -1)
			{
				if (!m_pAttr->standingGfx[direction].empty())
				{
					// If so, change the stance to STANDing.
					m_pos.stance = "stand" + m_pos.stance.substr(m_pos.stance.length() - 4, 4);
					bIdleGfx = true;
					
					// Set the loop counter and timer for idleness.
					m_pos.loopFrame = -1;
					m_pos.idle.frameTime = GetTickCount();

// Must be better way to do this!
					// Load the frame delay for the idle animation.
					ANIMATION idleAnim;
					idleAnim.open(g_projectPath + MISC_PATH + m_pAttr->standingGfx[direction]);
					m_pos.idle.frameDelay = idleAnim.animPause;
				}
			}
		} // if (time player has been idle > idle time)

		if ((bIdleGfx) && (!m_pAttr->standingGfx[direction].empty()))
		{
			// We're standing!

			if (GetTickCount() - m_pos.idle.frameTime >= m_pos.idle.frameDelay)
			{
				// Increment the animation frame when the delay is up.
				m_pos.frame++;

				// Start the timer for this frame.
				m_pos.idle.frameTime = GetTickCount();
			}
		}
	} // if (player is not moving)

	if (m_lastRender.canvas == m_pCanvas 
		&& m_lastRender.frame == m_pos.frame 
		&& m_lastRender.stance == m_pos.stance 
		&& m_lastRender.x == m_pos.x 
		&& m_lastRender.y == m_pos.y)
	{
		// We've just rendered this frame so we don't need to again.
		return false;
	}

	// Update the last render.
	m_lastRender.canvas = m_pCanvas;
	m_lastRender.frame = m_pos.frame;
	m_lastRender.stance = m_pos.stance;
	m_lastRender.x = m_pos.x;
	m_lastRender.y = m_pos.y;

	// Render the frame.
	renderAnimationFrame(m_pCanvas, m_pAttr->getStanceAnm(m_pos.stance), m_pos.frame, 0, 0);

	return true;
}

/*
 * Calculate sprite location and place on destination canvas.
 */
void CSprite::putSpriteAt(const CGDICanvas *cnvTarget, 
						  const bool bAccountForUnderTiles)
{    
	extern BOARD g_activeBoard;
	extern int g_resX, g_resY;
	extern CDirectDraw *g_pDirectDraw;
	extern double g_translucentOpacity;

    double xOrig = m_pend.xOrig;
    double yOrig = m_pend.yOrig;
    double xTarg = m_pend.xTarg;
    double yTarg = m_pend.yTarg;
    
    if (xOrig > g_activeBoard.bSizeX || xOrig < 0) xOrig = round(m_pos.x);
    if (yOrig > g_activeBoard.bSizeY || yOrig < 0) yOrig = round(m_pos.y);
    if (xTarg > g_activeBoard.bSizeX || xTarg < 0) xTarg = round(m_pos.x);
    if (yTarg > g_activeBoard.bSizeY || yTarg < 0) yTarg = round(m_pos.y);
    
    const BYTE targetTile = g_activeBoard.tiletype[round(xTarg)][-int(-yTarg)][int(m_pos.l)];
    const BYTE originTile = g_activeBoard.tiletype[round(xOrig)][-int(-yOrig)][int(m_pos.l)];
       
	/*    
	 * If [tiles on layers above]
	 * OR [Moving *to* "under" tile (target)]
	 * OR [Moving *from* "under" tile (origin)]
	 * OR [Moving between "under" tiles]
	 */ 
    bool bDrawTranslucently = false;
    if (g_activeBoard.isIsometric)
	{
        if (
/*            checkAbove(m_pos.x, m_pos.y, m_pos.l) == 1
            || */ (targetTile == UNDER && round(m_pos.x) == xTarg && round(m_pos.y) == yTarg)
            || (originTile == UNDER && round(m_pos.x) == xOrig && round(m_pos.y) == yOrig)
            || (targetTile == UNDER && originTile == UNDER))
                bDrawTranslucently = true;
	}
    else
	{
        if (
/*            checkAbove(m_pos.x, m_pos.y, m_pos.l) == 1
            || */ (targetTile == UNDER && round(m_pos.x) == round(xTarg) && -int(-m_pos.y) == -int(-yTarg))
            || (originTile == UNDER && round(m_pos.x) == round(xOrig) && -int(-m_pos.y) == -int(-yOrig))
            || (targetTile == UNDER && originTile == UNDER))
                bDrawTranslucently = true;
	}

// To do.
    // Determine the centrepoint of the tile in pixels.
//    int centreX = getBottomCentreX(m_pos.x, m_pos.y);
//    int centreY = getBottomCentreY(m_pos.x, m_pos.y);
	int centreX = m_pos.x * 32, centreY = m_pos.y * 32;

    // + 8 offsets the sprite 3/4 of way down tile rather than 1/2 for isometrics.
    if (g_activeBoard.isIsometric) centreY += 8;
       
    // The dimensions of the sprite frame, in pixels.
    const int spriteWidth = m_pCanvas->GetWidth();
    const int spriteHeight = m_pCanvas->GetHeight();

    // Will place the top left corner of the sprite frame at cornerX, cornerY:
    int cornerX = centreX - int(spriteWidth / 2);
    int cornerY = centreY - spriteHeight;
           
    // Exit if sprite is off the board.
    if (cornerX > g_resX || 
		cornerY > g_resY ||
        cornerX + spriteWidth < 0 || 
		cornerY + spriteHeight < 0) return;
       
    // Offset on the sprite's frame from the top left corner (cornerX, cornerY)
    int offsetX = 0, offsetY = 0;
    // Portion of frame to be drawn, after offset considerations.
    int renderWidth = 0, renderHeight = 0;
       
    // Calculate locations and areas to draw.
    if (cornerX < 0)
	{
        offsetX = -cornerX;
        if (cornerX + spriteWidth > g_resX)
            renderWidth = g_resX;					// Both
        else
            renderWidth = spriteWidth - offsetX;	// Left.
        cornerX = 0;
	}
    else
	{
        if (cornerX + spriteWidth > g_resX)
            renderWidth = g_resX - cornerX;			// Right.
        else
            renderWidth = spriteWidth;				// None.
	}
    
    if (cornerY < 0)
	{
        offsetY = -cornerY;
        if (cornerY + spriteHeight > g_resY)
            renderHeight = g_resY;					// Both.
        else
            renderHeight = spriteHeight - offsetY;	// Left.
        cornerY = 0;
	}
    else
	{
        if (cornerY + spriteHeight > g_resY)
            renderHeight = g_resY - cornerY;		// Right.
        else
            renderHeight = spriteHeight;			// None.
	}
    
    // We now have the position and area of the sprite to draw.
    // Check if we need to draw the sprite transluscently:
    
    if (bDrawTranslucently && bAccountForUnderTiles)
	{
        // If on "under" tiles, make sprite translucent.
        
        if (!cnvTarget)
		{
			// Draw to screen.
			g_pDirectDraw->DrawCanvasTranslucentPartial(m_pCanvas,
														cornerX,
														cornerY,
														offsetX,
														offsetY,
														renderWidth,
														renderHeight,
														g_translucentOpacity,
														-1,
														TRANSP_COLOR);
		}
        else 
		{
			// Draw to canvas.
			/* Canvas checks */
			m_pCanvas->BltTranslucentPart(cnvTarget,
										cornerX,
										cornerY,
										offsetX,
										offsetY,
										renderWidth,
										renderHeight,
										g_translucentOpacity,
										-1,
										TRANSP_COLOR);
		}
	}
    else
	{
        // Draw solid. Transparent refers to the transparent colour (alpha) on the frame.
        if (!cnvTarget)
		{
			// Draw to screen.
			g_pDirectDraw->DrawCanvasTransparentPartial(m_pCanvas,
														cornerX,
														cornerY,
														offsetX,
														offsetY,
														renderWidth,
														renderHeight,
														TRANSP_COLOR);
		}
        else 
		{
			// Draw to canvas.
			/* Canvas checks */
			m_pCanvas->BltTransparentPart(cnvTarget,
										cornerX,
										cornerY,
										offsetX,
										offsetY,
										renderWidth,
										renderHeight,
										TRANSP_COLOR);
		}
	} // if (bDrawTranslucently And bAccountForUnderTiles)
}
