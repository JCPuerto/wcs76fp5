package com.ibm.commerce.extension.objects;

/**
 * Remote interface for Enterprise Bean: Bonus
 */
public interface Bonus extends com.ibm.ivj.ejb.runtime.CopyHelper,
		javax.ejb.EJBObject, com.ibm.commerce.security.Protectable {


	/**
	 * @return
	 * @throws java.rmi.RemoteException
	 */
	public Long getMemberId() throws java.rmi.RemoteException;
}
