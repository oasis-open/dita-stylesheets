<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot" exclude-result-prefixes="dita-ot"
  version="2.0">
  
  <xsl:variable name="topic-id-anchor" select="/*/@id | /dita/*[1]/@id"/>

  <xsl:template name="processFTR">
    <xsl:if test="string-length($FTRFILE) > 0">
      <xsl:apply-templates select="document($FTRFILE, /)" mode="fix-ftr"/>
    </xsl:if>
    <xsl:text>
</xsl:text>
  </xsl:template>

  <xsl:template match="* | text() | @*" mode="fix-ftr">
    <xsl:copy>
      <xsl:apply-templates select="@* | text() | *" mode="fix-ftr"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="a/@href[normalize-space(../text()) = 'main page']" mode="fix-ftr">
    <xsl:attribute name="href">
      <xsl:choose>
        <xsl:when test="contains(., '://')">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$PATH2PROJ"/>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>#</xsl:text>
      <xsl:value-of select="$topic-id-anchor"/>
    </xsl:attribute>
  </xsl:template>


</xsl:stylesheet>
