<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet spdf:version="2.4.1"
  exclude-result-prefixes="ditaarch opentopic spdf"
  version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
  xmlns:spdf="org.oasis.spec.pdf"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   
  <xsl:function name="spdf:getXsDate">
    <xsl:param name="incoming" as="xs:string"/>
    <xsl:choose>
      <xsl:when test="matches($incoming, '^[0-9]{4}-[0-9]{2}-[0-9]{2}$')">
        <xsl:copy-of select="xs:date($incoming)"/>
      </xsl:when>
      <xsl:when test="matches($incoming, '^[0-9]{8}$')">
        <xsl:copy-of select="xs:date(replace($incoming, '([0-9]{4})([0-9]{2})([0-9]{2})', '$1-$2-$3'))"/>
      </xsl:when>
    </xsl:choose>
  </xsl:function>
  
</xsl:stylesheet>
