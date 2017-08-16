<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet exclude-result-prefixes="ditaarch opentopic spdf" version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/" xmlns:spdf="org.oasis.spec.pdf"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="*[contains(@class, ' topic/sl ')]">
    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]"
      mode="outofline"/>
    <fo:list-block xsl:use-attribute-sets="sl">
      <xsl:call-template name="commonattributes"/>
      <!-- Tagsmiths: left-justify sl for outputclass=no-indent used in cover. Also, fire a keep
            rule because no-indent means that the sl is in the cover. -30oct13 -->
      <xsl:if test="@outputclass = 'no-indent'">
        <xsl:attribute name="provisional-distance-between-starts">0mm</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">0mm</xsl:attribute>
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </fo:list-block>
    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="outofline"
    />
  </xsl:template>

</xsl:stylesheet>
