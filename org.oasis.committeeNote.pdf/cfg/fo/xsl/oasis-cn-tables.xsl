<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  exclude-result-prefixes="opentopic-func xs dita2xslfo dita-ot"
  version="2.0">
    
    <!-- ===================== CHANGE LOG ================================ -->
    <!--                                                                   -->
    <!-- 5 Sept 2015: Eberlein, added change log.                          -->
    <!-- ================================================================= --> 

    <!-- OVERRIDE TO RENDER COLUMN AND ROW SEPARATORS BY DEFAULT -->
    <xsl:variable name="table.rowsep-default" select="'1'"/>
    <xsl:variable name="table.colsep-default" select="'1'"/>

    <!-- OVERRIDE FOR DEFINITION LISTS -->
    <xsl:template match="*[contains(@class, ' topic/dl ')]">
        <fo:block xsl:use-attribute-sets="dl">
            <xsl:call-template name="commonattributes" />
            <xsl:apply-templates select="*[contains(@class, ' topic/dlentry ')]" />
        </fo:block>
    </xsl:template>
    <xsl:template match="*[contains(@class, ' topic/dlentry ')]">
        <fo:block>
            <xsl:apply-templates select="*[contains(@class, ' topic/dt ')]" />
            <xsl:apply-templates select="*[contains(@class, ' topic/dd ')]" />
        </fo:block>
    </xsl:template>
    <xsl:template match="*[contains(@class, ' topic/dt ')]">
        <fo:block xsl:use-attribute-sets="dlentry.dt__content">
            <xsl:apply-templates />
        </fo:block>
    </xsl:template>
    <xsl:template match="*[contains(@class, ' topic/dd ')]">
        <fo:block xsl:use-attribute-sets="dlentry.dd__content">
            <xsl:apply-templates />
        </fo:block>
    </xsl:template>

</xsl:stylesheet>