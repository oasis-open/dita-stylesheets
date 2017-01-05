<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet exclude-result-prefixes="xs ditaarch opentopic spdf" version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/" xmlns:spdf="org.oasis.spec.pdf"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:attribute-set name="apiname" use-attribute-sets="__inline__monospace"/>

  <xsl:attribute-set name="codeblock">
    <xsl:attribute name="font-style">normal</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$small-monospace-size"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="codeph" use-attribute-sets="__inline__monospace"/>

  <xsl:attribute-set name="delim" use-attribute-sets="__inline__monospace"/>

  <xsl:attribute-set name="fragref" use-attribute-sets="__inline__monospace"/>

  <xsl:attribute-set name="kwd" use-attribute-sets="__inline__monospace"/>

  <xsl:attribute-set name="oper" use-attribute-sets="__inline__monospace"/>

  <xsl:attribute-set name="sep" use-attribute-sets="__inline__monospace"/>

</xsl:stylesheet>
