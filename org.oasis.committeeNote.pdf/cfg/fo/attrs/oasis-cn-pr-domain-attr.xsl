<?xml version="1.0"?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 25 May 2017 KJE: Initial version.                                 -->
<!-- 07 Mar 2019 KJE: Changed font-size to a variable                  -->
<!--                                                                   -->
<!-- ================================================================= -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                version="2.0">
    
    <xsl:attribute-set name="codeblock" use-attribute-sets="pre">
        <xsl:attribute name="font-size">
            <xsl:value-of select="$default-codeblock-font-size"/>
        </xsl:attribute>
    </xsl:attribute-set>
 
</xsl:stylesheet>