<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!--  23 Sep 2020 KJE: Initial creation                                -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema" 
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function" version="2.0"
   xmlns:kje="http://www.eberleinconsulting.com">

   <!-- RFC-2119 TERMS -->
   <xsl:template match="*[contains(@class, ' topic/term ')][@outputclass = 'RFC-2119']">
      <fo:inline xsl:use-attribute-sets="RFC-2119">
         <xsl:call-template name="commonattributes"/>
         <xsl:apply-templates/>
      </fo:inline>
   </xsl:template>
   
   <xsl:template match="*[contains(@class,' oasis/rfcdiv ')]">
      <!--<fo:block xsl:use-attribute-sets="RFC-2119-statement">
         <xsl:apply-templates select="@id"/>
         <xsl:apply-templates/>
      </fo:block>-->
      <fo:table margin-top="1em" padding-before="1em" id="{@id}">
         <fo:table-column column-width="18%" column-number="1"/>
         <fo:table-column column-width="82%" column-number="2"/>
         <fo:table-body>
            <fo:table-row>
               <fo:table-cell border-right-style="solid" border-right-color="blue" padding-right="2em">
                  <xsl:apply-templates select="rfcnum"/>
               </fo:table-cell>
               <fo:table-cell border-right-style="solid" border-right-color="blue" padding-left="1em">
                  <xsl:apply-templates select="rfctext"/>
               </fo:table-cell>
            </fo:table-row>
         </fo:table-body>
      </fo:table>
   </xsl:template>
   
   <xsl:template match="*[contains(@class,' oasis/rfcnum ')]">
      <fo:block>
         <fo:inline>
            <xsl:apply-templates/>
         </fo:inline>
      </fo:block>
   </xsl:template>
   
   <xsl:template match="*[contains(@class,' oasis/rfctext ')]">
      <fo:block>
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>

</xsl:stylesheet>
