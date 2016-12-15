package com.ibm.commerce.extension.objects;

import javax.rmi.PortableRemoteObject;

import com.ibm.ivj.ejb.runtime.AbstractEntityAccessBean;

/**
 * BonusAccessBean
 * @generated
 */
public class BonusAccessBean extends AbstractEntityAccessBean
	implements
		com.ibm.commerce.extension.objects.BonusAccessBeanData {

	/**
	 * @generated
	 */
	private Bonus __ejbRef;
	/**
	 * @generated
	 */
	private Long initKey_memberId;
	/**
	 * getBonusPoint
	 * @generated
	 */
	public java.lang.Integer getBonusPoint()
		throws java.rmi.RemoteException,
		javax.ejb.CreateException,
		javax.ejb.FinderException,
		javax.naming.NamingException {
		return (((java.lang.Integer) __getCache("bonusPoint")));
	}

	/**
	 * setBonusPoint
	 * @generated
	 */
	public void setBonusPoint(java.lang.Integer newValue) {
		__setCache("bonusPoint", newValue);
	}

	/**
	 * getMemberId
	 * @generated
	 */
	public java.lang.Long getMemberId()
		throws java.rmi.RemoteException,
		javax.ejb.CreateException,
		javax.ejb.FinderException,
		javax.naming.NamingException {
		return (((java.lang.Long) __getCache("memberId")));
	}

	/**
	 * setInitKey_memberId
	 * @generated
	 */
	public void setInitKey_memberId(Long newValue) {
		this.initKey_memberId = (newValue);
	}

	/**
	 * BonusAccessBean
	 * @generated
	 */
	public BonusAccessBean() {
		super();
	}

	/**
	 * BonusAccessBean
	 * @generated
	 */
	public BonusAccessBean(javax.ejb.EJBObject o)
		throws java.rmi.RemoteException {
		super(o);
	}

	/**
	 * defaultJNDIName
	 * @generated
	 */
	public String defaultJNDIName() {
		return "ejb/com/ibm/commerce/extension/objects/BonusHome";
	}

	/**
	 * ejbHome
	 * @generated
	 */
	private com.ibm.commerce.extension.objects.BonusHome ejbHome()
		throws java.rmi.RemoteException,
		javax.naming.NamingException {
		return (com.ibm.commerce.extension.objects.BonusHome) PortableRemoteObject
			.narrow(
				getHome(),
				com.ibm.commerce.extension.objects.BonusHome.class);
	}

	/**
	 * ejbRef
	 * @generated
	 */
	private com.ibm.commerce.extension.objects.Bonus ejbRef()
		throws java.rmi.RemoteException {
		if (ejbRef == null)
			return null;
		if (__ejbRef == null)
			__ejbRef = (com.ibm.commerce.extension.objects.Bonus) PortableRemoteObject
				.narrow(ejbRef, com.ibm.commerce.extension.objects.Bonus.class);
	
		return __ejbRef;
	}

	/**
	 * instantiateEJB
	 * @generated
	 */
	protected void instantiateEJB()
		throws javax.naming.NamingException,
		javax.ejb.FinderException,
		java.rmi.RemoteException {
		if (ejbRef() != null)
			return;
	
		com.ibm.commerce.extension.objects.BonusKey key = keyFromFields(initKey_memberId);
		ejbRef = ejbHome().findByPrimaryKey(key);
	}

	/**
	 * instantiateEJBByPrimaryKey
	 * @generated
	 */
	protected boolean instantiateEJBByPrimaryKey()
		throws javax.ejb.CreateException,
		java.rmi.RemoteException,
		javax.naming.NamingException {
		boolean result = false;
	
		if (ejbRef() != null)
			return true;
	
		try {
			com.ibm.commerce.extension.objects.BonusKey pKey = (com.ibm.commerce.extension.objects.BonusKey) this
				.__getKey();
			if (pKey != null) {
				ejbRef = ejbHome().findByPrimaryKey(pKey);
				result = true;
			}
		} catch (javax.ejb.FinderException e) {
		}
		return result;
	}

	/**
	 * keyFromFields
	 * @generated
	 */
	private com.ibm.commerce.extension.objects.BonusKey keyFromFields(Long f0) {
		com.ibm.commerce.extension.objects.BonusKey keyClass = new com.ibm.commerce.extension.objects.BonusKey();
		keyClass.memberId = f0;
		return keyClass;
	}

	/**
	 * refreshCopyHelper
	 * @generated
	 */
	public void refreshCopyHelper()
		throws java.rmi.RemoteException,
		javax.ejb.CreateException,
		javax.ejb.FinderException,
		javax.naming.NamingException {
		refreshCopyHelper(ejbRef());
	}

	/**
	 * commitCopyHelper
	 * @generated
	 */
	public void commitCopyHelper()
		throws java.rmi.RemoteException,
		javax.ejb.CreateException,
		javax.ejb.FinderException,
		javax.naming.NamingException {
		commitCopyHelper(ejbRef());
	}

	/**
	 * findByMemberId
	 * @generated
	 */
	public BonusAccessBean findByMemberId(java.lang.Long memberId)
		throws javax.naming.NamingException,
		javax.ejb.FinderException,
		java.rmi.RemoteException {
		com.ibm.commerce.extension.objects.BonusHome localHome = ejbHome();
		com.ibm.commerce.extension.objects.Bonus ejbs = localHome
			.findByMemberId(memberId);
		return (BonusAccessBean) createAccessBeans(ejbs);
	}

	/**
	 * BonusAccessBean
	 * @generated
	 */
	public BonusAccessBean(java.lang.Long memberId)
		throws javax.naming.NamingException, javax.ejb.CreateException,
		java.rmi.RemoteException {
		ejbRef = ejbHome().create(memberId);
	}

	/**
	 * BonusAccessBean
	 * @generated
	 */
	public BonusAccessBean(java.lang.Long memberId, java.lang.Integer bonusPoint)
		throws javax.naming.NamingException, javax.ejb.CreateException,
		java.rmi.RemoteException {
		ejbRef = ejbHome().create(memberId, bonusPoint);
	}

	/**
	 * fulfills
	 * @generated
	 */
	public boolean fulfills(java.lang.Long arg0, java.lang.String arg1)
		throws javax.naming.NamingException,
		javax.ejb.FinderException,
		java.lang.Exception,
		java.rmi.RemoteException {
		instantiateEJB();
		return ejbRef().fulfills(arg0, arg1);
	}

	/**
	 * getOwner
	 * @generated
	 */
	public java.lang.Long getOwner()
		throws javax.naming.NamingException,
		javax.ejb.FinderException,
		java.lang.Exception,
		java.rmi.RemoteException {
		instantiateEJB();
		return ejbRef().getOwner();
	}
}
