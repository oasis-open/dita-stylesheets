<?xml version="1.0"?>
<!-- Tagsmiths: Changed XSLT to version 2.0 -04oct13-->
<xsl:stylesheet version="2.0" xmlns:oa="http://www.oasis-open.org"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs oa"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:param name="oasis.landing.page" select="''"/>
  <xsl:param name="oasis.spec.descriptor" select="''"/>
  <xsl:param name="oasis.track" select="'Standards Track Work Product'"/>
  <xsl:param name="oasis.copyright" select="''"/>
  <xsl:param name="oasis.spec.date" select="''"/>
  
  <xsl:variable name="path.to.landing.page">
    <xsl:value-of select="/processing-instruction('path2mapdir-uri')"/>
  </xsl:variable>
  
  <xsl:template name="processFTR">
    <footer role="contentinfo">
      <div>
        <p></p>
        <p>Return to <a href="../../{$path.to.landing.page}{$oasis.landing.page}#{/*/*/resourceid[@appname='spectocid']/@appid}">main page</a>.</p>
        <table class="footer-table" role="presentation">
          <colgroup>
            <col width="25%"/>
            <col width="55%"/>
            <col width="20%"/>
          </colgroup>
          <tr>
            <td class="footer-left">
              <p><xsl:value-of select="$oasis.spec.descriptor"/></p>
              <p><xsl:value-of select="$oasis.track"/></p>
            </td>
            <td class="footer-center"><xsl:value-of select="$oasis.copyright"/></td>
            <td class="footer-right"><xsl:value-of select="$oasis.spec.date"/></td>
          </tr>
        </table>
      </div>
    </footer>
  </xsl:template>

</xsl:stylesheet>
