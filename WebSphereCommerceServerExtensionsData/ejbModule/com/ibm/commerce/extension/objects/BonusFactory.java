package com.ibm.commerce.extension.objects;

import com.ibm.etools.ejb.client.runtime.AbstractEJBFactory;

/**
 * BonusFactory
 * @generated
 */
public class BonusFactory extends AbstractEJBFactory {

	/**
	 * BonusFactory
	 * @generated
	 */
	public BonusFactory() {
		super();
	}

	/**
	 * _acquireBonusHome
	 * @generated
	 */
	protected com.ibm.commerce.extension.objects.BonusHome _acquireBonusHome()
		throws java.rmi.RemoteException {
		return (com.ibm.commerce.extension.objects.BonusHome) _acquireEJBHome();
	}

	/**
	 * acquireBonusHome
	 * @generated
	 */
	public com.ibm.commerce.extension.objects.BonusHome acquireBonusHome()
		throws javax.naming.NamingException {
		return (com.ibm.commerce.extension.objects.BonusHome) acquireEJBHome();
	}

	/**
	 * getDefaultJNDIName
	 * @generated
	 */
	public String getDefaultJNDIName() {
		return "ejb/com/ibm/commerce/extension/objects/BonusHome";
	}

	/**
	 * getHomeInterface
	 * @generated
	 */
	protected Class getHomeInterface() {
		return com.ibm.commerce.extension.objects.BonusHome.class;
	}

	/**
	 * resetBonusHome
	 * @generated
	 */
	public void resetBonusHome() {
		resetEJBHome();
	}

	/**
	 * setBonusHome
	 * @generated
	 */
	public void setBonusHome(com.ibm.commerce.extension.objects.BonusHome home) {
		setEJBHome(home);
	}

	/**
	 * findByMemberId
	 * @generated
	 */
	public com.ibm.commerce.extension.objects.Bonus findByMemberId(
		java.lang.Long memberId)
		throws javax.ejb.FinderException,
		java.rmi.RemoteException {
		return _acquireBonusHome().findByMemberId(memberId);
	}

	/**
	 * create
	 * @generated
	 */
	public com.ibm.commerce.extension.objects.Bonus create(
		java.lang.Long memberId)
		throws javax.ejb.CreateException,
		java.rmi.RemoteException {
		return _acquireBonusHome().create(memberId);
	}

	/**
	 * create
	 * @generated
	 */
	public com.ibm.commerce.extension.objects.Bonus create(
		java.lang.Long memberId,
		java.lang.Integer bonusPoint)
		throws javax.ejb.CreateException,
		java.rmi.RemoteException {
		return _acquireBonusHome().create(memberId, bonusPoint);
	}

	/**
	 * findByPrimaryKey
	 * @generated
	 */
	public com.ibm.commerce.extension.objects.Bonus findByPrimaryKey(
		com.ibm.commerce.extension.objects.BonusKey primaryKey)
		throws javax.ejb.FinderException,
		java.rmi.RemoteException {
		return _acquireBonusHome().findByPrimaryKey(primaryKey);
	}
}
