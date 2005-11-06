/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Implementation of an item class.
 */

#include "CItem.h"
#include "../../rpgcode/CProgram.h"
#include "../../common/paths.h"
#include "../../common/CFile.h"
#include "../../fight/fight.h"

/*
 * Default constructor.
 */
CItem::CItem(const STRING file, const bool show):
CSprite(false),
m_pThread(NULL)
{
	if (open(file) <= PRE_VECTOR_ITEM)
	{
		// Create standard vectors for old items.
		createVectors();
	}
	m_bActive = show;				// Overwrite open() result.
}

/*
 * Constructor - load an item directly from the board.
 */
CItem::CItem(const STRING file, const BRD_SPRITE spr, short &version):
CSprite(false),
m_pThread(NULL)
{
	m_brdData = spr;
	// Set the version that is passed in.
	version = open(file);
}

/*
 * Common opening procedure. Return the minor version.
 */
short CItem::open(const STRING file) throw(CInvalidItem)
{
	const short minorVer = m_itemMem.open(file, &m_attr);
	if (minorVer == 0)
	{
		throw CInvalidItem();
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
		if (CProgram::getGlobal(m_brdData.initialVar)->getLit() != m_brdData.initialValue)
		{
			m_bActive = false;
		}
	}

	// Create thread
	if (!m_brdData.prgMultitask.empty())
	{
		extern STRING g_projectPath;
		const STRING file = g_projectPath + PRG_PATH + m_brdData.prgMultitask;
		if (CFile::fileExists(file))
		{
			m_pThread = CItemThread::create(file, this);
		}
	}

	return minorVer;
}

/*
 * Create an item thread.
 */
CItemThread *CItemThread::create(const STRING str, CItem *pItem)
{
	CItemThread *p = new CItemThread(str);
	m_threads.insert(p);
	p->m_pItem = pItem;
	return p;
}

/*
 * Execute an item thread.
 */
bool CItemThread::execute()
{
	extern ENTITY g_target, g_source;

	if (!m_pItem->isActive() || (m_i == m_units.end())) return false;

	ENTITY t = g_target, s = g_source;

	g_target.p = g_source.p = m_pItem;
	g_target.type = g_source.type = ET_ITEM;

	m_i->execute(this);
	++m_i;

	g_target = t; g_source = s;

	return true;
}

/*
 * Deconstruct an item.
 */
CItem::~CItem()
{
	if (m_pThread)
	{
		CThread::destroy(m_pThread);
	}
}
