<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet spdf:version="2.4.1"
  exclude-result-prefixes="ditaarch opentopic spdf specrfc"
  version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
  xmlns:spdf="org.oasis.spec.pdf"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:specrfc="org.oasis.spec.pdf/rfc"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:key name="rfc-terms" match="*[@specrfc:container]" use="true()"/>
   
  <xsl:template match="*[contains(@class,' topic/data ')][@name='rfc-list']">
    <xsl:if test="exists(key('rfc-terms',true())[not(ancestor::draft-comment or ancestor::required-cleanup)])">
      <xsl:variable name="collected-rules-as-list" as="element()">
        <ol class="- topic/ol ">
          <xsl:for-each select="key('rfc-terms',true())[not(ancestor::draft-comment or ancestor::required-cleanup or ancestor::*[@specrfc:container])]">
            <xsl:variable name="elname">
              <xsl:choose>
                <xsl:when test="contains(@class,' topic/ph ')">ph</xsl:when>
                <xsl:when test="contains(@class,' topic/p ')">p</xsl:when>
                <xsl:when test="contains(@class,' topic/div ')">div</xsl:when>
                <xsl:when test="contains(@class,' topic/li ')">li</xsl:when>
              </xsl:choose>
              <!--<xsl:value-of select="name(ancestor::*[ or contains(@class,' topic/p ') or contains(@class,' topic/div ') or
                contains(@class,' topic/li ')][1])"/>-->
            </xsl:variable>
            <li class="- topic/li ">
              <xref class="- topic/xref " href="#{@id}">Conformance item:</xref>
              <xsl:choose>
                <xsl:when test="$elname='ph'"><p class="- topic/p "><xsl:apply-templates select="." mode="copy-normative-rule"/></p></xsl:when>
                <xsl:when test="$elname='p'"><xsl:apply-templates select="." mode="copy-normative-rule"/></xsl:when>
                <xsl:when test="$elname='li'"><p class="- topic/p "><xsl:apply-templates select="node()" mode="copy-normative-rule"/></p></xsl:when>
                <xsl:when test="$elname='div'"><xsl:apply-templates select="." mode="copy-normative-rule"/></xsl:when>
                <xsl:otherwise><xsl:message>Failed to copy in conformance item from <xsl:for-each select="ancestor-or-self::*"><xsl:value-of select="name()"/>/</xsl:for-each></xsl:message>Missing conformance item: <xsl:for-each select="ancestor-or-self::*"><xsl:value-of select="name()"/>/</xsl:for-each></xsl:otherwise>
              </xsl:choose>
            </li>
          </xsl:for-each>
        </ol>
      </xsl:variable>
      
      <xsl:variable name="collected-rules-as-table" as="element()">
        <simpletable relcolwidth="1* 7*" class="- topic/simpletable " outputclass="collected-rfc-rules" id="collected-rfc-rules-as-table" frame="all">
          <sthead class="- topic/sthead ">
            <stentry class="- topic/stentry ">Rule number</stentry>
            <stentry class="- topic/stentry ">Conformance statement</stentry>
          </sthead>
          <xsl:for-each select="key('rfc-terms',true())[not(ancestor::draft-comment or ancestor::required-cleanup or ancestor::*[@specrfc:container])]">
            <xsl:variable name="elname">
              <xsl:choose>
                <xsl:when test="contains(@class,' topic/ph ')">ph</xsl:when>
                <xsl:when test="contains(@class,' topic/p ')">p</xsl:when>
                <xsl:when test="contains(@class,' topic/div ')">div</xsl:when>
                <xsl:when test="contains(@class,' topic/li ')">li</xsl:when>
              </xsl:choose>
              <!--<xsl:value-of select="name(ancestor::*[ or contains(@class,' topic/p ') or contains(@class,' topic/div ') or
                contains(@class,' topic/li ')][1])"/>-->
            </xsl:variable>
            <strow class="- topic/strow ">
              <stentry class="- topic/stentry " id="gen-rfc-item-{position()}"><xref class="- topic/xref " href="#{@id}">Rule <xsl:value-of select="position()"/></xref></stentry>
              <stentry class="- topic/stentry ">
                <xsl:choose>
                  <xsl:when test="$elname='ph'"><xsl:apply-templates select="." mode="copy-normative-rule"/></xsl:when>
                  <xsl:when test="$elname='p'"><xsl:apply-templates select="node()" mode="copy-normative-rule"/></xsl:when>
                  <xsl:when test="$elname='li'"><xsl:apply-templates select="node()" mode="copy-normative-rule"/></xsl:when>
                  <xsl:when test="$elname='div'"><xsl:apply-templates select="node()" mode="copy-normative-rule"/></xsl:when>
                  <xsl:otherwise><xsl:message>Failed to copy in conformance item from <xsl:for-each select="ancestor-or-self::*"><xsl:value-of select="name()"/>/</xsl:for-each></xsl:message>Missing conformance item: <xsl:for-each select="ancestor-or-self::*"><xsl:value-of select="name()"/>/</xsl:for-each></xsl:otherwise>
                </xsl:choose>
              </stentry>
            </strow>
          </xsl:for-each>
        </simpletable>
      </xsl:variable>
      
      <xsl:apply-templates select="$collected-rules-as-table"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="@id" mode="copy-normative-rule"/>
  <xsl:template match="*|@*|text()" mode="copy-normative-rule">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|text()" mode="copy-normative-rule"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>
