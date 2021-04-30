<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 01 Dec 2019 KJE: Original creation                                -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    exclude-result-prefixes="opentopic opentopic-index dita2xslfo"
    version="2.0">

    <!-- Add label for <tasktroubleshooting -->
    <xsl:template match="*[contains(@class, ' task/tasktroubleshooting ')]">
        <fo:block xsl:use-attribute-sets="result">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates select="." mode="dita2xslfo:task-heading">
                <xsl:with-param name="use-label">
                    <xsl:apply-templates select="." mode="dita2xslfo:retrieve-task-heading">
                      <xsl:with-param name="pdf2-string">Task Troubleshooting</xsl:with-param>
                      <!--<xsl:with-param name="common-string">troubleshooting</xsl:with-param>-->
                    </xsl:apply-templates>
                </xsl:with-param>
            </xsl:apply-templates>
            <fo:block xsl:use-attribute-sets="result__content">
              <xsl:apply-templates/>
            </fo:block>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
