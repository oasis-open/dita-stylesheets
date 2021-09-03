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
   
   <!-- Matches default simpletable, but with override to support default 10/90 column widths.
   Also removed some bits that do not apply to this table, like checking for missing rows. -->
   <xsl:template match="*[contains(@class, ' topic/simpletable ')][@outputclass='collected-rfc-rules']">
      <xsl:variable name="number-cells" as="xs:integer">
         <!-- Contains the number of cells in the widest row -->
         <xsl:apply-templates select="*[1]" mode="count-max-simpletable-cells"/>
      </xsl:variable>
      <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="outofline"/>
      <xsl:apply-templates select="*[contains(@class, ' topic/title ')]"/>
      <fo:table xsl:use-attribute-sets="simpletable">
         <xsl:call-template name="commonattributes"/>
         <xsl:call-template name="globalAtts"/>
         <xsl:call-template name="displayAtts">
            <xsl:with-param name="element" select="."/>
         </xsl:call-template>
         
         <!-- Create FOP compatible column widths -->
         <fo:table-column column-width="10%" column-number="1"/>
         <fo:table-column column-width="90%" column-number="2"/>
         
         <!-- Toss processing to another template to process the simpletable
                 heading, and/or create a default table heading row. -->
         <xsl:apply-templates select="*[contains(@class, ' topic/sthead ')]">
            <xsl:with-param name="number-cells" select="$number-cells" tunnel="yes"/>
         </xsl:apply-templates>
         
         <fo:table-body xsl:use-attribute-sets="simpletable__body">
            <xsl:apply-templates select="*[contains(@class, ' topic/strow ')]">
               <xsl:with-param name="number-cells" select="$number-cells" tunnel="yes"/>
            </xsl:apply-templates>
         </fo:table-body>
      </fo:table>
      <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline"/>
   </xsl:template>

</xsl:stylesheet>
