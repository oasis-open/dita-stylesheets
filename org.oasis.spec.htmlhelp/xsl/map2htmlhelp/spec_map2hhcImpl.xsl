<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="dita-ot xs">

  <!-- Bob Thomas: string leading and trailing whitespace off of navtitle. 26jan18 -->
  <xsl:template match="*[contains(@class, ' topic/navtitle ')]" mode="dita-ot:text-only">
    <xsl:variable name="thisText">
      <xsl:apply-templates select="text() | * | processing-instruction()" mode="dita-ot:text-only"/>
    </xsl:variable>
    <xsl:value-of select="replace($thisText, '^\s+', '')"/>
  </xsl:template>

</xsl:stylesheet>
