/**
 * SoundType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.unqualifieddatatypes._1._1;

public class SoundType  {
    private java.lang.String format;  // attribute
    private javax.xml.soap.SOAPElement mimeCode;  // attribute
    private java.lang.String encodingCode;  // attribute
    private java.net.URI uri;  // attribute
    private java.lang.String filename;  // attribute
    private byte[] _value;

    public SoundType() {
    }

    public java.lang.String getFormat() {
        return format;
    }

    public void setFormat(java.lang.String format) {
        this.format = format;
    }

    public javax.xml.soap.SOAPElement getMimeCode() {
        return mimeCode;
    }

    public void setMimeCode(javax.xml.soap.SOAPElement mimeCode) {
        this.mimeCode = mimeCode;
    }

    public java.lang.String getEncodingCode() {
        return encodingCode;
    }

    public void setEncodingCode(java.lang.String encodingCode) {
        this.encodingCode = encodingCode;
    }

    public java.net.URI getUri() {
        return uri;
    }

    public void setUri(java.net.URI uri) {
        this.uri = uri;
    }

    public java.lang.String getFilename() {
        return filename;
    }

    public void setFilename(java.lang.String filename) {
        this.filename = filename;
    }

    public byte[] get_value() {
        return _value;
    }

    public void set_value(byte[] _value) {
        this._value = _value;
    }

}
