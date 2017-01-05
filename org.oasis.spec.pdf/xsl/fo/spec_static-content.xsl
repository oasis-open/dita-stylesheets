<?xml version='1.0'?>
<!-- spec.pdf: Unlike most other XSLT override files in this plugin, this
     template file began with a complete copy of static-content.xsl from the
     org.dita.pdf2 plugin. The static-content template set in org.dita.pdf2
     and the layout-masters template set are already difficult enough to visualize
     without adding a template override layer on top of them.  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

  <xsl:template name="insertBodyStaticContents">
    <xsl:call-template name="insertBodyFootnoteSeparator"/>
    <xsl:call-template name="insertBodyOddFooter"/>
    <xsl:call-template name="insertBodyFirstFooter"/>
    <xsl:call-template name="insertBodyLastFooter"/>
  </xsl:template>

  <xsl:template name="insertTocStaticContents">
    <xsl:call-template name="insertTocOddFooter"/>
  </xsl:template>

  <xsl:template name="insertPrefaceStaticContents">
    <xsl:call-template name="insertPrefaceFootnoteSeparator"/>
    <xsl:call-template name="insertPrefaceOddFooter"/>
    <xsl:call-template name="insertPrefaceFirstFooter"/>
  </xsl:template>

  <xsl:template name="insertFrontMatterStaticContents">
    <xsl:call-template name="insertFrontMatterFootnoteSeparator"/>
    <xsl:call-template name="insertFrontMatterOddFooter"/>
  </xsl:template>

  <xsl:template name="insertBodyFirstFooter">
    <fo:static-content flow-name="first-body-footer">
      <xsl:call-template name="commonOddFooter"/>
    </fo:static-content>
  </xsl:template>

  <xsl:template name="insertBodyLastFooter">
    <fo:static-content flow-name="last-body-footer">
      <xsl:call-template name="commonOddFooter"/>
    </fo:static-content>
  </xsl:template>

  <xsl:template name="insertBodyFootnoteSeparator">
    <fo:static-content flow-name="xsl-footnote-separator">
      <fo:block>
        <fo:leader xsl:use-attribute-sets="__body__footnote__separator"/>
      </fo:block>
    </fo:static-content>
  </xsl:template>

  <xsl:template name="insertBodyOddFooter">
    <fo:static-content flow-name="odd-body-footer">
      <xsl:call-template name="commonOddFooter"/>
    </fo:static-content>
  </xsl:template>

  <xsl:template name="insertTocOddFooter">
    <fo:static-content flow-name="odd-toc-footer">
      <xsl:call-template name="commonOddFooter"/>
    </fo:static-content>
  </xsl:template>

  <xsl:template name="insertIndexOddFooter">
    <fo:static-content flow-name="odd-index-footer">
      <xsl:call-template name="commonOddFooter"/>
    </fo:static-content>
  </xsl:template>

  <xsl:template name="insertPrefaceFirstFooter">
    <fo:static-content flow-name="first-body-footer">
      <xsl:call-template name="commonOddFooter"/>
    </fo:static-content>
  </xsl:template>

  <xsl:template name="insertPrefaceLastFooter">
    <fo:static-content flow-name="last-body-footer">
      <xsl:call-template name="commonOddFooter"/>
    </fo:static-content>
  </xsl:template>

  <xsl:template name="insertPrefaceFootnoteSeparator">
    <fo:static-content flow-name="xsl-footnote-separator">
      <fo:block>
        <fo:leader xsl:use-attribute-sets="__body__footnote__separator"/>
      </fo:block>
    </fo:static-content>
  </xsl:template>

  <xsl:template name="insertPrefaceOddFooter">
    <fo:static-content flow-name="odd-body-footer">
      <xsl:call-template name="commonOddFooter"/>
    </fo:static-content>
  </xsl:template>

  <xsl:template name="insertFrontMatterLastFooter">
    <fo:static-content flow-name="last-frontmatter-footer">
      <fo:block xsl:use-attribute-sets="__body__last__footer"> </fo:block>
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
      <xsl:call-template name="commonOddFooter"/>
    </fo:static-content>
  </xsl:template>


  <xsl:template name="insertBackCoverOddFooter">
    <fo:static-content flow-name="odd-back-cover-footer">
      <xsl:call-template name="commonOddFooter"/>
    </fo:static-content>
  </xsl:template>

  <xsl:template name="insertGlossaryOddFooter">
    <fo:static-content flow-name="odd-glossary-footer">
      <xsl:call-template name="commonOddFooter"/>
    </fo:static-content>
  </xsl:template>

  <xsl:template name="commonOddFooter">
    <fo:block xsl:use-attribute-sets="footer__block">
      <fo:table width="100%">
        <fo:table-column/>
        <fo:table-column/>
        <fo:table-column/>
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell>
              <!-- abbreviated document name -->
              <fo:block xsl:use-attribute-sets="common__footer">
                <xsl:value-of select="$ditaversion"/>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block/>
            </fo:table-cell>
            <fo:table-cell>
              <!-- approval date -->
              <fo:block xsl:use-attribute-sets="common__footer" text-align="right">
                <xsl:value-of select="$oasis-date"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row>
            <!-- copyright statement -->
            <fo:table-cell>
              <fo:block xsl:use-attribute-sets="common__footer">
                <xsl:value-of select="$ditaproduct"/>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block xsl:use-attribute-sets="common__footer">Copyright © OASIS Open <xsl:value-of
                  select="$copyright-year"/>. All Rights Reserved.</fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <!-- page number; the "__fo__root" attribute set passes an id of value "fo-root-do-not-change, which makes time travel possible. -->
              <fo:block xsl:use-attribute-sets="common__footer" text-align="right">
                <fo:inline>
                  <xsl:text>Page </xsl:text>
                  <fo:page-number/>
                  <xsl:text> of </xsl:text>
                  <fo:page-number-citation-last ref-id="fo-root-do-not-change"/>
                  <!-- <fo:page-number-citation-last ref-id="fo-root-do-not-change"/> -->
                </fo:inline>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
