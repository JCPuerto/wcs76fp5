package com.ibm.commerce.extension.objects;

import com.ibm.ejs.container.*;

/**
 * EJSCMPBonusHomeBean_13725080
 */
public class EJSCMPBonusHomeBean_13725080 extends EJSHome {
	static final long serialVersionUID = 61;
	/**
	 * EJSCMPBonusHomeBean_13725080
	 */
	public EJSCMPBonusHomeBean_13725080() throws java.rmi.RemoteException {
		super();	}
	/**
	 * postCreateWrapper
	 */
	public com.ibm.commerce.extension.objects.Bonus postCreateWrapper(com.ibm.ejs.container.BeanO beanO, Object ejsKey) throws javax.ejb.CreateException, java.rmi.RemoteException {
		return  (com.ibm.commerce.extension.objects.Bonus) super.postCreate(beanO, ejsKey, true);
	}
	/**
	 * afterPostCreateWrapper
	 */
	public void afterPostCreateWrapper(com.ibm.ejs.container.BeanO beanO, Object ejsKey) throws javax.ejb.CreateException, java.rmi.RemoteException {
		super.afterPostCreate(beanO, ejsKey);
	}
	/**
	 * findByMemberId
	 */
	public com.ibm.commerce.extension.objects.Bonus findByMemberId(java.lang.Long memberId) throws javax.ejb.FinderException, java.rmi.RemoteException {
return ((com.ibm.commerce.extension.objects.EJSJDBCPersisterCMPBonusBean_13725080)persister).findByMemberId(memberId);	}
	/**
	 * create
	 */
	public com.ibm.commerce.extension.objects.Bonus create(java.lang.Long memberId) throws javax.ejb.CreateException, java.rmi.RemoteException {
		BeanO beanO = null;
		com.ibm.commerce.extension.objects.Bonus _EJS_result = null;
		boolean createFailed = false;
		try {
			beanO = super.createBeanO();
			com.ibm.commerce.extension.objects.BonusBean bean = (com.ibm.commerce.extension.objects.BonusBean) beanO.getEnterpriseBean();
			bean.ejbCreate(memberId);
			Object _primaryKey = keyFromBean(bean);
_EJS_result = postCreateWrapper(beanO, _primaryKey);
			bean.ejbPostCreate(memberId);
			afterPostCreateWrapper(beanO, _primaryKey);
		}
		catch (javax.ejb.CreateException ex) {
			createFailed = true;
			throw ex;
		} catch (java.rmi.RemoteException ex) {
			createFailed = true;
			throw ex;
		} catch (Throwable ex) {
			createFailed = true;
			throw new CreateFailureException(ex);
		} finally {
			if (createFailed) {
				super.createFailure(beanO);
			}
		}
		return _EJS_result;
	}
	/**
	 * create
	 */
	public com.ibm.commerce.extension.objects.Bonus create(java.lang.Long memberId, java.lang.Integer bonusPoint) throws javax.ejb.CreateException, java.rmi.RemoteException {
		BeanO beanO = null;
		com.ibm.commerce.extension.objects.Bonus _EJS_result = null;
		boolean createFailed = false;
		try {
			beanO = super.createBeanO();
			com.ibm.commerce.extension.objects.BonusBean bean = (com.ibm.commerce.extension.objects.BonusBean) beanO.getEnterpriseBean();
			bean.ejbCreate(memberId, bonusPoint);
			Object _primaryKey = keyFromBean(bean);
_EJS_result = postCreateWrapper(beanO, _primaryKey);
			bean.ejbPostCreate(memberId, bonusPoint);
			afterPostCreateWrapper(beanO, _primaryKey);
		}
		catch (javax.ejb.CreateException ex) {
			createFailed = true;
			throw ex;
		} catch (java.rmi.RemoteException ex) {
			createFailed = true;
			throw ex;
		} catch (Throwable ex) {
			createFailed = true;
			throw new CreateFailureException(ex);
		} finally {
			if (createFailed) {
				super.createFailure(beanO);
			}
		}
		return _EJS_result;
	}
	/**
	 * findByPrimaryKey
	 */
	public com.ibm.commerce.extension.objects.Bonus findByPrimaryKey(com.ibm.commerce.extension.objects.BonusKey primaryKey) throws javax.ejb.FinderException, java.rmi.RemoteException {
		return ((com.ibm.commerce.extension.objects.EJSJDBCPersisterCMPBonusBean_13725080) persister).findByPrimaryKey(primaryKey);
	}
	/**
	 * keyFromBean
	 */
	public Object keyFromBean(javax.ejb.EntityBean generalEJB) {
		com.ibm.commerce.extension.objects.BonusBean tmpEJB = (com.ibm.commerce.extension.objects.BonusBean) generalEJB;
		com.ibm.commerce.extension.objects.BonusKey keyClass = new com.ibm.commerce.extension.objects.BonusKey();
		keyClass.memberId = tmpEJB.memberId;
		return keyClass;
	}
	/**
	 * keyFromFields
	 */
	public com.ibm.commerce.extension.objects.BonusKey keyFromFields(java.lang.Long f0) {
		com.ibm.commerce.extension.objects.BonusKey keyClass = new com.ibm.commerce.extension.objects.BonusKey();
		keyClass.memberId = f0;
		return keyClass;
	}
}
