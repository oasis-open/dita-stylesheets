<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">

    <!-- ===================== CHANGE LOG ================================ -->
    <!--                                                                   -->
    <!-- 5 Sept 2015 KJE: Added change log.                                -->
    <!-- 31 Jan 2016 KJE: Replaced call to deprecated template             -->
    <!-- 01 Feb 2016 KJE: Implemented OASIS redesign for committee note:   -->
    <!--                  removed content of default header                -->
    <!--                                                                   -->
    <!-- ================================================================= --> 
    
    <!-- HEADERS -->
    
    <!-- Headers: Default header -->
    <xsl:template name="defaultHeader">
        <fo:block xsl:use-attribute-sets="default_header">
        </fo:block>
    </xsl:template>
    
    <!-- Headers: Insert headers templates -->
    <xsl:template name="insertBodyOddHeader">
        <fo:static-content flow-name="odd-body-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertBodyEvenHeader">
        <fo:static-content flow-name="even-body-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertBodyFirstHeader">
        <fo:static-content flow-name="first-body-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertBodyLastHeader">
        <fo:static-content flow-name="last-body-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertFrontMatterOddHeader">
        <fo:static-content flow-name="odd-frontmatter-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertFrontMatterEvenHeader">
        <fo:static-content flow-name="even-frontmatter-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertFrontMatterLastHeader">
        <fo:static-content flow-name="last-frontmatter-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertTocOddHeader">
        <fo:static-content flow-name="odd-toc-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertTocEvenHeader">
        <fo:static-content flow-name="even-toc-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertPrefaceOddHeader">
        <fo:static-content flow-name="odd-body-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertPrefaceEvenHeader">
        <fo:static-content flow-name="even-body-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertPrefaceFirstHeader">
        <fo:static-content flow-name="first-body-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertPrefaceLastHeader">
        <fo:static-content flow-name="last-body-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertIndexOddHeader">
        <fo:static-content flow-name="odd-index-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertIndexEvenHeader">
        <fo:static-content flow-name="even-index-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertGlossaryOddHeader">
        <fo:static-content flow-name="odd-glossary-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertGlossaryEvenHeader">
        <fo:static-content flow-name="even-glossary-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertBackCoverOddHeader">
        <fo:static-content flow-name="odd-back-cover-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertBackCoverEvenHeader">
        <fo:static-content flow-name="even-back-cover-header">
            <xsl:call-template name="defaultHeader"/>
        </fo:static-content>
    </xsl:template>
    
    <!-- FOOTERS -->
    
    <!-- Footers: Default footer -->
    <xsl:template name="defaultFooter">
        <fo:block border-top-style="solid" 
            border-top-width="1px"
            margin-bottom="0.18in" 
            margin-left="1.25in" 
            margin-right="1.25in"
            padding-top="2pt">
            <fo:table width="100%">
                <fo:table-column/>
                <fo:table-column/>
                <fo:table-column/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <!-- abbreviated document name -->
                            <fo:block xsl:use-attribute-sets="default_footer">
                                <xsl:value-of select="$inputfile.basename"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <!-- Level of committee note -->
                            <!--<fo:block xsl:use-attribute-sets="default_footer" text-align="center">
                                <xsl:value-of select="$cnLevel"/>
                            </fo:block>-->
                        </fo:table-cell>
                        <fo:table-cell>
                            <!-- approval date -->
                            <fo:block xsl:use-attribute-sets="default_footer" text-align="right">
                                <xsl:value-of select="$oasis-date"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <!-- copyright statement -->
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="default_footer">
                                <xsl:value-of select="$ditaproduct"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="default_footer" text-align="center">Copyright © OASIS Open
                                <xsl:value-of select="$copyright-year"/>. All Rights Reserved.</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <!-- page number; the "__fo__root" attribute set passes an id of value "fo-root-do-not-change, which makes time travel possible. -->
                            <fo:block xsl:use-attribute-sets="default_footer" text-align="right">
                                <fo:inline>
                                    <xsl:text>Page </xsl:text>
                                    <fo:page-number/>
                                    <xsl:text> of </xsl:text>
                                    <fo:page-number-citation-last ref-id="fo-root-do-not-change"/>
                               </fo:inline>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
    
    <!-- Footers: Insert footer templates -->

    <xsl:template name="insertBodyFirstFooter">
        <fo:static-content flow-name="first-body-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertBodyLastFooter">
        <fo:static-content flow-name="last-body-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertBodyOddFooter">
        <fo:static-content flow-name="odd-body-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertBodyEvenFooter">
        <fo:static-content flow-name="even-body-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertTocOddFooter">
        <fo:static-content flow-name="odd-toc-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertTocEvenFooter">
        <fo:static-content flow-name="even-toc-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertIndexOddFooter">
        <fo:static-content flow-name="odd-index-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertIndexEvenFooter">
        <fo:static-content flow-name="even-index-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertPrefaceFirstFooter">
        <fo:static-content flow-name="first-body-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertPrefaceLastFooter">
        <fo:static-content flow-name="last-body-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertPrefaceOddFooter">
        <fo:static-content flow-name="odd-body-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertPrefaceEvenFooter">
        <fo:static-content flow-name="even-body-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertFrontMatterLastFooter">
        <fo:static-content flow-name="last-frontmatter-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertFrontMatterFootnoteSeparator">
        <fo:static-content flow-name="xsl-footnote-separator">
            <fo:block>
                <fo:leader xsl:use-attribute-sets="__body__footnote__separator"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertFrontMatterOddFooter">
        <fo:static-content flow-name="odd-frontmatter-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertFrontMatterEvenFooter">
        <fo:static-content flow-name="even-frontmatter-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template> 
    
    <xsl:template name="insertBackCoverOddFooter">
      <fo:static-content flow-name="odd-back-cover-footer">
          <xsl:call-template name="defaultFooter"/>
      </fo:static-content>
    </xsl:template>
    
    <xsl:template name="insertBackCoverEvenFooter">
      <fo:static-content flow-name="even-back-cover-footer">
          <xsl:call-template name="defaultFooter"/>
      </fo:static-content>
    </xsl:template>

    <xsl:template name="insertGlossaryOddFooter">
        <fo:static-content flow-name="odd-glossary-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="insertGlossaryEvenFooter">
        <fo:static-content flow-name="even-glossary-footer">
            <xsl:call-template name="defaultFooter"/>
        </fo:static-content>
    </xsl:template>

</xsl:stylesheet>