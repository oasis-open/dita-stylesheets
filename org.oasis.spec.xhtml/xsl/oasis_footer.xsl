<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:param name="COVERPAGE"/>
  <!-- Valid link values: online, local -->
  <xsl:param name="LINKS" select="'online'"/>

  <xsl:param name="outputfilebasename"/>
  

  <xsl:output 
    method="xml"
    indent="no"/>

  <xsl:template match="/">
    <div>
      <p />
      <p>
        <xsl:text>Return to </xsl:text>
        <a>
          <xsl:attribute name="href">
            <!--<xsl:choose>
              <xsl:when test="$LINKS = 'online'">
                <xsl:value-of
                  select="
                    /*/*[contains(@class, ' bookmap/bookmeta ')]
                    /*[@outputclass = 'thisVersion']
                    /*[@format = 'html']/@href"
                />
              </xsl:when>
              <xsl:otherwise>-->
                <xsl:value-of select="$COVERPAGE"/>
              <!--</xsl:otherwise>
            </xsl:choose>-->
          </xsl:attribute>
          <xsl:text>main page</xsl:text>
        </a>
        <xsl:text>.</xsl:text>
      </p>
      <table class="footer-table">
        <colgroup>
          <col width="25%"/>
          <col width="55%"/>
          <col width="20%"/>
        </colgroup>
        <tr>
        <td class="footer-left">
            <p><xsl:value-of select="$outputfilebasename"/></p>
            <p><xsl:text>Standards Track Work Product</xsl:text></p>
        </td>
        <td class="footer-center">
        <xsl:text>
Copyright © OASIS Open </xsl:text>
        <xsl:choose>
              <xsl:when
                test="
                  not(normalize-space((/*/*[contains(@class, ' bookmap/bookmeta ')]
                  /*[contains(@class, ' bookmap/bookrights ')]
                  /*[contains(@class, ' bookmap/copyrlast ')]
                  /*[contains(@class, ' bookmap/year ')]))) = ''">
        <xsl:value-of
                  select="
                    /*/*[contains(@class, ' bookmap/bookmeta ')]
                    /*[contains(@class, ' bookmap/bookrights ')]
                    /*[contains(@class, ' bookmap/copyrlast ')]
                    /*[contains(@class, ' bookmap/year ')]"
                />
          </xsl:when>
              <xsl:otherwise>
          <xsl:value-of
                  select="
                    /*/*[contains(@class, ' bookmap/bookmeta ')]
                    /*[contains(@class, ' bookmap/bookrights ')]
                    /*[contains(@class, ' bookmap/copyrfirst ')]
                    /*[contains(@class, ' bookmap/year ')]"
                />
        </xsl:otherwise>
        </xsl:choose>
            <xsl:text>. All Rights Reserved.</xsl:text>
      </td>
          <td class="footer-right">
            <xsl:apply-templates
              select="/*/*[@outputclass = 'specificationTitles']/*[@outputclass = 'specificationApproved']"
            />
          </td>
        </tr>
    </table>

    </div>
  </xsl:template>

  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/xref ')]">
    <a href="{@href}">
      <xsl:choose>
        <xsl:when test="normalize-space(.) != ''"><xsl:apply-templates/></xsl:when>
        <xsl:otherwise><xsl:value-of select="@href"/></xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:choose>
      <xsl:when test="normalize-space(.) = ''"/>
      <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
