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
CItem::CItem(const std::string file, const bool show):
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
CItem::CItem(const std::string file, const BRD_SPRITE spr, short &version):
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
short CItem::open(const std::string file) throw(CInvalidItem)
{

	const short minorVer = m_itemMem.open(file, m_attr);
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
		extern std::string g_projectPath;
		const std::string file = g_projectPath + PRG_PATH + m_brdData.prgMultitask;
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
CItemThread *CItemThread::create(const std::string str, CItem *pItem)
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
	extern void *g_pTarget, *g_pSource;
	extern TARGET_TYPE g_targetType, g_sourceType;

	if (!m_pItem->isActive() || (m_i == m_units.end())) return false;

	void *const target = g_pTarget, *const source = g_pSource;
	const TARGET_TYPE tt = g_targetType, st = g_sourceType;

	g_pTarget = g_pSource = m_pItem;
	g_targetType = g_sourceType = TT_ITEM;

	m_i->execute(this);
	++m_i;

	g_pTarget = target; g_pSource = source;
	g_targetType = tt; g_sourceType = st;

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
