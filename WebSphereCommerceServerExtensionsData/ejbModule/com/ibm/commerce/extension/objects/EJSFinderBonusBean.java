package com.ibm.commerce.extension.objects;

/**
 * EJSFinderBonusBean
 */
public interface EJSFinderBonusBean {
	/**
	 * findByMemberId
	 */
	public com.ibm.commerce.extension.objects.Bonus findByMemberId(java.lang.Long memberId) throws javax.ejb.FinderException, java.rmi.RemoteException;
}
