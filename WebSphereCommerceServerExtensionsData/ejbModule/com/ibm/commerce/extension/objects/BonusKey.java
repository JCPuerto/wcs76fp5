package com.ibm.commerce.extension.objects;

/**
 * Key class for Entity Bean: Bonus
 */
public class BonusKey implements java.io.Serializable {

	static final long serialVersionUID = 3206093459760846163L;

	/**
	 * Implementation field for persistent attribute: memberId
	 */
	public java.lang.Long memberId;

	/**
	 * Creates an empty key for Entity Bean: Bonus
	 */
	public BonusKey() {
	}

	/**
	 * Creates a key for Entity Bean: Bonus
	 */
	public BonusKey(java.lang.Long memberId) {
		this.memberId = memberId;
	}

	/**
	 * Returns true if both keys are equal.
	 */
	public boolean equals(java.lang.Object otherKey) {
		if (otherKey instanceof com.ibm.commerce.extension.objects.BonusKey) {
			com.ibm.commerce.extension.objects.BonusKey o = (com.ibm.commerce.extension.objects.BonusKey) otherKey;
			return ((this.memberId.equals(o.memberId)));
		}
		return false;
	}

	/**
	 * Returns the hash code for the key.
	 */
	public int hashCode() {
		return (memberId.hashCode());
	}
}
