package com.ibm.commerce.extension.objects;

import com.ibm.ejs.persistence.*;
import javax.ejb.EntityBean;
import java.sql.*;

/**
 * EJSJDBCPersisterCMPBonusBean_13725080
 */
public class EJSJDBCPersisterCMPBonusBean_13725080 extends EJSJDBCPersister implements com.ibm.commerce.extension.objects.EJSFinderBonusBean {
	private static final String _createString = "INSERT INTO XBONUS (MEMBERID, BONUSPOINT, OPTCOUNTER) VALUES (?, ?, ?)";
	private static final String _removeString = "DELETE FROM XBONUS  WHERE MEMBERID = ?";
	private static final String _storeString = "UPDATE XBONUS  SET BONUSPOINT = ?, OPTCOUNTER = ? WHERE MEMBERID = ?";
	private static final String _loadString = " SELECT T1.MEMBERID, T1.BONUSPOINT, T1.OPTCOUNTER FROM XBONUS  T1 WHERE T1.MEMBERID = ?";
	private static final String _loadForUpdateString = _loadString + " FOR UPDATE";
	private static final String[] _predicateColumnNames = {"OPTCOUNTER"};
	private static final boolean[] _predicateMaps = {true};
	private byte[] serObj = null;
	/**
	 * EJSJDBCPersisterCMPBonusBean_13725080
	 */
	public EJSJDBCPersisterCMPBonusBean_13725080() throws java.rmi.RemoteException {
		super();	}
	/**
	 * postInit
	 */
	public void postInit() {
	}
	/**
	 * _create
	 */
	public void _create(EntityBean eb) throws Exception {
		Object objectTemp = null;
		BonusBean b = (BonusBean) eb;
		PreparedStatement pstmt;
		Object cacheData[] = new Object[1];
		pstmt = getPreparedStatement(_createString);
		try {
			if (b.memberId == null) {
				pstmt.setNull(1, java.sql.Types.BIGINT);
			}
			else {
				pstmt.setLong(1, b.memberId.longValue());
			}
			if (b.bonusPoint == null) {
				pstmt.setNull(2, java.sql.Types.INTEGER);
			}
			else {
				pstmt.setInt(2, b.bonusPoint.intValue());
			}
			pstmt.setShort(3, b.optCounter);
			cacheData[0] = new Short(b.optCounter);
			pstmt.executeUpdate();
		}
		finally {
			returnPreparedStatement(pstmt);
		}
		putDataIntoCache(cacheData);
	}
	/**
	 * hydrate
	 */
	public void hydrate(EntityBean eb, Object data, Object pKey) throws Exception {
		Object objectTemp = null;
		BonusBean b = (BonusBean) eb;
		com.ibm.commerce.extension.objects.BonusKey _primaryKey = (com.ibm.commerce.extension.objects.BonusKey)pKey;
		java.sql.ResultSet resultSet = (java.sql.ResultSet) data;
		short tempshort;
		int tempint;

		b.memberId = _primaryKey.memberId;
		tempint = resultSet.getInt(2);
		b.bonusPoint = resultSet.wasNull() ? null : new Integer(tempint);
		b.optCounter = resultSet.getShort(3);
		Object[] cacheData = new Object[1];
		tempshort = resultSet.getShort(3);
		cacheData[0] = resultSet.wasNull() ? null : new Short(tempshort);
		putDataIntoCache(cacheData);
	}
	/**
	 * load
	 */
	public void load(EntityBean eb, Object pKey, boolean forUpdate) throws Exception {
		Object objectTemp = null;
		BonusBean b = (BonusBean) eb;
		com.ibm.commerce.extension.objects.BonusKey _primaryKey = (com.ibm.commerce.extension.objects.BonusKey)pKey;
		PreparedStatement pstmt;
		ResultSet resultSet = null;
		pstmt = getPreparedStatement(_loadString);
		try {
			if (_primaryKey.memberId == null) {
				pstmt.setNull(1, java.sql.Types.BIGINT);
			}
			else {
				pstmt.setLong(1, _primaryKey.memberId.longValue());
			}
			resultSet = pstmt.executeQuery();
			if (!(resultSet.next())) throw new javax.ejb.ObjectNotFoundException();
			hydrate(eb, resultSet, pKey);
		}
		finally {
			if (resultSet != null) resultSet.close();
			returnPreparedStatement(pstmt);
		}
	}
	/**
	 * refresh
	 */
	public void refresh(EntityBean eb, boolean forUpdate) throws Exception {
		BonusBean b = (BonusBean) eb;
		com.ibm.commerce.extension.objects.BonusKey _primaryKey = new com.ibm.commerce.extension.objects.BonusKey();
		_primaryKey.memberId = b.memberId;
		load(b, _primaryKey, forUpdate);
	}
	/**
	 * store
	 */
	public void store(EntityBean eb) throws Exception {
		Object objectTemp = null;
		BonusBean b = (BonusBean) eb;
		com.ibm.commerce.extension.objects.BonusKey _primaryKey = new com.ibm.commerce.extension.objects.BonusKey();
		_primaryKey.memberId = b.memberId;
		PreparedStatement pstmt;
		Object cacheData[] = getDataFromCache();
		RdbRt  aTemplate = new RdbRt(_storeString, _predicateColumnNames, _predicateMaps);
		pstmt = getPreparedStatement(aTemplate.nativeQuery(cacheData));
		try {
			if (_primaryKey.memberId == null) {
				pstmt.setNull(3, java.sql.Types.BIGINT);
			}
			else {
				pstmt.setLong(3, _primaryKey.memberId.longValue());
			}
			if (b.bonusPoint == null) {
				pstmt.setNull(1, java.sql.Types.INTEGER);
			}
			else {
				pstmt.setInt(1, b.bonusPoint.intValue());
			}
			pstmt.setShort(2, b.optCounter);
			int inputPos = 3;
			if (cacheData[0] != null) {
				pstmt.setShort(++inputPos, ((Number)cacheData[0]).shortValue());
			}
			if (pstmt.executeUpdate() < 1) {
				throw new OptimisticUpdateFailureException("executeUpdate returned zero rows updated");
			}
		}
		finally {
			returnPreparedStatement(pstmt);
		}
	}
	/**
	 * remove
	 */
	public void remove(EntityBean eb) throws Exception {
		Object objectTemp = null;
		BonusBean b = (BonusBean) eb;
		com.ibm.commerce.extension.objects.BonusKey _primaryKey = new com.ibm.commerce.extension.objects.BonusKey();
		_primaryKey.memberId = b.memberId;
		PreparedStatement pstmt;
		Object cacheData[] = getDataFromCache();
		RdbRt  aTemplate = new RdbRt(_removeString, _predicateColumnNames, _predicateMaps);
		pstmt = getPreparedStatement(aTemplate.nativeQuery(cacheData));
		try {
			if (_primaryKey.memberId == null) {
				pstmt.setNull(1, java.sql.Types.BIGINT);
			}
			else {
				pstmt.setLong(1, _primaryKey.memberId.longValue());
			}
			int inputPos = 1;
			if (cacheData[0] != null) {
				pstmt.setShort(++inputPos, ((Number)cacheData[0]).shortValue());
			}
			if (pstmt.executeUpdate() < 1) {
				throw new OptimisticUpdateFailureException("executeUpdate returned zero rows updated");
			}
		}
		finally {
			returnPreparedStatement(pstmt);
		}
	}
	/**
	 * getPrimaryKey
	 */
	public Object getPrimaryKey(Object data) throws Exception {
		com.ibm.commerce.extension.objects.BonusKey key = new com.ibm.commerce.extension.objects.BonusKey();
		java.sql.ResultSet resultSet = (java.sql.ResultSet) data;

		if (resultSet != null) {
			Object objectTemp = null;
			long templong;

			templong = resultSet.getLong(1);
			key.memberId = resultSet.wasNull() ? null : new Long(templong);
			return key;
		}
return null;
	}

	/**
	 * RdbRt
	 */
	public class RdbRt {
	public static final String EQUALS = " = ";
	public static final String ISNULL = " IS NULL";
	public static final String MARKER = "?";
	public static final String AND = " AND ";
	private String fStatement;
	private String[] fPredicates = new String[0];
	private boolean[] fPredicateMap = new boolean[0];
	public RdbRt() { }
	public RdbRt(String aStmt) {
		rootStmt(aStmt);
	}
	public RdbRt(String aStmt, String[] anArray, boolean[] aMap) {
		rootStmt(aStmt);
		predicates(anArray);
		predicateMap(aMap);
	}
	public String nativeQuery() {
		StringBuffer aBuffer = new StringBuffer();
		statementOn(aBuffer);
		return aBuffer.toString();
	}
	public String nativeQuery(Object[] values) {
		StringBuffer aBuffer = new StringBuffer();
		statementOn(aBuffer, values);
		return aBuffer.toString();
	}
	public String[] predicates() {
		return fPredicates;
	}
	public void predicates(String[] anArray) {
		fPredicates = anArray;
	}
	public boolean[] predicateMap() {
		return fPredicateMap;
	}
	public void predicateMap(boolean[] anArray) {
		fPredicateMap = anArray;
	}
	public void predicatesOn(StringBuffer aBuffer, Object[] values) {
		int j = predicates().length;
		if (j != values.length)
			throw new RuntimeException("differing number of predicates and values");
		String each;
		for (int i = 0; i < j; i++) {
			if (!fPredicateMap[i]) continue;
				aBuffer.append(AND);
			each = predicates()[i];
			aBuffer.append(each);
			if (values[i] == null)
				aBuffer.append(ISNULL);
			else {
				aBuffer.append(EQUALS);
				aBuffer.append(MARKER);
			}
		}
	}
	public String rootStmt() {
		return fStatement;
	}
	public void rootStmt(String aStmt) {
		fStatement = aStmt;
	}
	public void statementOn(StringBuffer aBuffer) {
		aBuffer.append(rootStmt());
	}
	public void statementOn(StringBuffer aBuffer, Object[] values) {
		aBuffer.append(rootStmt());
		if (predicates() != null && predicates().length != 0) {
			predicatesOn(aBuffer, values);
		}
	}
	}
	/**
	 * supportsFluffOnFind
	 */
	public boolean supportsFluffOnFind() {
		return false;
	}
	/**
	 * findByMemberId
	 */
	public com.ibm.commerce.extension.objects.Bonus findByMemberId(java.lang.Long memberId) throws javax.ejb.FinderException, java.rmi.RemoteException {
		ResultSet resultSet = null;
		PreparedStatement pstmt = null;
		com.ibm.commerce.extension.objects.Bonus result = null;

		EJSJDBCFinder tmpFinder = null;
		try {
			preFind();
			pstmt = getPreparedStatement(" SELECT T1.MEMBERID, T1.BONUSPOINT, T1.OPTCOUNTER FROM XBONUS  T1 WHERE T1.MEMBERID = ?");
			pstmt.setLong(1, (long)memberId.longValue());
			resultSet = pstmt.executeQuery();
			tmpFinder = new EJSJDBCFinder(resultSet, this, pstmt);
			if (tmpFinder.hasMoreElements()) {
				result = (com.ibm.commerce.extension.objects.Bonus)tmpFinder.nextElement();
				if (tmpFinder.hasMoreElements())
					throw new javax.ejb.FinderException("Single object finder returned more than one object.");
			}
		}
		catch (javax.ejb.FinderException ex) {
			throw ex;
		}
		catch (Exception ex) {
			throw new EJSPersistenceException("find failed:", ex);
		}
		finally {
			if ( tmpFinder != null ) tmpFinder.close();
		}
		if (result == null) {
			throw new javax.ejb.ObjectNotFoundException();
		}
		return result;
	}
	/**
	 * findByPrimaryKey
	 */
	public com.ibm.commerce.extension.objects.Bonus findByPrimaryKey(com.ibm.commerce.extension.objects.BonusKey primaryKey) throws java.rmi.RemoteException, javax.ejb.FinderException {
		return (com.ibm.commerce.extension.objects.Bonus) home.activateBean(primaryKey);
	}
}
