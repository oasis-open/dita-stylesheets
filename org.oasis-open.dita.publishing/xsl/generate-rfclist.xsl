<?xml version='1.0' encoding='utf-8'?>
<!-- Look for <data name="rfc-list"/> and replace it
  with a generated list of RFC items based on the
  collected list. -->
<xsl:stylesheet spdf:version="2.4.1"
  exclude-result-prefixes="ditaarch opentopic spdf specrfc"
  version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
  xmlns:spdf="org.oasis.spec.pdf"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:specrfc="org.oasis.spec.pdf/rfc"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:param name="FILENAME"/>
  <xsl:param name="FILEDIR"/>
  <xsl:param name="rfclist.file"/>
    
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="@* | node()">
    <xsl:param name="spectopicnum"/>
    <xsl:param name="spectocid"/>
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
   
  <xsl:template match="*[contains(@class,' topic/data ')][@name='rfc-list']">
    <xsl:apply-templates select="document($rfclist.file)/*" mode="generate-rfclist">
      <xsl:with-param name="xtrf" select="@xtrf"/>
      <xsl:with-param name="xtrc" select="@xtrc"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="/*" mode="generate-rfclist">
    <xsl:param name="xtrf"/>
    <xsl:param name="xtrc"/>
    <xsl:if test="rfcitem">
      <xsl:variable name="dotdots">
        <xsl:choose>
          <xsl:when test="$FILEDIR = '.' or $FILEDIR = ''"></xsl:when>
          <xsl:otherwise>
            <xsl:for-each select="tokenize($FILEDIR, '/')">../</xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <simpletable relcolwidth="1* 7*" class="- topic/simpletable " outputclass="collected-rfc-rules" id="collected-rfc-rules-as-table" frame="all">
        <sthead class="- topic/sthead ">
          <stentry class="- topic/stentry " dita-ot:y="1" dita-ot:x="1">Rule number</stentry>
          <stentry class="- topic/stentry " dita-ot:y="1" dita-ot:x="2">Conformance statement</stentry>
        </sthead>
        <xsl:for-each select="rfcitem">
          <xsl:variable name="elname">
            <xsl:choose>
              <xsl:when test="*[contains(@class,' topic/ph ')]">ph</xsl:when>
              <xsl:when test="*[contains(@class,' topic/p ')]">p</xsl:when>
              <xsl:when test="*[contains(@class,' topic/div ')]">div</xsl:when>
              <xsl:when test="*[contains(@class,' topic/li ')]">li</xsl:when>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="rownum" select="1 + position()"/>
          <strow class="- topic/strow ">
            <stentry class="- topic/stentry " 
              id="gen-rfc-item-{position()}" 
              dita-ot:y="{$rownum}" dita-ot:x="1">
              <xref 
                class="- topic/xref " 
                href="{$dotdots}{@href}"
                type="topic"
                xtrf="{$xtrf}"
                xtrc="{$xtrc}">CONF-DITA.<xsl:value-of select="format-number(position(), '000')"/></xref></stentry>
            <stentry class="- topic/stentry " dita-ot:y="{$rownum}" dita-ot:x="2">
              <xsl:choose>
                <xsl:when test="$elname='ph'"><xsl:apply-templates select="*"/></xsl:when>
                <xsl:when test="$elname='p'"><xsl:apply-templates select="*/node()"/></xsl:when>
                <xsl:when test="$elname='li'"><xsl:apply-templates select="*/node()"/></xsl:when>
                <xsl:when test="$elname='div'"><xsl:apply-templates select="*/node()"/></xsl:when>
                <xsl:otherwise><xsl:message>Failed to copy in conformance item from <xsl:for-each select="ancestor-or-self::*"><xsl:value-of select="name()"/>/</xsl:for-each></xsl:message>Missing conformance item: <xsl:for-each select="ancestor-or-self::*"><xsl:value-of select="name()"/>/</xsl:for-each></xsl:otherwise>
              </xsl:choose>
            </stentry>
          </strow>
        </xsl:for-each>
      </simpletable>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>
