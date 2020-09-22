<?xml version="1.0"?>
<!-- Tagsmiths: Changed XSLT to version 2.0 -04oct13-->
<xsl:stylesheet version="2.0" xmlns:oa="http://www.oasis-open.org"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs oa"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!--
    Extra attributes added to containers with RFC content:
    <p 
    rfcnum="DITA.CONF.003" 
    rfctarget="../../non-normative/aggregated-RFC-2119-statements.dita#aggregated-RFC-2119-statements/DITA.CONF.003"
  -->
  <xsl:template match="*[@rfcnum][@rfctarget]">
    <div class="rfc-container">
      <div class="rfc-inline-num">
        <xsl:variable name="makexref" as="element(xref)">
          <xref class="- topic/xref " href="{@rfctarget}">
            <xsl:copy-of select="@xtrc|@xtrf"/>
            <xsl:value-of select="@rfcnum"/>
          </xref>
        </xsl:variable>
        <xsl:apply-templates select="$makexref"/>
      </div>
      <div class="rfc-content"><xsl:next-match/></div>
    </div>
  </xsl:template>

</xsl:stylesheet>
