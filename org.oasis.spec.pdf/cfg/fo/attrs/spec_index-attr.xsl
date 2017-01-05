<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

  <xsl:attribute-set name="__index__label" use-attribute-sets="common.title"/>

  <xsl:attribute-set name="__index__letter-group" use-attribute-sets="common.title"/>

  <xsl:attribute-set name="index-indents">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$small-font-size"/>
    </xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>
