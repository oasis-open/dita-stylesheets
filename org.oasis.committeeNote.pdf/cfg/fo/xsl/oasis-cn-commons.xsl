<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    exclude-result-prefixes="ot-placeholder opentopic opentopic-index opentopic-func dita2xslfo xs"
    version="2.0">
    
    <!-- ===================== CHANGE LOG ================================ -->
    <!--                                                                   -->
    <!-- 5 Sept 2015: Eberlein, added change log.                          -->
    <!-- ================================================================= --> 

    <!-- OVERRIDE FOR DRAFT COMMENTS -->
    
    <xsl:template match="*[contains(@class,' topic/draft-comment ')]">
        <xsl:if test="$DRAFT='yes'">
            <fo:block xsl:use-attribute-sets="draft-comment">
                <xsl:call-template name="commonattributes"/>
                <fo:block xsl:use-attribute-sets="draft-comment__label">
                    <xsl:choose>
                        <xsl:when test="normalize-space(@author)!=''">
                            Comment by 
                            <xsl:value-of select="@author"/>
                            <xsl:choose>
                                <xsl:when test="normalize-space(@time)!=''">
                                    on  
                                    <xsl:value-of select="@time"/>  
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                </fo:block>
                <xsl:apply-templates/>
            </fo:block>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
