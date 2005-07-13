/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Implementation of an item class.
 */

#include "CItem.h"
#include "../../rpgcode/CProgram/CProgram.h"

/*
 * Default constructor.
 */
CItem::CItem(const std::string file, const bool show):
CSprite(false)				
{
	open(file);
	m_bActive = show;				// Overwrite open() result.
}

/*
 * Constructor - load an item directly from the board.
 */
CItem::CItem(const std::string file, const BRD_SPRITE spr):
CSprite(false)
{
	m_brdData = spr;
	open(file);
}

/*
 * Common opening procedure.
 */
void CItem::open(const std::string file) throw()
{

	const short minorVer = m_itemMem.open(file, m_attr);
	if (minorVer == 0)
	{
		throw CInvalidItem();
	}
	else if (minorVer <= PRE_VECTOR_ITEM)
	{
		// Create standard vectors for old items.
		m_attr.createVectors(m_brdData.activationType);
	}

	/* Variable stuff ? */

	// Get these into milliseconds!
	m_attr.speed *= MILLISECONDS;
	m_attr.idleTime *= MILLISECONDS;

	// Override the item's programs for the board's, and
	// make them accessible to CSprite.
	if (m_brdData.prgMultitask.empty()) m_brdData.prgMultitask = m_itemMem.itmPrgOnBoard;
	if (m_brdData.prgActivate.empty()) m_brdData.prgActivate = m_itemMem.itmPrgPickUp;

	// Check activation conditions.
	m_bActive = true;

	if (m_brdData.activate == SPR_CONDITIONAL)
	{
		if (CProgram::getGlobal(m_brdData.initialVar).getLit() != m_brdData.initialValue)
		{
			m_bActive = false;
		}
	}

	// Create thread. (prgActivate).


}


