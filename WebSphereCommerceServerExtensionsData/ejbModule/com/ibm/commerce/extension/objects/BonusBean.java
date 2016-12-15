package com.ibm.commerce.extension.objects;

/**
 * Bean implementation class for Enterprise Bean: Bonus
 */
public class BonusBean extends com.ibm.commerce.base.objects.ECEntityBean
	implements
		javax.ejb.EntityBean {

	/**
	 * Implementation field for persistent attribute: memberId
	 */
	public java.lang.Long memberId;

	/**
	 * Implementation field for persistent attribute: bonusPoint
	 */
	public java.lang.Integer bonusPoint;

	/**
	 * Implementation field for persistent attribute: optCounter
	 */
	public short optCounter;

	/**
	 * ejbCreate method for a CMP entity bean.
	 */
	public com.ibm.commerce.extension.objects.BonusKey ejbCreate(
		java.lang.Long memberId) throws javax.ejb.CreateException {
		_initLinks();
		this.memberId = memberId;
		return null;
	}
	
	public com.ibm.commerce.extension.objects.BonusKey ejbCreate(Long memberId,
			Integer bonusPoint) throws javax.ejb.CreateException {
		this.initializeFields();
		
		_initLinks();
		this.memberId = memberId;
		this.bonusPoint = bonusPoint;
		
		BonusKey myNewKey = new BonusKey(memberId);
		this.initializeOptCounter(myNewKey);
		
		return null;
	}

	/**
	 * ejbPostCreate
	 */
	public void ejbPostCreate(java.lang.Long memberId)
		throws javax.ejb.CreateException {
	}
	
	public void ejbPostCreate(Long memberId, Integer bonusPoint)
			throws javax.ejb.CreateException {
		// Empty
	}

	/**
	 * ejbActivate
	 */
	public void ejbActivate() {
		_initLinks();
	}

	/**
	 * ejbLoad
	 */
	public void ejbLoad() {
		super.ejbLoad();
		_initLinks();
	}

	/**
	 * ejbPassivate
	 */
	public void ejbPassivate() {
	}

	/**
	 * ejbRemove
	 */
	public void ejbRemove() throws javax.ejb.RemoveException {
		try {
			_removeLinks();
		} catch (java.rmi.RemoteException e) {
			throw new javax.ejb.RemoveException(e.getMessage());
		}
	}

	/**
	 * ejbStore
	 */
	public void ejbStore() {
		super.ejbStore();
	}

	/**
	 * This method was generated for supporting the associations.
	 */
	protected void _initLinks() {
	}

	/**
	 * This method was generated for supporting the associations.
	 */
	protected java.util.Vector _getLinks() {
		java.util.Vector links = new java.util.Vector();
		return links;
	}

	/**
	 * This method was generated for supporting the associations.
	 */
	protected void _removeLinks()
		throws java.rmi.RemoteException,
		javax.ejb.RemoveException {
		java.util.List links = _getLinks();
		for (int i = 0; i < links.size(); i++) {
			try {
				((com.ibm.ivj.ejb.associations.interfaces.Link) links.get(i))
					.remove();
			} catch (javax.ejb.FinderException e) {
			} //Consume Finder error since I am going away
		}
	}

	/**
	 * Get accessor for persistent attribute: bonusPoint
	 */
	public java.lang.Integer getBonusPoint() {
		return bonusPoint;
	}

	/**
	 * Set accessor for persistent attribute: bonusPoint
	 */
	public void setBonusPoint(java.lang.Integer newBonusPoint) {
		bonusPoint = newBonusPoint;
	}
	
	public Long getMemberId(){
		return memberId;
	}
	
	@Override
	public Long getOwner() throws Exception {
		return getMemberId();
	}

	@Override
	public boolean fulfills(Long member, String relationship) throws Exception {

		if ("creator".equalsIgnoreCase(relationship))
			return member.equals(getMemberId());

		return false;
	}

	/**
	 * _copyFromEJB
	 */
	public java.util.Hashtable _copyFromEJB() {
		com.ibm.ivj.ejb.runtime.AccessBeanHashtable h = new com.ibm.ivj.ejb.runtime.AccessBeanHashtable();
	
		h.put("bonusPoint", getBonusPoint());
		h.put("memberId", getMemberId());
		h.put("__Key", getEntityContext().getPrimaryKey());
	
		return h;
	}

	/**
	 * _copyToEJB
	 */
	public void _copyToEJB(java.util.Hashtable h) {
		java.lang.Integer localBonusPoint = (java.lang.Integer) h
			.get("bonusPoint");
	
		if (h.containsKey("bonusPoint"))
			setBonusPoint((localBonusPoint));
	}
}
