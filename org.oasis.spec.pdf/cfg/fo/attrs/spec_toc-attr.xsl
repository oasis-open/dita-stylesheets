<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet exclude-result-prefixes="xs ditaarch opentopic spdf" version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:spdf="org.oasis.spec.pdf"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!--  <xsl:attribute-set name="__toc__indent">
    <xsl:attribute name="margin-left">
      <xsl:variable name="level"
        select="count(ancestor-or-self::*[contains(@class, ' topic/topic ') or contains(@class, ' topic/section ')])"/>
      <xsl:value-of select="concat(string(12 + number($level) * 20), 'pt')"/>
    </xsl:attribute>
  </xsl:attribute-set>-->

  <xsl:attribute-set name="__toc__title">
    <xsl:attribute name="font-family">Sans</xsl:attribute>
    <xsl:attribute name="line-height">200%</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="__toc__topic__content">
    <xsl:attribute name="font-family">Sans</xsl:attribute>
    <xsl:attribute name="text-indent">-.2in</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$default-font-size"/>
    </xsl:attribute>
  </xsl:attribute-set>
</xsl:stylesheet>
