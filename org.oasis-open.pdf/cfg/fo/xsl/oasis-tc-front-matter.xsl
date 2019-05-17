<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 08 May 2019 KJE: Initial creation                                 -->
<!--                                                                   -->
<!-- ================================================================= -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:opentopic="http://www.idiominc.com/opentopic"
                exclude-result-prefixes="opentopic"
                version="2.0">
  
      <xsl:template name="createFrontMatter">
      <xsl:if test="$generate-front-cover">
        <fo:page-sequence master-reference="front-matter" xsl:use-attribute-sets="page-sequence.cover">
            <xsl:call-template name="insertFrontMatterStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
              <fo:block-container xsl:use-attribute-sets="__frontmatter">
                <xsl:call-template name="createFrontCoverContents"/>
              </fo:block-container>
            </fo:flow>
        </fo:page-sequence>
      </xsl:if>
    </xsl:template>

</xsl:stylesheet>