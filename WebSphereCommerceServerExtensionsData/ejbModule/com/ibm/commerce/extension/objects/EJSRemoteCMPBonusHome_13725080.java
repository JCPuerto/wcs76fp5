package com.ibm.commerce.extension.objects;

import com.ibm.ejs.container.*;

/**
 * EJSRemoteCMPBonusHome_13725080
 */
public class EJSRemoteCMPBonusHome_13725080 extends EJSWrapper implements com.ibm.commerce.extension.objects.BonusHome {
	/**
	 * EJSRemoteCMPBonusHome_13725080
	 */
	public EJSRemoteCMPBonusHome_13725080() throws java.rmi.RemoteException {
		super();	}
	/**
	 * create
	 */
	public com.ibm.commerce.extension.objects.Bonus create(java.lang.Long memberId) throws javax.ejb.CreateException, java.rmi.RemoteException {
		EJSDeployedSupport _EJS_s = container.getEJSDeployedSupport(this);
		Object[] _jacc_parms = null;
		com.ibm.commerce.extension.objects.Bonus _EJS_result = null;
		try {
			if (container.doesJaccNeedsEJBArguments( this ))
			{
				_jacc_parms = new Object[1];
				_jacc_parms[0] = memberId;
			}
	com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080 beanRef = (com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080)container.preInvoke(this, 0, _EJS_s, _jacc_parms);
			_EJS_result = beanRef.create(memberId);
		}
		catch (javax.ejb.CreateException ex) {
			_EJS_s.setCheckedException(ex);
			throw ex;
		}
		catch (java.rmi.RemoteException ex) {
			_EJS_s.setUncheckedException(ex);
		}
		catch (Throwable ex) {
			_EJS_s.setUncheckedException(ex);
			throw new java.rmi.RemoteException("bean method raised unchecked exception", ex);
		}

		finally {
			try{
				container.postInvoke(this, 0, _EJS_s);
			} finally {
				container.putEJSDeployedSupport(_EJS_s);
			}
		}
		return _EJS_result;
	}
	/**
	 * create
	 */
	public com.ibm.commerce.extension.objects.Bonus create(java.lang.Long memberId, java.lang.Integer bonusPoint) throws javax.ejb.CreateException, java.rmi.RemoteException {
		EJSDeployedSupport _EJS_s = container.getEJSDeployedSupport(this);
		Object[] _jacc_parms = null;
		com.ibm.commerce.extension.objects.Bonus _EJS_result = null;
		try {
			if (container.doesJaccNeedsEJBArguments( this ))
			{
				_jacc_parms = new Object[2];
				_jacc_parms[0] = memberId;
				_jacc_parms[1] = bonusPoint;
			}
	com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080 beanRef = (com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080)container.preInvoke(this, 1, _EJS_s, _jacc_parms);
			_EJS_result = beanRef.create(memberId, bonusPoint);
		}
		catch (javax.ejb.CreateException ex) {
			_EJS_s.setCheckedException(ex);
			throw ex;
		}
		catch (java.rmi.RemoteException ex) {
			_EJS_s.setUncheckedException(ex);
		}
		catch (Throwable ex) {
			_EJS_s.setUncheckedException(ex);
			throw new java.rmi.RemoteException("bean method raised unchecked exception", ex);
		}

		finally {
			try{
				container.postInvoke(this, 1, _EJS_s);
			} finally {
				container.putEJSDeployedSupport(_EJS_s);
			}
		}
		return _EJS_result;
	}
	/**
	 * findByMemberId
	 */
	public com.ibm.commerce.extension.objects.Bonus findByMemberId(java.lang.Long memberId) throws javax.ejb.FinderException, java.rmi.RemoteException {
		EJSDeployedSupport _EJS_s = container.getEJSDeployedSupport(this);
		Object[] _jacc_parms = null;
		com.ibm.commerce.extension.objects.Bonus _EJS_result = null;
		try {
			if (container.doesJaccNeedsEJBArguments( this ))
			{
				_jacc_parms = new Object[1];
				_jacc_parms[0] = memberId;
			}
	com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080 beanRef = (com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080)container.preInvoke(this, 2, _EJS_s, _jacc_parms);
			_EJS_result = beanRef.findByMemberId(memberId);
		}
		catch (javax.ejb.FinderException ex) {
			_EJS_s.setCheckedException(ex);
			throw ex;
		}
		catch (java.rmi.RemoteException ex) {
			_EJS_s.setUncheckedException(ex);
		}
		catch (Throwable ex) {
			_EJS_s.setUncheckedException(ex);
			throw new java.rmi.RemoteException("bean method raised unchecked exception", ex);
		}

		finally {
			try{
				container.postInvoke(this, 2, _EJS_s);
			} finally {
				container.putEJSDeployedSupport(_EJS_s);
			}
		}
		return _EJS_result;
	}
	/**
	 * findByPrimaryKey
	 */
	public com.ibm.commerce.extension.objects.Bonus findByPrimaryKey(com.ibm.commerce.extension.objects.BonusKey primaryKey) throws javax.ejb.FinderException, java.rmi.RemoteException {
		EJSDeployedSupport _EJS_s = container.getEJSDeployedSupport(this);
		Object[] _jacc_parms = null;
		com.ibm.commerce.extension.objects.Bonus _EJS_result = null;
		try {
			if (container.doesJaccNeedsEJBArguments( this ))
			{
				_jacc_parms = new Object[1];
				_jacc_parms[0] = primaryKey;
			}
	com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080 beanRef = (com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080)container.preInvoke(this, 3, _EJS_s, _jacc_parms);
			_EJS_result = beanRef.findByPrimaryKey(primaryKey);
		}
		catch (javax.ejb.FinderException ex) {
			_EJS_s.setCheckedException(ex);
			throw ex;
		}
		catch (java.rmi.RemoteException ex) {
			_EJS_s.setUncheckedException(ex);
		}
		catch (Throwable ex) {
			_EJS_s.setUncheckedException(ex);
			throw new java.rmi.RemoteException("bean method raised unchecked exception", ex);
		}

		finally {
			try{
				container.postInvoke(this, 3, _EJS_s);
			} finally {
				container.putEJSDeployedSupport(_EJS_s);
			}
		}
		return _EJS_result;
	}
	/**
	 * getEJBMetaData
	 */
	public javax.ejb.EJBMetaData getEJBMetaData() throws java.rmi.RemoteException {
		EJSDeployedSupport _EJS_s = container.getEJSDeployedSupport(this);
		Object[] _jacc_parms = null;
		javax.ejb.EJBMetaData _EJS_result = null;
		try {
			if (container.doesJaccNeedsEJBArguments( this ))
			{
				_jacc_parms = new Object[0];
			}
	com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080 beanRef = (com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080)container.preInvoke(this, 4, _EJS_s, _jacc_parms);
			_EJS_result = beanRef.getEJBMetaData();
		}
		catch (java.rmi.RemoteException ex) {
			_EJS_s.setUncheckedException(ex);
		}
		catch (Throwable ex) {
			_EJS_s.setUncheckedException(ex);
			throw new java.rmi.RemoteException("bean method raised unchecked exception", ex);
		}

		finally {
			try{
				container.postInvoke(this, 4, _EJS_s);
			} finally {
				container.putEJSDeployedSupport(_EJS_s);
			}
		}
		return _EJS_result;
	}
	/**
	 * getHomeHandle
	 */
	public javax.ejb.HomeHandle getHomeHandle() throws java.rmi.RemoteException {
		EJSDeployedSupport _EJS_s = container.getEJSDeployedSupport(this);
		Object[] _jacc_parms = null;
		javax.ejb.HomeHandle _EJS_result = null;
		try {
			if (container.doesJaccNeedsEJBArguments( this ))
			{
				_jacc_parms = new Object[0];
			}
	com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080 beanRef = (com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080)container.preInvoke(this, 5, _EJS_s, _jacc_parms);
			_EJS_result = beanRef.getHomeHandle();
		}
		catch (java.rmi.RemoteException ex) {
			_EJS_s.setUncheckedException(ex);
		}
		catch (Throwable ex) {
			_EJS_s.setUncheckedException(ex);
			throw new java.rmi.RemoteException("bean method raised unchecked exception", ex);
		}

		finally {
			try{
				container.postInvoke(this, 5, _EJS_s);
			} finally {
				container.putEJSDeployedSupport(_EJS_s);
			}
		}
		return _EJS_result;
	}
	/**
	 * remove
	 */
	public void remove(java.lang.Object arg0) throws java.rmi.RemoteException, javax.ejb.RemoveException {
		EJSDeployedSupport _EJS_s = container.getEJSDeployedSupport(this);
		Object[] _jacc_parms = null;
		
		try {
			if (container.doesJaccNeedsEJBArguments( this ))
			{
				_jacc_parms = new Object[1];
				_jacc_parms[0] = arg0;
			}
	com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080 beanRef = (com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080)container.preInvoke(this, 6, _EJS_s, _jacc_parms);
			beanRef.remove(arg0);
		}
		catch (java.rmi.RemoteException ex) {
			_EJS_s.setUncheckedException(ex);
		}
		catch (javax.ejb.RemoveException ex) {
			_EJS_s.setCheckedException(ex);
			throw ex;
		}
		catch (Throwable ex) {
			_EJS_s.setUncheckedException(ex);
			throw new java.rmi.RemoteException("bean method raised unchecked exception", ex);
		}

		finally {
			try{
				container.postInvoke(this, 6, _EJS_s);
			} finally {
				container.putEJSDeployedSupport(_EJS_s);
			}
		}
		return ;
	}
	/**
	 * remove
	 */
	public void remove(javax.ejb.Handle arg0) throws java.rmi.RemoteException, javax.ejb.RemoveException {
		EJSDeployedSupport _EJS_s = container.getEJSDeployedSupport(this);
		Object[] _jacc_parms = null;
		
		try {
			if (container.doesJaccNeedsEJBArguments( this ))
			{
				_jacc_parms = new Object[1];
				_jacc_parms[0] = arg0;
			}
	com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080 beanRef = (com.ibm.commerce.extension.objects.EJSCMPBonusHomeBean_13725080)container.preInvoke(this, 7, _EJS_s, _jacc_parms);
			beanRef.remove(arg0);
		}
		catch (java.rmi.RemoteException ex) {
			_EJS_s.setUncheckedException(ex);
		}
		catch (javax.ejb.RemoveException ex) {
			_EJS_s.setCheckedException(ex);
			throw ex;
		}
		catch (Throwable ex) {
			_EJS_s.setUncheckedException(ex);
			throw new java.rmi.RemoteException("bean method raised unchecked exception", ex);
		}

		finally {
			try{
				container.postInvoke(this, 7, _EJS_s);
			} finally {
				container.putEJSDeployedSupport(_EJS_s);
			}
		}
		return ;
	}
}
