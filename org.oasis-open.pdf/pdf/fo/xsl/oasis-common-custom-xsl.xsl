<?xml version='1.0'?>

<!-- ===================== CHANGE LOG ================================ -->
<!--                                                                   -->
<!-- 05 Sep 2015 KJE: Added change log. Added import statement for     -->
<!--                  layout-masters.xsl.                              -->
<!-- 07 Sep 2015  BT: Added import statement for                       -->
<!--                  oasis-cn-numbering.xsl                           -->
<!--  15 Aug 2015 KJE: Commented out import statements, which were     -->
<!--                   moved to style sheet shell.                     -->
<!--  10 May 2019 KJE: Added templates for RFC-2119 term               -->
<!--  15 May 2019 KJE: Added templates to style note labels as side    -->
<!--                   headers                                         -->
<!--  19 May 2019 KJE: Added templates to render title above figure    -->
<!--  13 Jul 2019 KJE: Added template to style <keyword>               -->
<!--  15 Dec 2019 KJE: Updated template to style <keyword>             -->
<!--                                                                   -->
<!-- ================================================================= --> 

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema" 
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function" version="2.0"
   xmlns:kje="http://www.eberleinconsulting.com">

   <!-- KEYWORD -->
   <!-- Surround the content of <keyword> elements with 
        quotation marks, with the following exceptions:
          * On the cover page
          * Child of <dt>                          -->
   
   <xsl:template match="*[contains(@class,' topic/keyword ')]
                         [not(ancestor-or-self::*[contains(@class,' topic/topic ')][@outputclass='cover'])]
                         [not(ancestor-or-self::*[contains(@class,' topic/dt ')])]">
      <fo:inline>
         <xsl:text>"</xsl:text>
         <xsl:apply-templates/>
         <xsl:text>"</xsl:text>
      </fo:inline>
   </xsl:template>
   
   <!-- FIGURES -->
   <!-- Renders title above figure -->
   
       <xsl:template match="*[contains(@class,' topic/fig ')]">
        <fo:block xsl:use-attribute-sets="fig">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="setFrame"/>
            <xsl:call-template name="setExpanse"/>
            <xsl:call-template name="setScale"/>
            <xsl:if test="not(@id)">
              <xsl:attribute name="id">
                <xsl:call-template name="get-id"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="*[contains(@class,' topic/title ')]"/>
            <xsl:apply-templates select="*[not(contains(@class,' topic/title '))]"/>           
        </fo:block>
    </xsl:template>

   <!-- NOTES -->

   <!-- Table note template -->
   <xsl:template match="*[contains(@class, ' topic/note ')]">
      <xsl:variable name="noteImagePath">
         <xsl:apply-templates select="." mode="setNoteImagePath"/>
      </xsl:variable>
      <fo:table xsl:use-attribute-sets="note__table">
         <fo:table-column xsl:use-attribute-sets="note__image__column"/>
         <fo:table-column xsl:use-attribute-sets="note__text__column"/>
         <fo:table-body>
            <fo:table-row>
               <fo:table-cell xsl:use-attribute-sets="note__image__entry">
                  <xsl:choose>
                     <xsl:when test="not($noteImagePath = '')">
                        <fo:block>
                           <fo:external-graphic
                              src="url('{concat($artworkPrefix, $noteImagePath)}')"
                              xsl:use-attribute-sets="image"/>
                        </fo:block>
                     </xsl:when>
                     <xsl:otherwise>
                        <fo:block xsl:use-attribute-sets="note__label">
                           <xsl:choose>
                              <xsl:when test="@type = 'note' or not(@type)">
                                 <fo:inline xsl:use-attribute-sets="note__label__note">
                                    <xsl:call-template name="getVariable">
                                       <xsl:with-param name="id" select="'Note'"/>
                                    </xsl:call-template>
                                 </fo:inline>
                              </xsl:when>
                              <xsl:when test="@type = 'notice'">
                                 <fo:inline xsl:use-attribute-sets="note__label__notice">
                                    <xsl:call-template name="getVariable">
                                       <xsl:with-param name="id" select="'Notice'"/>
                                    </xsl:call-template>
                                 </fo:inline>
                              </xsl:when>
                              <xsl:when test="@type = 'tip'">
                                 <fo:inline xsl:use-attribute-sets="note__label__tip">
                                    <xsl:call-template name="getVariable">
                                       <xsl:with-param name="id" select="'Tip'"/>
                                    </xsl:call-template>
                                 </fo:inline>
                              </xsl:when>
                              <xsl:when test="@type = 'fastpath'">
                                 <fo:inline xsl:use-attribute-sets="note__label__fastpath">
                                    <xsl:call-template name="getVariable">
                                       <xsl:with-param name="id" select="'Fastpath'"/>
                                    </xsl:call-template>
                                 </fo:inline>
                              </xsl:when>
                              <xsl:when test="@type = 'restriction'">
                                 <fo:inline xsl:use-attribute-sets="note__label__restriction">
                                    <xsl:call-template name="getVariable">
                                       <xsl:with-param name="id" select="'Restriction'"/>
                                    </xsl:call-template>
                                 </fo:inline>
                              </xsl:when>
                              <xsl:when test="@type = 'important'">
                                 <fo:inline xsl:use-attribute-sets="note__label__important">
                                    <xsl:call-template name="getVariable">
                                       <xsl:with-param name="id" select="'Important'"/>
                                    </xsl:call-template>
                                 </fo:inline>
                              </xsl:when>
                              <xsl:when test="@type = 'remember'">
                                 <fo:inline xsl:use-attribute-sets="note__label__remember">
                                    <xsl:call-template name="getVariable">
                                       <xsl:with-param name="id" select="'Remember'"/>
                                    </xsl:call-template>
                                 </fo:inline>
                              </xsl:when>
                              <xsl:when test="@type = 'attention'">
                                 <fo:inline xsl:use-attribute-sets="note__label__attention">
                                    <xsl:call-template name="getVariable">
                                       <xsl:with-param name="id" select="'Attention'"/>
                                    </xsl:call-template>
                                 </fo:inline>
                              </xsl:when>
                              <xsl:when test="@type = 'caution'">
                                 <fo:inline xsl:use-attribute-sets="note__label__caution">
                                    <xsl:call-template name="getVariable">
                                       <xsl:with-param name="id" select="'Caution'"/>
                                    </xsl:call-template>
                                 </fo:inline>
                              </xsl:when>
                              <xsl:when test="@type = 'danger'">
                                 <fo:inline xsl:use-attribute-sets="note__label__danger">
                                    <xsl:call-template name="getVariable">
                                       <xsl:with-param name="id" select="'Danger'"/>
                                    </xsl:call-template>
                                 </fo:inline>
                              </xsl:when>
                              <xsl:when test="@type = 'warning'">
                                 <fo:inline xsl:use-attribute-sets="note__label__danger">
                                    <xsl:call-template name="getVariable">
                                       <xsl:with-param name="id" select="'Warning'"/>
                                    </xsl:call-template>
                                 </fo:inline>
                              </xsl:when>
                              <xsl:when test="@type = 'trouble'">
                                 <fo:inline xsl:use-attribute-sets="note__label__trouble">
                                    <xsl:call-template name="getVariable">
                                       <xsl:with-param name="id" select="'Trouble'"/>
                                    </xsl:call-template>
                                 </fo:inline>
                              </xsl:when>
                              <xsl:when test="@type = 'other'">
                                 <fo:inline xsl:use-attribute-sets="note__label__other">
                                    <xsl:choose>
                                       <xsl:when test="@othertype">
                                          <xsl:value-of select="@othertype"/>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <xsl:text>[</xsl:text>
                                          <xsl:value-of select="@type"/>
                                          <xsl:text>]</xsl:text>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </fo:inline>
                              </xsl:when>
                           </xsl:choose>
                        </fo:block>
                     </xsl:otherwise>
                  </xsl:choose>

               </fo:table-cell>
               <fo:table-cell xsl:use-attribute-sets="note__text__entry">
                  <xsl:apply-templates select="." mode="placeNoteContent"/>
               </fo:table-cell>
            </fo:table-row>
         </fo:table-body>
      </fo:table>
   </xsl:template>

   <!-- Place note content -->
   <xsl:template match="*" mode="placeNoteContent">
      <fo:block xsl:use-attribute-sets="note">
         <xsl:call-template name="commonattributes"/>
         <fo:inline xsl:use-attribute-sets="note__label"/>
         <xsl:apply-templates/>
      </fo:block>
   </xsl:template>

</xsl:stylesheet>
