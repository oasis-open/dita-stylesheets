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
  <!-- XML file with all of the RFC items -->
  <xsl:param name="rfclist.file"/>
  <!-- Name of the file with aggregated list of RFC items -->
  <xsl:param name="rfclist.dita.topic"/>
  
  <!-- Path back to the map directory for links -->
  <xsl:variable name="dotdots">
    <xsl:choose>
      <xsl:when test="$FILEDIR = '.' or $FILEDIR = ''"></xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="tokenize($FILEDIR, '/')">../</xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
    
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
  
  <!-- Any element with @rfclink is an RFC block. Find out the number, add metadata.
  1. What was the RFC number?
  2. What is the link target in the aggregated list?-->
  <xsl:template match="@rfclink">
    <xsl:variable name="searchid" select="."/>
    <xsl:variable name="rfcnum" select="document($rfclist.file)/rfclist/rfcitem[@rfclink = $searchid]/@rfcid"/>
    <xsl:attribute name="rfcnum" select="$rfcnum"/>    
    <xsl:attribute name="rfctarget" select="concat($dotdots, $rfclist.dita.topic, '/', $rfcnum)"/>
  </xsl:template>
  
  <xsl:template match="*[@rfclink]">
    <xsl:variable name="searchid" select="@rfclink"/>
    <xsl:variable name="rfcnum" select="document($rfclist.file)/rfclist/rfcitem[@rfclink = $searchid]/@rfcid"/>
    <xsl:variable name="xref" as="element(xref)">
      <xref class="- topic/xref " 
        scope="local" href="{concat($dotdots, $rfclist.dita.topic, '/', $rfcnum)}"
        xtrc="{@xtrc}" xtrf="{@xtrf}">
          <xsl:value-of select="$rfcnum"/>
        <desc class="- topic/desc ">Conformance item <xsl:value-of select="$rfcnum"/></desc>
      </xref>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="contains(@class,' topic/li ')">
        <xsl:copy>
          <xsl:apply-templates select="@*"/>
          <rfcdiv class="+ topic/div oasis/rfcdiv " xtrc="{@xtrc}" xtrf="{@xtrf}">
            <rfcnum class="+ topic/div oasis/rfcnum " xtrc="{@xtrc}" xtrf="{@xtrf}">
              <xsl:copy-of select="$xref"/>
            </rfcnum>
            <rfctext class="+ topic/div oasis/rfctext " xtrc="{@xtrc}" xtrf="{@xtrf}">
              <xsl:apply-templates/>
            </rfctext>
          </rfcdiv>
        </xsl:copy>
      </xsl:when>
      <xsl:otherwise>
        <rfcdiv class="+ topic/div oasis/rfcdiv " xtrc="{@xtrc}" xtrf="{@xtrf}" id="{@id}">
          <rfcnum class="+ topic/div oasis/rfcnum " xtrc="{@xtrc}" xtrf="{@xtrf}">
            <xsl:copy-of select="$xref"/>
          </rfcnum>
          <rfctext class="+ topic/div oasis/rfctext " xtrc="{@xtrc}" xtrf="{@xtrf}">
            <xsl:next-match/>
          </rfctext>
        </rfcdiv>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*[@rfclink][not(contains(@class,' topic/li '))]/@id">
    <!-- ID was moved up to the <rfcdiv> container, except for list items, 
      which remain the target --> 
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
      <simpletable relcolwidth="1* 9*" class="- topic/simpletable " outputclass="collected-rfc-rules" id="collected-rfc-rules-as-table" frame="all">
        <sthead class="- topic/sthead ">
          <stentry class="- topic/stentry " dita-ot:y="1" dita-ot:x="1">Item</stentry>
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
              id="{@rfcid}" 
              dita-ot:y="{$rownum}" dita-ot:x="1">
              <xref 
                class="- topic/xref " 
                outputclass="rfc-inline-num"
                href="{$dotdots}{@href}"
                type="topic"
                xtrf="{$xtrf}"
                xtrc="{$xtrc}">
                  <xsl:value-of select="@rfcid"/>
                <desc class="- topic/desc ">Conformance item <xsl:value-of select="@rfcid"/></desc>
              </xref>
            </stentry>
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
