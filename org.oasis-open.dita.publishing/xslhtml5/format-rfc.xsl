<?xml version="1.0"?>
<!-- Tagsmiths: Changed XSLT to version 2.0 -04oct13-->
<xsl:stylesheet version="2.0" xmlns:oa="http://www.oasis-open.org"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs oa"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:template match="*[contains(@class,' oasis/rfcdiv ')]">
    <table role="presentation" class="rfctable">
      <xsl:call-template name="setid"/>
      <colgroup>
        <col width="15%"/>
        <col width="85%"/>
      </colgroup>
      <tbody>
        <tr>
          <td class="rfcnum">
            <xsl:apply-templates select="rfcnum/node()"/>
          </td>
          <td class="rfctext">
            <xsl:apply-templates select="rfctext/node()"/>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' oasis/rfcnum ')]">
    <div class="rfc-number">
      <p class="rfc-number"><xsl:apply-templates/></p>
    </div>
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' oasis/rfctext ')]">
    <div class="rfc-content">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

</xsl:stylesheet>
