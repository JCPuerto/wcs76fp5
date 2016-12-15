package com.ibm.commerce.extension.objects;

/**
 * Home interface for Enterprise Bean: Bonus
 */
public interface BonusHome extends javax.ejb.EJBHome {

	/**
	 * Creates an instance from a key for Entity Bean: Bonus
	 */
	public com.ibm.commerce.extension.objects.Bonus create(
		java.lang.Long memberId)
		throws javax.ejb.CreateException,
		java.rmi.RemoteException;

	/**
	 * Finds an instance using a key for Entity Bean: Bonus
	 */
	public com.ibm.commerce.extension.objects.Bonus findByPrimaryKey(
		com.ibm.commerce.extension.objects.BonusKey primaryKey)
		throws javax.ejb.FinderException,
		java.rmi.RemoteException;

	public com.ibm.commerce.extension.objects.Bonus findByMemberId(java.lang.Long memberId) throws javax.ejb.FinderException, java.rmi.RemoteException;

	/**
	 * @param memberId
	 * @param bonusPoint
	 * @return
	 * @throws javax.ejb.CreateException
	 * @throws java.rmi.RemoteException
	 */
	public com.ibm.commerce.extension.objects.Bonus create(Long memberId,
			Integer bonusPoint) throws javax.ejb.CreateException,
			java.rmi.RemoteException;
}
